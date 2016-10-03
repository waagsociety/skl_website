<?php snippet('header') ?>
<?php snippet('navigation') ?>
  <main class="main">
    <?php foreach($page->children()->visible() as $info): ?>
        <div class="information__block flex flex__wrap flex__center">
          <figure class="full__height half__width flex flex__center">
            <img src="<?php echo url(); ?>/content/<?php echo $info->diruri() ?>/<?php echo html($info->infoimage()) ?>" alt="<?php echo $info->title()->html() ?> image">
          </figure>
          <div class="half__width text__block flex flex__center infotje">
            <div>
                <div class="werkblad-icon <?php echo $info->assignment() ?>"></div>
             
            </div>
            <div>
              <header class="flex info__header">
                <h2><?php echo $info->title()->html() ?></h2>
                <div class="category-icon <?php echo $info->category() ?>"></div>
              </header>
              <div class="intro">
                <?php echo $info->text()->kirbytext() ?>
                <a href="#" class="download__btn"><span class="download__icon"></span> <?php echo $info->title()->html() ?></a>
              </div>
            </div>
          </div>
        </div>
      </figure>
    <?php endforeach ?>
  </main>
<?php snippet('footer') ?>
