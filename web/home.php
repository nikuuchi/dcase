<?php include_once("template/header.php"); ?>
    <div class="container-fluid">
      <div class="row-fluid">
        <div class="span2">
          <div class="well sidebar-nav">
            <?php
            $img  = h($_SESSION['user']['twitter_profile_image_url']);
            $name = h($_SESSION['user']['twitter_screen_name']);
            echo ('<img width="128" height="128" src="'.$img.'" alt="'.$name.'" />');
            echo ('<h3>'.$name.'</h3>');
            ?>
            <div class="row-fluid">
            <form class="navbar-search pull-right">
                <input type="text" class="span6">
                <button type="submit" class="btn">Create New</button>
            </form>
            </div>
            <div class="row-fluid">
            <ul class="nav nav-list">
              <li class="nav-header">My DCase</li>
              <li><a href="#">imasahiro/dcase_test1</a></li>
              <li><a href="#">imasahiro/dcase_test2</a></li>
              <li><a href="#">imasahiro/dcase_test3</a></li>
              <li><a href="#">imasahiro/dcase_test4</a></li>
            </ul>
            </div>
          </div>
        </div>
        <div class="span6">
<?php
class Repository {
    public $name = "";
    public $img  = "assets/img/dcase_printing.png";
    public $desc = "";
    public function __construct($name = "", $img = "", $desc = "") {
        $this->name = $name;
        $this->img  = $img ;
        $this->desc = $desc;
    }
}

$data = array(
        new Repository("dcase_test1", "assets/img/dcase_printing.png", "This is my first dcase. We have to do lots of work to implemente this dcase viewer. but ..."),
        new Repository("dcase_test2", "assets/img/dcase_printing.png", "This is my second dcase."),
        new Repository("dcase_test3", "assets/img/dcase_printing.png", "This is my third dcase."),
        new Repository("dcase_test4", "assets/img/dcase_printing.png", "This is my forth dcase."),
        new Repository("dcase_test5", "assets/img/dcase_printing.png", "This is my 5th dcase.")
        );
$view_per_line = 3;
$is_closed = true;
foreach ($data as $key => $repo) {
    if ($key % $view_per_line == 0) {
        echo ('<div class="row-fluid">');
        $is_closed = false;
    }
    echo('<div class="span'.(12 / $view_per_line).'">');
    echo('  <div class="thumbnail">');
    echo('    <div class="caption">');
    echo('      <div class="row-fluid">');
    echo('        <div class="span8">');
    echo('          <h3>'.$repo->name.'</h3>');
?>
                  </div>
                  <div class="span2 offset2">
                    <div class="pull-right">
                      <a href="#"><i class="icon-edit"></i></a>
                      <a href="#"><i class="icon-share"></i></a>
                      <a href="#"><i class="icon-trash"></i></a>
                    </div>
                  </div>
                </div>

<?php
    echo('    </div>');
    echo('    <img class="img-polaroid" width="145" height="145" src="'.$repo->img.'" />');
    echo('    <div class="caption">');
    echo('      <p>'. $repo->desc.'</p>');
    echo('    </div>');
    echo('  </div>');
    echo('</div>');
    if ($key % $view_per_line == ($view_per_line - 1)) {
        echo ('</div>');
        $is_closed = true;
    }
}
if($is_closed == false) {
    echo ('</div>');
}
?>
          <hr>
          <div>
            (C)Company 2012
          </div>
        </div>
      </div>
    </div>

<?php include_once("./template/footer.php"); ?>
