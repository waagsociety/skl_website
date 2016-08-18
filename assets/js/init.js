Dropzone.options.myAwesomeDropzone = {
  acceptedFiles: "image/jpeg",  
  uploadMultiple: false,   
	maxFiles:1,
	init: function() { 
    this.on("success", function(file, resp) { 
			//this.removeFile(file);
			console.log("uploaded:", resp); 			
			document.getElementById("resource-id").value = resp
		});
		this.on("drop", function(file, resp) { 
			document.window.parent.bla()("resource-id").value = ""
			this.removeAllFiles(true);
		});
  },
	accept: function(file, done) {   
      //we get here when other checks are fine
			done();
	 }
};

document.addEventListener("DOMContentLoaded", function(event) {
	
	//get query params
  var lat = parseFloat(getQueryVariable("lat"));
  var lng = parseFloat(getQueryVariable("lng"));
	document.getElementById("lat").value = lat;
	document.getElementById("lon").value = lng;
                    
	//add ajax handler to form submit    
	var submit = document.querySelector(".werkblad")  
	submit.addEventListener("submit", function(evt) {
		evt.preventDefault();
		submitForm()
	});

}); 

function submitForm() {
	
	//           
	var form = document.querySelector(".werkblad")
	var formData = new FormData(form)  
	
  //verify
  for (var pair of formData.entries()) {
		switch(pair[0]) {
			case "name":
				console.log("name", pair[1])
				break;
			case "description":
				console.log("description", pair[1])
				break;
		 	default:
				break;
		}
	}

	//post
	var source = "/api/form"
	var method = "POST"
	var fetchParams = {
		method: method,
		body: formData
	}
	window.fetch(source, fetchParams)
	  .then(function(response){
		  if (response.status >= 200 && response.status < 300) {  
				return response.text(); //we don't process it any further
			} else {
				throw response.statusText;
			}
		})
		.then(function(text){    
			console.log("response text:", text)
		 	var el = window.parent.document.querySelector(".mapboxgl-popup")
			el.parentNode.removeChild(el)
		})
		.catch(function(ex) {
			alert(ex)
	  })       
}

function getQueryVariable(variable) {
  var query = window.location.search.substring(1);
  var vars = query.split("&");
  for (var i=0;i<vars.length;i++) {
         var pair = vars[i].split("=");
         if(pair[0] == variable){return pair[1];}
  }
  return(false);
}
