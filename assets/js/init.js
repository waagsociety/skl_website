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
			document.getElementById("resource-id").value = ""
			this.removeAllFiles(true);
		});
  },
	accept: function(file, done) {   
      //we get here when other checks are fine
			done();
	 }
};

document.addEventListener("DOMContentLoaded", function(event) {
  var lat = parseFloat(getQueryVariable("lat"));
  var lng = parseFloat(getQueryVariable("lng"));
  document.getElementById("log").innerHTML = `lat = ${lat} & lng = ${lng}`;
});

function getQueryVariable(variable)
{
  var query = window.location.search.substring(1);
  var vars = query.split("&");
  for (var i=0;i<vars.length;i++) {
         var pair = vars[i].split("=");
         if(pair[0] == variable){return pair[1];}
  }
  return(false);
}
