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
<div class="span3" id="left_menu">
  <ul class="nav nav-tabs">
    <li class="active">
      <a href="#">Click Me</a>
    </li>
    <li class="">
      <a href="#">Click Me</a>
    </li>
    <li class="">
      <a href="#">Click Me</a>
    </li>
  </ul>
  <div class="well">
    <div class="control-group">
      <label for="selectinput1">
        Label
      </label>
      <select name="selectinput1">
      </select>
    </div>
    <div class="control-group">
      <label for="selectinput2">
        Label
      </label>
      <select name="selectinput2">
      </select>
    </div>
    <div class="control-group">
      <label for="textinput3">
        Label
      </label>
      <input name="textinput3" type="">
    </div>
    <div class="control-group">
      <label for="textarea1">
        Label
      </label>
      <textarea name="textarea1"></textarea>
    </div>
    <div class="control-group">
      <label for="fileinput1">
        Label
      </label>
      <input name="fileinput1" type="file">
    </div>
    <a href="#">Click Me</a>
  </div>
</div>

<div class="row-fluid">
  <div class="span9">
    <div class="hero-unit">
      <div id="viewer"></div>
    </div>
    <hr>
  </div>
</div>

  <script type="text/javascript" src="assets/js/jquery-1.9.0.min.js"></script>
  <script type="text/javascript" src="assets/js/jquery-ui-1.8.13.min.js"></script>
  <script type="text/javascript" src="assets/js/jquery.sidebar.js"></script>
  <script type="text/javascript" src="assets/js/bootstrap.js"></script>
  <script type="text/javascript">
    $("div#left_menu").sidebar();
  </script>

  </body>
</html>
