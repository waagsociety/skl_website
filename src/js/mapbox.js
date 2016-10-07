var gMap = null;        

document.addEventListener("DOMContentLoaded", function(event) {          
  if(!mapboxgl.supported()) {
    alert("mapbox gl is not supported by this browser")
  } else {
    console.log("mapbox gl is supported!")
  }
  loadMap();     
});

/*
form in iframe is going to throw event when it's done
*/                                   
document.addEventListener("formDone", function(evt) {
  //remove popups
  var popups = document.querySelectorAll(".mapboxgl-popup")
  for(var i=0;i<popups.length;i++) {
    popups[i].parentNode.removeChild(popups[i]);
  }
 
  //reload markers
  loadMapContent();
});  

//initialize map and handlers
function loadMap(){
  mapboxgl.accessToken = 'pk.eyJ1IjoibWFydGlud2FhZyIsImEiOiJjaWo0NWt6ZWYwMDE0dXlrcm0yenVkNDR5In0.0I9xJzLubP9g3V_NTt1PhA';

  gMap = new mapboxgl.Map({
    container: 'map', // container id
    style: 'mapbox://styles/martinwaag/cirx7ujxw003cgymgmwofw995', //stylesheet location
    center: [4.820902482840296, 52.3749057570665], // starting position
    zoom: 12, // starting zoom
    minZoom: 12
  });

  gMap.addControl(new mapboxgl.Geocoder());
  
  //get markers form webservice and put in layer on map
  gMap.on('load', function() {
    loadMapContent();
  });
  
  //add popup in iframe with image upload form
  gMap.on('click', function (e) {           
    if(e.originalEvent.target.tagName != "A") {
      var popup = new mapboxgl.Popup().setLngLat(e.lngLat);  
      var iframe = document.createElement("iframe"); 
      iframe.width = 640;
      iframe.height = 358;
      iframe.src = "form.html?lat=" + e.lngLat.lat + "&lng=" + e.lngLat.lng;
      popup.setDOMContent(iframe)
      popup.addTo(gMap);            
    }
  });    
}   

//update map content
function loadMapContent() {

  if(gMap != null)
  {
    var source = "/api/markers"
    window.fetch(source)
    .then(function(response){
      if (response.status >= 200 && response.status < 300) {  
        return response.json(); //we don't process it any further
      } else {
        throw response.statusText;
      }
    })
    .then(function(json){    
      //remove existing source if there is one
      var geojson = json;
      
      geojson.features.forEach(function(marker) {
          var icons = ["","ph", "weerstand", "light", "secchie", "microbes", "dust", "kite", "gas", "uv", "micros"];
					

					// create a DOM element for the marker
          var el = document.createElement('div');                  
          var a = document.createElement("a");
          var text = document.createTextNode(marker.properties.description);
          a.className = "marker-icon " + icons[marker.properties.icon];
					a.href = "#";
          a.appendChild(text);  
					el.appendChild(a);

          el.addEventListener('click', function(m) { 
            loadResourceOnMap(marker.properties.resource_id)
            m.preventDefault()
          });  
          
          new mapboxgl.Marker(el, {offset: [0, 0]})
          .setLngLat(marker.geometry.coordinates)
          .addTo(gMap);
      });
    })
    .catch(function(ex) {
      alert(ex)
    })  
  }
}

function loadResourceOnMap(id) {
  if(gMap != null)
  {                    
    var source = "/api/resource/" + id
    window.fetch(source)
    .then(function(response){
     if (response.status >= 200 && response.status < 300) {  
          return response.json(); //we don't process it any further
        } else {
          throw response.statusText;
        }
      })
    .then(function(json){    
       //use someting for this ?? jsx 
       var div = document.createElement("div");
       var img = document.createElement("img");   
       var a = document.createElement("a");
                               
       img.src = json.thumb_url; 

       var text = document.createTextNode(json.description);
       a.href = "/werkblad?resourceId=" + id;
       // a.appendChild(text);  
       a.appendChild(img);
       a.className = 'image__thumb__link';
       div.appendChild(a); 
       var closeBtn = document.getElementById('closeimage');

       a.addEventListener('click', function(e){
        e.preventDefault();
        var fullscreenImageContainer = document.getElementById('fullscreenImageContainer');
        var fullscreenImage = document.getElementById('fullscreenImage');
        fullscreenImageContainer.style.display = "block";
        fullscreenImage.src = json.image_url;
       });

       closeBtn.addEventListener('click', function(e){
        e.preventDefault();
        fullscreenImageContainer.style.display = "none";
       });
       // e.preventDefault
      
       //add popup
       var popup = new mapboxgl.Popup().setLngLat([json.lon,json.lat]);
       popup.setDOMContent(div)
       popup.addTo(gMap);          
    })
    .catch(function(ex) {
      alert(ex)
    })
  }
}


