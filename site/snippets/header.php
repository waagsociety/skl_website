<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1.0">
  <title><?php echo $site->title()->html() ?> | <?php echo $page->title()->html() ?></title>
  <meta name="description" content="<?php echo $site->description()->html() ?>">
  <meta name="keywords" content="<?php echo $site->keywords()->html() ?>">
  <meta name="author" content="Martin Risseeuw">
  <?php echo css('assets/css/main.css') ?>
  <?php snippet('favicons') ?>
  <script src="https://use.typekit.net/kzn1tml.js"></script>
  <script>try{Typekit.load({ async: true });}catch(e){}</script>
  <?php foreach($script_links as $script_link): ?>
      <script type="text/javascript" src="<?php echo $script_link ?>"></script>
  <?php endforeach ?>
</head>
<body>
