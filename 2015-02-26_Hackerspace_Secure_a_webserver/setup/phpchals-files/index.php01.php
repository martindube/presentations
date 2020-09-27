<?php
    $shortName = '01';
    $num = '0x01';
?>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Hackfest 2014 - PHP Challenges</title>

    <!-- Bootstrap -->
    <link href="/static/css/bootstrap.min.css" rel="stylesheet">

    <!-- HF CSS -->
    <link href="/static/css/web.css" rel="stylesheet">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  <body>
    <div class="site-wrapper">

      <div class="site-wrapper-inner">

        <div class="cover-container">

          <div class="masthead clearfix">
            <div class="inner">
              <h3 class="masthead-brand">PHP Challenges</h3>
              <ul class="nav masthead-nav">
                <li <?php echo ($shortName == '01' ? 'class="active"' : '') ?>><a href="/01/">0x01</a></li>
                <li <?php echo ($shortName == '02' ? 'class="active"' : '') ?>><a href="/02/">0x02</a></li>
                <li <?php echo ($shortName == '03' ? 'class="active"' : '') ?>><a href="/03/">0x03</a></li>
                <li <?php echo ($shortName == '04' ? 'class="active"' : '') ?>><a href="/04/">0x04</a></li>
                <li <?php echo ($shortName == '05' ? 'class="active"' : '') ?>><a href="/05/">0x05</a></li>
                <li <?php echo ($shortName == '06' ? 'class="active"' : '') ?>><a href="/06/">0x06</a></li>
              </ul>
            </div>
          </div>

          <div class="inner cover">
            <h1 class="cover-heading">Challenge <?php echo $num; ?></h1>
            <p class="lead">Warmp up: A classical.</p>
            <p>Goal: Get the flag in /flag.txt</p>

            <form class="form-signin" role="form" method="GET" action="/<?php echo $shortName; ?>/php01.php">
              <button class="btn btn-lg btn-default btn-block" type="submit">Exploit</button>
            </form>
          </div>

          <div class="mastfoot">
            <div class="inner">
              <p>&copy; Hackfest 2014</p>
            </div>
          </div>

        </div>

      </div>

    </div>
  </body>
</html>

