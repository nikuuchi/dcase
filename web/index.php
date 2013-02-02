<?php

require_once('config.php');
require_once('utils.php');
require_once('twitteroauth/twitteroauth.php');

session_start();

if (empty($_SESSION['user'])) {
    jump('login.php');
}

// twitterからタイムライン取得

$oauth = new TwitterOAuth(CONSUMER_KEY, CONSUMER_SECRET, $_SESSION['user']['twitter_access_token'], $_SESSION['user']['twitter_access_token_secret']);

$tweets = $oauth->get('statuses/home_timeline');

?>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>ホーム画面</title>
</head>
<body>
<p><img src="<?php echo h($_SESSION['user']['twitter_profile_image_url']); ?>"><?php echo h($_SESSION['user']['twitter_screen_name']); ?>としてログインしています。 <a href="logout.php">ログアウト</a></p>

<ul>
<?php foreach ($tweets as $tweet) : ?>
<?php if (!$tweet->user->protected) : ?>
<li><?php echo h($tweet->text); ?></li>
<?php endif; ?>
<?php endforeach; ?>
</ul>

</body>
</html>
