<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0">
  <title><?php echo $site->title()->html() ?> | <?php echo $page->title()->html() ?></title>
  <meta name="description" content="<?php echo $site->description()->html() ?>">
  <meta name="keywords" content="<?php echo $site->keywords()->html() ?>">
  <meta name="author" content="Martin Risseeuw">
  <?php echo css('assets/css/main.css') ?>
  <?php snippet('favicons') ?>
  <link href="http://fonts.googleapis.com/css?family=Sue+Ellen+Francisco" rel="stylesheet">
  <script src="https://use.typekit.net/kzn1tml.js"></script>
  <script>try{Typekit.load({ async: true });}catch(e){}</script>
</head>
<body>
