<?php define('VIEWER', true); ?>
<?php include_once("template/header.php"); ?>
    <div class="container-fluid">
      <div class="row-fluid">
        <div class="span3">
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
        <div class="span9">
          <div class="hero-unit">
            <div id="viewer"></div>
          </div>
          <hr>
        </div>
      </div>
    </div>

<?php include_once("./template/footer.php"); ?>
