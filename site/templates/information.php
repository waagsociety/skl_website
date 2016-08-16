<?php snippet('header') ?>
<?php snippet('navigation') ?>
  <main class="main">
    <?php foreach($page->children()->visible() as $info): ?>
        <div class="information__block flex flex__wrap">
          <figure class="full__height half__width flex flex__center">
            <img src="<?php echo url(); ?>/content/<?php echo $info->diruri() ?>/<?php echo html($info->infoimage()) ?>" alt="<?php echo $info->title()->html() ?> image">
          </figure>
          <div class="half__width big__padding flex flex__center">
            <div>
              <h2><?php echo $info->title()->html() ?></h2>
              <?php echo $info->text()->kirbytext() ?>
              <a href="#" class="btn">Download bestanden</a>
              <a href="#" class="btn">Wat kom je te weten?</a>
            </div>
          </div>
        </div>
      </figure>
    <?php endforeach ?>
  </main>
<?php snippet('footer') ?>
