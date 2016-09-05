<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1.0">
  <title><?php echo $site->title()->html() ?> | <?php echo $page->title()->html() ?></title>
  <meta name="description" content="<?php echo $site->description()->html() ?>">
  <meta name="keywords" content="<?php echo $site->keywords()->html() ?>">
  <meta name="author" content="Martin Risseeuw">
  <?php snippet('favicons') ?>
  <script src="https://use.typekit.net/kzn1tml.js"></script>
  <script>try{Typekit.load({ async: true });}catch(e){}</script>
  <?php if ( isset($script_links) ) : ?>
  	<?php foreach($script_links as $script_link): ?>
		<?php echo js($script_link) ?>
  	<?php endforeach ?>
  <?php endif ?>
  <?php if ( isset($style_links) ) : ?>
  	<?php foreach($style_links as $style_link): ?>
		<?php echo css($style_link) ?>
  	<?php endforeach ?>
  <?php endif ?>
</head>
<body>
