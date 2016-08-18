function loadMap(){
  mapboxgl.accessToken = 'pk.eyJ1IjoibWFydGlud2FhZyIsImEiOiJjaWo0NWt6ZWYwMDE0dXlrcm0yenVkNDR5In0.0I9xJzLubP9g3V_NTt1PhA';
  var map = new mapboxgl.Map({
    container: 'map', // container id
    style: 'mapbox://styles/martinwaag/cirx7ujxw003cgymgmwofw995', //stylesheet location
    center: [4.820902482840296, 52.3749057570665], // starting position
    zoom: 12 // starting zoom
  });

  map.on('load', function() {
    map.addSource('meeting', {
      type: 'geojson',
      data: './assets/data/metingen.geojson',
    });

    map.addLayer({
      "id": "meeting",
      "type": "symbol",
      "source": "meeting",
      "layout": {
        "icon-image": "{icon}-15",
        "icon-allow-overlap": true
      }
    });
  });

  map.on('click', function (e) {
    var popup = new mapboxgl.Popup()
        .setLngLat(e.lngLat);

    popup.setHTML(`
      <iframe src="form.html?lat=10.1113423178234&lng=30"></iframe>
    `);
    popup.addTo(map);
    loadDropzone();
  });

  map.on('click', function (e) {
    var features = map.queryRenderedFeatures(e.point, { layers: ['meeting'] });

    if (!features.length) {
        return;
    }

    var feature = features[0];

    // Populate the popup and set its coordinates
    // based on the feature found.
    var popup = new mapboxgl.Popup()
        .setLngLat(feature.geometry.coordinates);

    popup.setHTML(feature.properties.description);
    popup.addTo(map);
  });

  // Use the same approach as above to indicate that the symbols are clickable
  // by changing the cursor style to 'pointer'.
  map.on('mousemove', function (e) {
      var features = map.queryRenderedFeatures(e.point, { layers: ['meeting'] });
      map.getCanvas().style.cursor = (features.length) ? 'pointer' : '';
  });
}
loadMap();


function loadDropzone(){   
	/*
  console.log('drop fired');
  const dropzoneId = document.getElementById('my-awesome-dropzone');
  console.log(Dropzone.options.myAwesomeDropzone);
  Dropzone.options.myAwesomeDropzone = {
    acceptedFiles: "image/jpeg",  
    uploadMultiple: false,   
    maxFiles: 1,
    init: function() { 
      console.log('what is this', this);
      this.on("success", function(file, resp) { 
        //this.removeFile(file);
        console.log("uploaded:", resp);       
        document.getElementById("resource-id").value = resp
      });
      this.on("drop", function(file, resp) { 
        document.getElementById("resource-id").value = ""
        this.removeAllFiles(true);
      });
    },
    accept: function(file, done) {   
        //we get here when other checks are fine
        done();
     }
  };   
	*/
}
