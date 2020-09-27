#!/bin/ksh

TPL_FOLDER='./phpchals-files'
NGINX_TPL_FOLDER=$TPL_FOLDER'/vhost-tpl'
NGINX_TPL_FILE=$TPL_FOLDER'/nginx.tpl.conf'
PHP_FPM_TPL_FILE=$TPL_FOLDER'/php-fpm.tpl.conf'
STATIC_FOLDER=$TPL_FOLDER'/static'
NGINX_CONFIG_FOLDER='/etc/nginx/conf.d'
NGINX_VHOST_FOLDER='/var/www/htdocs'
NGINX_STATIC_FOLDER=$NGINX_VHOST_FOLDER'/static'
PHP_FPM_FOLDER='/etc/php-fpm-pool.d'
NGINX_GROUP='www'

. ./functions-bsd64.sh
#
# MAIN
#
initChroot
initSSHChrootEnv
createStaticFolder

# Description: Hack c99.php shell to pop the flag.
CHAL_NAME='chal01'
CHAL_USER='_www1'
CHAL_PHP_PORT='9000'
CHAL_DIS_FUNC='dl,exec,passthru,shell_exec,system,proc_open,popen,curl_exec,curl_multi_exec,parse_ini_file,show_source,include,include_once,require,require_once,file_get_contents,readfile,fopen,fread,fwrite,fsockopen,socket_create,stream_socket_client,stream_socket_server'
CHAL_FLAG='FLAG-ZYfynIT9LvpoiadmmeNAtIOC8v1EPZhJ'
/usr/sbin/userinfo $CHAL_USER > /dev/null
if [ $? -eq 1 ]; then
    chrDir=$NGINX_VHOST_FOLDER'/'$CHAL_NAME
    chalFile=$chrDir'/var/www/'$CHAL_NAME'.php'
    flagFile=$chrDir'/flag.txt'
    indexFile=$chrDir'/var/www/index.php'

    createNginxChroot $CHAL_NAME $CHAL_USER $CHAL_PHP_PORT $CHAL_DIS_FUNC

    /bin/cp $TPL_FOLDER'/c99.php' $chalFile
    /sbin/chown root:$CHAL_USER $chalFile
    /bin/chmod 440 $chalFile

    /bin/echo "$CHAL_FLAG" > $flagFile
    /sbin/chown root:$CHAL_USER $flagFile
    /bin/chmod 440 $flagFile

    /bin/cp $TPL_FOLDER'/index.'$CHAL_NAME'.php' $indexFile
    /sbin/chown root:$CHAL_USER $indexFile
    /bin/chmod 440 $indexFile

    /etc/rc.d/nginx restart
    /etc/rc.d/php_fpm restart
fi

# Description: Hack c99.php shell to pop the flag.
CHAL_NAME='chal02'
CHAL_USER='_www2'
CHAL_PHP_PORT='9001'
CHAL_DIS_FUNC='dl,exec,passthru,shell_exec,system,proc_open,popen,curl_exec,curl_multi_exec,parse_ini_file,show_source,include,include_once,require,require_once,file_get_contents,readfile,fopen,fread,fwrite,fsockopen,socket_create,stream_socket_client,stream_socket_server'
CHAL_FLAG='FLAG-P2nxFor2SKSwDiBOoO1TJf8VEmBdMaNT'
/usr/sbin/userinfo $CHAL_USER > /dev/null
if [ $? -eq 1 ]; then
    chrDir=$NGINX_VHOST_FOLDER'/'$CHAL_NAME
    chalFile=$chrDir'/var/www/'$CHAL_NAME'.php'
    flagFile=$chrDir'/flag.txt'
    indexFile=$chrDir'/var/www/index.php'

    createNginxChroot $CHAL_NAME $CHAL_USER $CHAL_PHP_PORT $CHAL_DIS_FUNC

    /bin/cp $TPL_FOLDER'/c99.php' $chalFile
    /sbin/chown root:$CHAL_USER $chalFile
    /bin/chmod 440 $chalFile

    /bin/echo "$CHAL_FLAG" > $flagFile
    /sbin/chown root:$CHAL_USER $flagFile
    /bin/chmod 440 $flagFile

    /bin/cp $TPL_FOLDER'/index.'$CHAL_NAME'.php' $indexFile
    /sbin/chown root:$CHAL_USER $indexFile
    /bin/chmod 440 $indexFile

    /etc/rc.d/nginx restart
    /etc/rc.d/php_fpm restart
fi

# Description: Find the flag using gcc, on a systrace protected shell.
CHAL_NAME='ssh03'
CHAL_USER='ssh03'
CHAL_PASS=$CHAL_FLAG
CHAL_SHELL='/bin/hfsh'
if [ 0 -eq 1 ]; then
    chrDir=$SSH_FOLDER'/'$CHAL_NAME
    flagPath=$SSH_FOLDER'/'$CHAL_USER'/flag.txt'
    srcShell='chroot01/hfsh.c'
    binShell='chroot01/hfsh'
    policyPath='chroot01/'$CHAL_NAME'.bin_ksh'
    dPolicyPath=$chrDir'/home/'$CHAL_USER'/.systrace/bin_ksh'
    policyLogPath=$chrDir'/var/log/systrace.log'

    /bin/echo 'Compiling hfsh'
    gcc $srcShell -o $binShell
    /bin/cp $binShell '/bin/hfsh'

    createSSHChroot $CHAL_NAME $CHAL_USER $CHAL_PASS $CHAL_SHELL
    addSecuredTmp $chrDir $CHAL_USER

    /bin/echo 'Flag: '$CHAL_FLAG > $flagPath
    /sbin/chown root:$CHAL_USER $flagPath
    /bin/chmod 740 $flagPath

    /bin/echo 'Copying policy file'
    /bin/cp $policyPath $dPolicyPath
    /sbin/chown root:$CHAL_USER $dPolicyPath
    /bin/chmod 740 $dPolicyPath

    /bin/echo 'Create systrace log file'
    /usr/bin/touch $policyLogPath
    /sbin/chown root:$CHAL_USER $policyLogPath
    /bin/chmod 760 $policyLogPath

    addBinaryToChroot '/bin/ksh' $chrDir
    addBinaryToChroot '/bin/hfsh' $chrDir
    addBinaryToChroot '/bin/ls' $chrDir
    addBinaryToChroot '/bin/cat' $chrDir
    addBinaryToChroot '/usr/bin/touch' $chrDir
    addBinaryToChroot '/bin/mkdir' $chrDir
    addBinaryToChroot '/usr/bin/gcc' $chrDir
    addBinaryToChroot '/bin/systrace' $chrDir
    addBinaryToChroot '/usr/local/bin/vim' $chrDir
    addBinaryToChroot '/usr/bin/id' $chrDir
fi

