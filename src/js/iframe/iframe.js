Dropzone.options.myAwesomeDropzone = {
  acceptedFiles: "image/jpeg,image/png",  
  uploadMultiple: false,   
	maxFiles:1,
	addRemoveLinks:true,
	init: function() { 
    this.on("success", function(file, resp) { 
			var json = JSON.parse(resp)
			
			//set hidden form values
			document.getElementById("resource-id").value = json.result.resource_id 
			document.getElementById("qr-code").value = json.result.qr_code      
			                             
			//clear qr result
			var warning = document.getElementById("image_quality_warning");
		 	while (warning.firstChild) 
		 	{
		  	warning.removeChild(warning.firstChild);
		 	}
           
			//a valid qr result means the picture was sharp
			if(json.errors.length != 0) 
			{
 			 	var warning = document.getElementById("image_quality_warning"); 
				warning.appendChild(document.createTextNode("Probeer een goede scherpe foto te maken waar het werkblad precies op past")) 
				warning.style.color = "red"
			} 
			else 
			{
				var warning = document.getElementById("image_quality_warning"); 
				warning.appendChild(document.createTextNode("Dit is een goede scherpe foto")) 
				warning.style.color = "green"
			}   
			
			//select the right werkblad by parsing the qr result
			var url = document.createElement('a');
			url.href = json.result.qr_code;  
			var r = getQueryVariable(url, "werkblad")
			document.querySelector(".werkblad select").value = r
		});
		this.on("error", function(file, resp) { 
			/*setTimeout(function(){
				this.removeFile(file);
			}.bind(this), 1000);´*/
		});
		this.on("addedfile", function(file, resp) {  //maxfilesreached?? how to respond to select
			for(var i=0;i<this.files.length;i++)
			{
				if(this.files[i] == file)
				{
					console.log("this is it")
				}                          
				else
				{
					this.removeFile(this.files[i])
					
					console.log("this not")
				}
			}
			
			document.getElementById("resource-id").value = ""
			document.getElementById("qr-code").value = ""
			//this.removeAllFiles(true);
		});
  },
	accept: function(file, done) {   
      //we get here when other checks are fine
			done();
	 }
};

document.addEventListener("DOMContentLoaded", function(event) {
	
	//get query params
  var lat = parseFloat(getQueryVariable(window.location, "lat"));
  var lng = parseFloat(getQueryVariable(window.location, "lng"));
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
	console.log("formdata", formData) 
	
  //verify
  for (var key in formData) {
		switch(key) {
			case "name":
				console.log("name", formData[key])
				break;
			case "description":
				console.log("description", formData[key])
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
			console.log("result", text)
			if(window.parent != null && window.parent.document != null)
			{
				var evt = new Event('formDone'); 
				console.log("p", evt) 
				window.parent.document.dispatchEvent(evt);
			} 
		})
		.catch(function(ex) {
			alert(ex)
	  })       
}

function getQueryVariable(url, variable) {
  var query = url.search.substring(1);
  var vars = query.split("&");
  for (var i=0;i<vars.length;i++) {
         var pair = vars[i].split("=");
         if(pair[0] == variable){return pair[1];}
  }
  return(false);
}
