<nav class="main__navigation full__width flex flex__wrap flex__center">
  <ul class="main__navigation__list flex full__width">
    <li class="logo__list"><a href="/" class="main__logo">home</a></li>
    <?php foreach($pages->visible() as $p): ?>
    <li class="main__navigation__list__item">
      <a <?php e($p->isOpen(), ' class="active"') ?> href="<?php echo $p->url() ?>">
      <span class="menu__icon" style="background-image: url(<?php echo $p->contentURL() ?>/<?php echo $p->pageicon() ?>)"></span>
      <?php echo $p->title()->html() ?></a>
    </li>
    <?php endforeach ?>
  </ul>
</nav>
<div class="content__container">
