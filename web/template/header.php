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
    <?php if (defined(VIEWER)): ?>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="css/dcase-node.css"/>
    <link rel="stylesheet" type="text/css" href="css/viewer.css"/>
    <link rel="stylesheet" type="text/css" href="css/sidemenu.css"/>
    <style>
    body {
    	min-height: 480px;
    	margin: 0px;
    }
    #viewer {
    	left: 0px;
    	top : 0px;
    	width : 100%;
    	height: 100%;
    }
    </style>
    <script type="text/javascript" src="lib/jquery.min.js"></script>
    <script type="text/javascript" src="lib/jquery.mousewheel.min.js"></script>
    <script type="text/javascript" src="js/dcaseviewer.js" charset="utf-8"></script>
    <script type="text/javascript" src="js/dnode.js"></script>
    <script type="text/javascript" src="js/dnodeview.js"></script>
    <script type="text/javascript" src="js/handler.js"></script>
    <script type="text/javascript" src="js/edit.js"></script>
    <script type="text/javascript" src="js/sidemenu.js"></script>
    <script type="text/javascript" src="js/api.js"></script>
    <script type="text/javascript" src="js/animation.js"></script>
    <script type="text/javascript">
    
    function getNodeFromServer(id) {
    	var res1 = DCaseAPI.get(["Argument"]);
    	//var id = res1[0].argument_id;
    	//var id = "0";//FIXME
    	console.log("get id=" + id);
    	var res2 = DCaseAPI.get([], id);
    	console.log(res2);
    	var node = createNodeFromJson(res2);
    	return node;
    }
    
    window.addEventListener("load",function() {
    	var node = createSampleNode();
    	var id = "1";
    	//var node = getNodeFromServer(id);
    	var opts = {
    		argument_id: id,
    	};
    	var viewer = new DCaseViewer(document.getElementById("viewer"), node, opts);
    	var menu = new SideMenu(document.body, viewer);
    
    	// hide url bar for ipod touch
    	setTimeout(function(){
    		window.scrollTo(0, 0);
    	}, 0);
    });
    </script>

    <?php endif; ?>
    <link href="assets/css/bootstrap-responsive.css" rel="stylesheet">
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
  </head>
<body>
<?php include_once("navigation.php"); ?>
