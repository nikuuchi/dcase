<?php include_once("./utils.php"); ?>
    <div class="navbar navbar-fixed-top navbar-inverse">
      <div class="navbar-inner">
        <div class="container">
          <a class="brand" href="#"><?php echo(PROJECT_NAME); ?></a>
          <ul class="nav">
            <li>
              <a href="#">Home</a>
            </li>
            <li>
              <a href="#">About</a>
            </li>
            <li>
              <a href="#">Contact</a>
            </li>
            <li>
              <a href="viewer.php">View</a>
            </li>

          </ul>
<?php
    if (empty($_SESSION['user'])) {
        echo ('<a href="redirect.php"><img src="assets/img/sign-in-with-twitter.png" alt="Sign in with Twitter"/></a>');
    } else {
        $img  = h($_SESSION['user']['twitter_profile_image_url']);
        $name = h($_SESSION['user']['twitter_screen_name']);
        echo ('<div class="navbar-form pull-right">');
        echo ('    <ul class="nav nav-pills">');
        echo ('        <li class="dropdown">');
        echo ('            <a class="dropdown-toggle" data-toggle="dropdown" href="#">');
        echo ('                <img width="16" height="16" src="'.$img.'" />'.$name);
        echo ('                <b class="caret"></b>');
        echo ('            </a>');
        echo ('            <ul class="dropdown-menu">');
        echo ('                 <a href="logout.php">LogOut</a>');
        echo ('            </ul>');
        echo ('        </li>');
        echo ('    </ul>');
        echo ('</div>');
    }
?>
        </div>
      </div>
    </div>
