<?php snippet('header') ?>
<?php snippet('navigation') ?>

<?php echo js('assets/js/main.min.js') ?>
<?php echo js('http://api.tiles.mapbox.com/mapbox-gl-js/v0.26.0/mapbox-gl.js') ?>
<?php echo js('http://api.mapbox.com/mapbox-gl-js/plugins/mapbox-gl-supported/v1.2.0/mapbox-gl-supported.js') ?>
<?php echo js('http://api.mapbox.com/mapbox-gl-js/plugins/mapbox-gl-geocoder/v1.3.0/mapbox-gl-geocoder.js') ?>
<div class="map__container flex">
  <link rel='stylesheet' href='https://api.mapbox.com/mapbox-gl-js/plugins/mapbox-gl-geocoder/v1.3.0/mapbox-gl-geocoder.css' type='text/css' />
  <figure id="fullscreenImageContainer" class="full__image__container">
    <a id="closeimage" href="/resultaten">X</a>
    <img id="fullscreenImage" class="full__image" src=""/>
  </figure>
  <div id="map"></div>
  <div class="map__sidebar">
    <section>
      <h2 class="alpha">Deel je meetresultaat</h2>
      <p>Heb je een proefje gedaan met een zelfgemaakte meter? Hier zet je je resultaten op de GROTE DATAKAART.</p>
      <header class="kaart__arrow"></header>
      <p>KLIK op de plek waar je de metingen hebt gedaan en upload een foto van je ‘proefjes doen’ werkblad.</p>
      <h2 class="alpga">BEKIJK wat er
gemeten is!</h2>
      <p>KLIK op de icoontjes op de kaart om de metingen van anderen te bekijken.</p>
    </section>
  </div>
</div>   

<?php snippet('footer') ?>
