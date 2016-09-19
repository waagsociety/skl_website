<?php snippet('header') ?>
<?php snippet('navigation') ?>


<?php echo js('http://api.tiles.mapbox.com/mapbox-gl-js/v0.23.0/mapbox-gl.js') ?>
<div class="map__container flex">
  <script src='https://api.mapbox.com/mapbox-gl-js/plugins/mapbox-gl-geocoder/v1.3.0/mapbox-gl-geocoder.js'></script>
  <link rel='stylesheet' href='https://api.mapbox.com/mapbox-gl-js/plugins/mapbox-gl-geocoder/v1.3.0/mapbox-gl-geocoder.css' type='text/css' />
  <figure id="fullscreenImageContainer" class="full__image__container">
    <a id="closeimage" href="/resultaten">X</a>
    <img id="fullscreenImage" class="full__image" src=""/>
  </figure>
  <div id="map"></div>
  <div class="map__sidebar">
    <section>
      <h2 class="alpha">De kaart</h2>
      <p>Op de kaart vind je allerlei verschillende metingen gedaan door andere kinderen. Zo zie jij wat bijvoorbeeld de lucht kwaliteit op verschillende scholen is.</p>
    </section>
    <section>
      <h2 class="alpha">Meten is weten</h2>
      <p>Wil je ook een meeting doen? Doe mee en kies een leuke meeting uit op de meting pagina! Kijk op de kaart wat jou leuk lijkt!</p>
      <a href="#" class="btn">Zoek een opdracht</a>
    </section>
    <section>
      <h2 class="alpga">Ik ben een meter</h2>
      <p>Heb je wat gemeten? Upload hier jou meeting op de kaart. Klik op de plek waar je de meeting hebt gedaan en upload de foto van jou werkblad.</p>
    </section>
  </div>
</div>
<?php snippet('footer') ?>
