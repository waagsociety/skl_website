var gMap = null;  

document.addEventListener("DOMContentLoaded", function(event) {
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
    zoom: 12 // starting zoom
  });
              
	//get markers form webservice and put in layer on map
  gMap.on('load', function() {
		loadMapContent();
  });
          
	//add popup in iframe with image upload form
  gMap.on('click', function (e) {

		//
		var features = gMap.queryRenderedFeatures(e.point, { layers: ['meeting'] });
		if(features.length == 0)
		{
			//
	    var popup = new mapboxgl.Popup().setLngLat(e.lngLat);  
			var iframe = document.createElement("iframe");
			iframe.src = "form.html?lat=" + e.lngLat.lat + "&lng=" + e.lngLat.lng;
	    popup.setDOMContent(iframe)
	    popup.addTo(gMap);            
		}
		else
		{          
			for(var i=0;i<features.length;i++)
			{             
				 //get the resource_id of the clicked feature and load resource              
				 loadResourceOnMap(features[i].properties.resource_id)
			}
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
				if(gMap.getSource('meeting') != null)
				{
					gMap.removeSource('meeting');
				}
				//add markers and layer
				gMap.addSource('meeting', {
		      type: 'geojson',
		      data: json
		    });
				gMap.addLayer({
		      "id": "meeting",
		      "type": "symbol",
		      "source": "meeting",
		      "layout": {
		        "icon-image": "{icon}-15",
		        "icon-allow-overlap": true
		      }
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
				 img.src = json.thumb_url; 
				 div.appendChild(img);                   
				 var a = document.createElement("a");
				 var text = document.createTextNode(json.description);
				 a.href = "/werkblad?resourceId=" + id;
				 a.appendChild(text);  
				 div.appendChild(a)
				
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


