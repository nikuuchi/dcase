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
    public $img  = "assets/img/dcase_printing.jpg";
    public $desc = "";
    public function __construct($name = "", $img = "", $desc = "") {
        $this->name = $name;
        $this->img  = $img ;
        $this->desc = $desc;
    }
}

$data = array(
        new Repository("dcase_test1", "assets/img/dcase_printing.jpg", "This is my first dcase. We have to do lots of work to implemente this dcase viewer. but ..."),
        new Repository("dcase_test2", "assets/img/dcase_printing.jpg", "This is my second dcase."),
        new Repository("dcase_test3", "assets/img/dcase_printing.jpg", "This is my third dcase."),
        new Repository("dcase_test4", "assets/img/dcase_printing.jpg", "This is my forth dcase.")
        );
foreach ($data as $key => $repo) {
    if ($key % 2 == 0) {
        echo ('<div class="row-fluid">');
    }
    echo('<div class="span6">');
    echo('  <div class="thumbnail">');
    echo('    <img width="145" height="145" src="'.$repo->img.'" />');
    echo('    <div class="caption">');
    echo('      <h3>'.$repo->name.'</h3>');
    echo('      <p>'. $repo->desc.'</p>');
    echo('    </div>');
    echo('  </div>');
    echo('</div>');
    if ($key % 2 == 1) {
        echo ('</div">');
    }
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
