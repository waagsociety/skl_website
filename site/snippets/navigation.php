<nav class="main__navigation full__width flex flex__wrap flex__center">
  <ul class="main__navigation__list flex full__width">
    <?php foreach($pages->visible() as $p): ?>
    <li class="main__navigation__list__item">
      <a <?php e($p->isOpen(), ' class="active"') ?> href="<?php echo $p->url() ?>"><?php echo $p->title()->html() ?></a>
    </li>
    <?php endforeach ?>
  </ul>
</nav>
<div class="content__container">
