#!/bin/ksh

#
# VARS
#
SSH_FOLDER='/home'
SSH_GROUP='_ssh'

#
# FUNCTIONS
#

initChroot(){
    # Disable nodev and nosuid flags for partitions /home and /var

}

# This should be run only once per server.
initSSHChrootEnv(){
    # Setup SSH to chroot ssh group
    echo Force ssh group to be chrooted
    if [[ -z "`grep "Match Group $SSH_GROUP" /etc/ssh/sshd_config`" ]];then
        echo '# Chroot setup for games' >> /etc/ssh/sshd_config
        echo "Match Group $SSH_GROUP" >> /etc/ssh/sshd_config
        echo '    ChrootDirectory %h' >> /etc/ssh/sshd_config
        echo '    X11Forwarding no' >> /etc/ssh/sshd_config
        echo '    AllowTcpForwarding no' >> /etc/ssh/sshd_config
        /etc/rc.d/sshd restart
    fi

    # Create ssh group if not exist
    /usr/sbin/groupinfo $SSH_GROUP > /dev/null
    if [ $? -eq 1 ]; then
        /usr/sbin/groupadd $SSH_GROUP
    fi

    # Add rksh to /etc/shells if not exist
    echo Add rksh to /etc/shells if not exist
    if [[ -z "`grep "/bin/rksh" /etc/shells`" ]];then
        echo '/bin/rksh' >> /etc/shells
        echo '/bin/hfsh' >> /etc/shells
    fi
}

createNginxChroot(){
    name=$1
    user=$2
    php_port=$3
    dis_func=$4

    /usr/sbin/userinfo $user > /dev/null
    if [ $? -eq 0 ]; then
        /bin/echo Not creating chal $name because $user user already exist
        return 0
    fi

    /bin/echo Creating web chroot $name
    /bin/mkdir $NGINX_VHOST_FOLDER'/'$name

    /bin/echo Creating user $user
    adduser -batch $user '' 'User for '$name '' -shell nologin -uid_start 2000 -v -s
    
    /bin/echo Copying nginx tpl folder to $NGINX_VHOST_FOLDER'/'$name
    /bin/cp -Rf $NGINX_TPL_FOLDER/* $NGINX_VHOST_FOLDER'/'$name'/'
    /bin/echo cp done. Setting ACLs on folders
    /sbin/chown -R root:$user $NGINX_VHOST_FOLDER'/'$name
    /usr/bin/find $NGINX_VHOST_FOLDER'/'$name -type d -exec /bin/chmod 550 {} \;
    /bin/echo Setting ACLs on files
    /usr/bin/find $NGINX_VHOST_FOLDER'/'$name -type f -exec /bin/chmod 440 {} \;

#    /bin/echo Copying nginx config to $NGINX_CONFIG_FOLDER'/'$name'.conf'
#    /usr/bin/sed -e 's/\$CHAL_NAME/'$name'/' \
#        -e 's/\$PHP_FPM_PORT/'$php_port'/' \
#    $NGINX_TPL_FILE > $NGINX_CONFIG_FOLDER'/'$name'.conf'

    /bin/echo Copying php config to $PHP_FPM_FOLDER'/'$name'.conf'
    /usr/bin/sed -e 's/\$CHAL_NAME/'$name'/' \
        -e 's/\$POOL_NAME/'$name'/' \
        -e 's/\$PHP_FPM_PORT/'$php_port'/' \
        -e 's/\$CHAL_USER/'$user'/' \
        -e 's/\$CHAL_DIS_FUNC/'$dis_func'/' \
    $PHP_FPM_TPL_FILE > $PHP_FPM_FOLDER'/'$name'.conf' 
}

createStaticFolder(){
    # Setup /static folder
    echo Copying $NGINX_STATIC_FOLDER to $NGINX_VHOST_FOLDER'/static'
    /bin/cp -R $NGINX_STATIC_FOLDER $NGINX_VHOST_FOLDER'/'
    /sbin/chown root:$NGINX_GROUP $NGINX_VHOST_FOLDER'/static'
    /usr/bin/find $NGINX_VHOST_FOLDER'/static' -type d -exec /bin/chmod 550 {} \;
    /usr/bin/find $NGINX_VHOST_FOLDER'/static' -type f -exec /bin/chmod 440 {} \;
}

createSSHChroot(){
    name=$1
    user=$2
    pass=$3
    shell=$4

    /usr/sbin/userinfo $user > /dev/null
    if [ $? -eq 0 ]; then
        /bin/echo Not creating $name because user already exist
        return 0
    fi

    /bin/echo Creating ssh chroot for user $user
    /bin/mkdir $SSH_FOLDER'/'$user

    /bin/echo Creating user $user
    /usr/sbin/adduser -batch "$user" "$SSH_GROUP" 'User for '$name `/usr/bin/encrypt "$pass"` -shell `echo $shell | cut -d'/' -f 3` -uid_start 2000 -v -s
    
    /bin/echo Creating core folders
    mkdir -p $SSH_FOLDER'/'$user'/'{bin,dev,etc,lib,lib64,usr,usr/lib,usr/include,usr/local/lib,usr/libexec,root,root/.systrace,var,var/log}
    /sbin/chown -R root:wheel $SSH_FOLDER'/'$user
    /bin/chmod -R 755 $SSH_FOLDER'/'$user
   
    /bin/echo Creating some devices 
    cd $SSH_FOLDER'/'$user'/dev'
    /dev/MAKEDEV std systrace
    /bin/rm console klog kmem ksyms mem xf86
    /bin/echo Devices are: `ls`
    cd -

    /bin/echo Setting ACLs on folders
    /sbin/chown -R root:wheel $SSH_FOLDER'/'$user
    /usr/bin/find $SSH_FOLDER'/'$user -type d -exec /bin/chmod 755 {} \;
    /bin/echo Setting ACLs on files
    /usr/bin/find $SSH_FOLDER'/'$user -type f -exec /bin/chmod 644 {} \;

    /bin/echo Creating home folder
    /bin/mkdir -p $SSH_FOLDER'/'$user'/home/'$user
    /bin/mkdir -p $SSH_FOLDER'/'$user'/home/'$user'/.systrace'
    /sbin/chown -R root:$user $SSH_FOLDER'/'$user'/home/'$user
    /usr/bin/find $SSH_FOLDER'/'$user'/home/'$user -type d -exec /bin/chmod 750 {} \;
    /usr/bin/find $SSH_FOLDER'/'$user'/home/'$user -type f -exec /bin/chmod 640 {} \;

    /bin/echo Copying /bin/sh as it\'s needed for many shit.
    addBinaryToChroot '/bin/sh' $SSH_FOLDER'/'$user $user

    /bin/echo Copying a statically-linked shell
    addBinaryToChroot $shell $SSH_FOLDER'/'$user $user
}

addFileToStatic(){
    file=$1
    dst=$2
    /bin/echo Copying $file to $NGINX_STATIC_FOLDER'/'
    /bin/cp $file $NGINX_STATIC_FOLDER'/'$dst
    /sbin/chown root:$NGINX_GROUP $NGINX_STATIC_FOLDER'/'$dst
    /bin/chmod 440 $NGINX_STATIC_FOLDER'/'$dst
}

addBinaryToChroot(){
    binFile=$1
    chrootDir=$2
    user=$3
    
    /bin/echo Copying $binFile to chroot $chrootDir
    /bin/cp $binFile $chrootDir'/bin/'
    
    if [[ -z "`file $binFile | grep 'statically linked'`" ]];then
    	/bin/echo Copying dependencies
    	#cp `ldd $binFile| \
    	#grep -v -e 'bin' -e 'sbin' -e 'Start' | awk '{print $7}'` $chrootDir/lib
    	/usr/bin/ldd $binFile | \
    	/usr/bin/grep -v -e 'bin' -e 'sbin' -e 'Start' | 
        awk '{print $7}' | \
        while read dep; 
        do
            /bin/cp $dep $chrootDir''$dep
            /sbin/chown root:wheel $chrootDir''$dep
            /bin/chmod 755 $chrootDir''$dep
        done;
    fi

    /sbin/chown -R root:wheel $chrootDir/lib
    /bin/chmod -R 755 $chrootDir/lib

    /sbin/chown -R root:wheel $chrootDir'/bin/'`basename $binFile`
    /bin/chmod -R 755 $chrootDir'/bin/'`basename $binFile`
}

addSecuredTmp(){
    chrootDir=$1
    user=$2

    /bin/echo Securing tmp folder so nobody can list content
    tmpDir=$chrootDir'/tmp'
    if [ ! -d $tmpDir ]; then
        /bin/mkdir $tmpDir
    fi

    /sbin/chown root:wheel $tmpDir
    /bin/chmod 753 $tmpDir
}

addPS1(){
    chrootDir=$1
    user=$2
    profilePath=$chrootDir'/home/'$user'/.profile'

    echo Generating a PS1 with genPS1.sh
    ps1=`../deb64-initscript/sh/genPS1.sh -z PUBLIC -o HF`

    if [ ! -f $profilePath ]; then
        touch $profilePath
    fi

    echo Adding PS1 var to .profile
    if [[ -z "`grep PS1 $profilePath`" ]];then
        echo 'PS1="'$ps1'"' >> $profilePath
    else
        /bin/mv $profilePath $profilePath'.bkp'
        /usr/bin/sed -e "s/^PS1\(.*\)$/PS1=\"$ps1\"/" \
                        $profilePath'.bkp' > $profilePath
    fi
}

setUmask(){
    chrootDir=$1
    user=$2
    umaskValue=$3
    profilePath=$chrootDir'/home/'$user'/.profile'

    if [ ! -f $profilePath ]; then
        touch $profilePath
    fi

    echo Adding umask var to .bashrc
    if [[ -z "`grep umask $profilePath`" ]];then
        echo "umask $umaskValue" >> $profilePath
    else
        /bin/mv $profilePath $profilePath'.bkp'
        /usr/bin/sed -e "s/^umask\(.*\)$/umask $umaskValue/" \
                        $profilePath'.bkp' > $profilePath
    fi
}

fixNameResolution(){
    chrootDir=$1
    user=$2

    echo Creating a custom master.passwd file
    grep 'root:' /etc/master.passwd > $chrootDir'/etc/master.passwd'
    grep "$user:" /etc/master.passwd >> $chrootDir'/etc/master.passwd'

    echo Creating a custom group file
    grep 'root:' /etc/group > $chrootDir'/etc/group'
    grep "$user:" /etc/group >> $chrootDir'/etc/group'
}


generateFolderTree(){
    typeset path=$1
    typeset depth=$2
    typeset nbPerLevel=$3
    typeset i=0
    typeset j=0
    
    # Debug
    #echo Path: $path
    #echo Depth: $depth
    #echo Nb per level: $nbPerLevel

    # Create folders
    echo Creating $nbPerLevel folders in $path
    for i in `jot $nbPerLevel`; do
        /bin/mkdir $path/$i > /dev/null
    done;

    # Recursive call
    for j in `jot $nbPerLevel`; do
        if [ "$depth" -gt "1" ]; then
            generateFolderTree "$path/$j" $(($depth - 1)) $nbPerLevel
        fi
    done;

    return 0
}


