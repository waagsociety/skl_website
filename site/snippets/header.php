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
  
  <!-- other scripts -->
  <?php if(isset($script_links)): ?> 
  	<?php foreach($script_links as $script_link): ?> 
		<?php echo js($script_link) ?>
  	<?php endforeach ?>
  <?php endif ?>
  
  <!-- other styles -->
  <?php if(isset($style_links)): ?> 
  	<?php foreach($style_links as $style_link): ?>
  		<?php echo css($style_link) ?>
  	<?php endforeach ?>
  <?php endif ?>
  
  <!-- Piwik -->
  <script type="text/javascript">
  	var _paq = _paq || [];
  	_paq.push(["setDomains", ["*.smartkidslab.nl"]]);
  	_paq.push(['trackPageView']);
  	_paq.push(['enableLinkTracking']);
  	(function() {
	    var u="//stats.waag.org/";
	    _paq.push(['setTrackerUrl', u+'piwik.php']);
	    _paq.push(['setSiteId', '9']);
	    var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
	    g.type='text/javascript'; g.async=true; g.defer=true; g.src=u+'piwik.js'; s.parentNode.insertBefore(g,s);
	})();
  </script>
  <noscript><p><img src="//stats.waag.org/piwik.php?idsite=9" style="border:0;" alt="" /></p></noscript>
  <!-- End Piwik Code -->

</head>
<body>
