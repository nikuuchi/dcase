<?php include_once("template/header.php"); ?>
    <div class="container-fluid">
      <div class="row-fluid">
        <div class="span3">
          <div class="well sidebar-nav">
            <?php
            $img  = h($_SESSION['user']['twitter_profile_image_url']);
            $name = h($_SESSION['user']['twitter_screen_name']);
            echo ('<img width="128" height="128" src="'.$img.'" alt='".$name."' />');
            echo ('<p>'.$name.'</p>');
            ?>
            <form class="navbar-form pull-left">
                <input type="text" class="span2">
                <button type="submit" class="btn">Submit</button>
            </form>
            <ul class="nav nav-list">
              <li class="nav-header">Header</li>
              <li><a href="#">imasahiro/dcase_test1</a></li>
              <li><a href="#">imasahiro/dcase_test2</a></li>
              <li><a href="#">imasahiro/dcase_test3</a></li>
              <li><a href="#">imasahiro/dcase_test4</a></li>
            </ul>
          </div>
        </div>
        <div class="span6">
          <div class="row-fluid">
            <div class="span6">
              <div class="thumbnail">
                <img width="145" height="145" src="assets/img/dcase_printing.jpg" />
                <div class="caption">
                  <h3>dcase_test1</h3>
                  <p>This is my first dcase. We have to do lots of work to implemente this dcase viewer. but ...</p>
                </div>
              </div>
            </div>
            <div class="span6">
              <div class="thumbnail">
                <img width="145" height="145" src="assets/img/dcase_printing.jpg" />
                <div class="caption">
                  <h3>dcase_test2</h3>
                  <p>This is my second dcase.</p>
                </div>
              </div>
            </div>
          </div>

          <div class="row-fluid">
            <div class="span6">
              <div class="thumbnail">
                <img width="145" height="145" src="assets/img/dcase_printing.jpg" />
                <div class="caption">
                  <h3>dcase_test3</h3>
                  <p>This is my third dcase.</p>
                </div>
              </div>
            </div>
            <div class="span6">
              <div class="thumbnail">
                <img width="145" height="145" src="assets/img/dcase_printing.jpg" />
                <div class="caption">
                  <h3>dcase_test4</h3>
                  <p>This is my forth dcase.</p>
                </div>
              </div>
            </div>
          </div>

          <hr>
          <div>
            (C)Company 2012
          </div>
        </div>
      </div>
    </div>

<?php include_once("./template/footer.php"); ?>
