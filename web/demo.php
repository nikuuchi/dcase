<?php
include_once("config.php");
include_once("utils.php");
session_start();
?>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title><?php echo(PROJECT_NAME);?></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <!-- Le styles -->
    <link href="assets/css/bootstrap.css" rel="stylesheet">
    <style>
      body { padding-top: 60px; }
      /* 60px to make the container go all the way to the bottom of the topbar */
    </style>
    <link href="assets/css/bootstrap-responsive.css" rel="stylesheet">
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <link rel="stylesheet" type="text/css" href="assets/css/dark-glass/sidebar.css" />
  </head>
<body>

<ul id="demo_menu1" >
    <li><a href="#" >jQuery</a></li>
    <li><a href="#" >Write</a></li>
    <li><a href="#" >Less</a></li>
    <li><a href="#" >Do</a></li>
    <li><a href="#" >More</a></li>
</ul>

  <script type="text/javascript">
    $("ul#demo_menu1").sidebar();
  </script>
  <script type="text/javascript" src="assets/js/jquery-1.9.0.min.js"></script>
  <script type="text/javascript" src="assets/js/jquery-ui-1.8.13.min.js"></script>
  <script type="text/javascript" src="assets/js/jquery.sidebar.js"></script>
  <script type="text/javascript" src="assets/js/bootstrap.js"></script>

  </body>
</html>
