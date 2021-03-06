<?php snippet('header') ?>
<?php snippet('navigation') ?>

    <main class="main">

    <?php if($page->slug() == "maak-een-meter"): ?>
      <a href="/english"><img src="/assets/images/english.svg" style="float:right;position:relative;top:-30px;"/></a>
    <?php endif; ?>

    <?php if(!empty($page->text())): ?>
		   <?php echo $page->text()->kirbytext() ?>
	  <?php endif; ?>

    <?php foreach($page->children()->visible() as $info): ?>
        <div class="information__block flex flex__wrap flex__center">
          <figure class="full__height half__width flex flex__center">
            <img src="<?php echo $info->image($info->infoimage())->url() ?>" alt="<?php echo $info->title()->html() ?> image">
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
                <a href="<?php echo $info->document($info->download())->url() ?>" target="_blank" class="download__btn"><span class="download__icon"></span> <?php echo $info->title()->html() ?></a>
              </div>
            </div>
          </div>
        </div>
      </figure>
    <?php endforeach ?>
  </main>
<?php snippet('footer') ?>
