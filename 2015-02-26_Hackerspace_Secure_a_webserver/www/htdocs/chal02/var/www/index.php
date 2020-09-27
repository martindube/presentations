<?php
    $error = Null;

    if(isset($_GET['a'])){
        $out = @eval($_GET['a']);
        // Show errors
        if (error_get_last()){
            $error = error_get_last();
            echo '
            <strong>Oops!</strong> '.$error['message'].' on file '.$error['file'].' at line '.$error['line'].'
            ';
        }   
        //echo $out;
    }   
?>
<p> Let's say you just found an eval vulnerability on GET parameter "a". Get a shell out of it. </p>
<p> The configuration looks like <a href="phpinfo.php">this</a>, but to summarize:<br/>
<br/>
  - The server can initiate connections everywhere (out rule in pf)<br/>
  - The partition is executable<br/>
  - The file system is mostly readonly but /tmp is writable<br/>
  - exec was removed from disable_functions array <br/>
  - syslog is not configured<br/>
  - domain restriction was removed<br/>
</p>

<form class="form-signin" role="form" method="GET" action="">
    <textarea class="form-control" placeholder="Insert PHP code here." name="a" required /></textarea>
    <button class="btn btn-lg btn-default btn-block" type="submit">Exploit</button>
</form>



