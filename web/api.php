<?php
include_once("config.php");
include_once("utils.php");
session_start();

$api = "";
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
}
else if ($_SERVER['REQUEST_METHOD'] == 'GET') {
}

$request = explode("/", substr(@$_SERVER['PATH_INFO'], 1));

if (empty($_SESSION['user'])) {
    error("Please login with user first");
}

switch ($request[0]) {
    case 'CreateNewRepository':
        break;
    case 'GetRepositoryList':
        GetRepositoryList($request);
        exit;
    default:
    break;
}

function GetRepositoryList($request) {
    $user = h($_SESSION['user']['twitter_screen_name']);
    echo ("RepositoryList\n");
    $repos = array();
    if ($handle = opendir('users/'. $user . '/repos/')) {
        /* ディレクトリをループする際の正しい方法です */
        while (($file = readdir($handle)) !== false) {
            echo ($file);
            //array_push($repos, $file);
        }
        closedir($handle);
    }
}

function CreateNewRepository($request) {
}

function error($error_message) {
    echo($error_message);
    exit();
}
?>
