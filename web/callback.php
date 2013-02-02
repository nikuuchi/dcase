<?php

require_once('config.php');
require_once('utils.php');
require_once('twitteroauth/twitteroauth.php');

session_start();

$oauth = new TwitterOAuth(CONSUMER_KEY, CONSUMER_SECRET, $_SESSION['oauth_token'], $_SESSION['oauth_token_secret']);

$accessToken = $oauth->getAccessToken($_GET['oauth_verifier']);

$me = $oauth->get('account/verify_credentials');

// DBに突っ込む

connectDb();

$q = sprintf("select * from users where twitter_user_id='%s' limit 1", r($me->id_str));
$rs = mysql_query($q);
$user = mysql_fetch_assoc($rs);

if (empty($user)) {
    // 新しくユーザー情報を挿入
    $q = sprintf("insert into users (twitter_user_id, twitter_screen_name, twitter_profile_image_url, twitter_access_token, twitter_access_token_secret, created, modified) values ('%s', '%s', '%s', '%s', '%s', now(), now());",
            r($me->id_str),
            r($me->screen_name),
            r($me->profile_image_url),
            r($accessToken['oauth_token']),
            r($accessToken['oauth_token_secret']));
    $rs = mysql_query($q);
    // $userにその情報をセット
    $q = sprintf("select * from users where id=%d limit 1", mysql_insert_id());
    $rs = mysql_query($q);
    $user = mysql_fetch_assoc($rs);
}

session_regenerate_id(true);
$_SESSION['user'] = $user;

jump('');

?>
