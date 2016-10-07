<?php snippet('header') ?>
<?php snippet('navigation') ?>
<header class="hero__header full__width flex flex__wrap">
  <div class="introduction default full__width text__center flex flex__center">
    <div class="decoration leftdec"></div>
    <div class="intro__inner">
      <div class="introdescription">
        <?php echo $page->text()->kirbytext() ?>
      </div>
    </div>
    <div class="decoration rightdec"></div>
  </div>
</header>

<?php snippet('footer') ?>
