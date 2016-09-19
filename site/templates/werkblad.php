<?php snippet('header', array("script_links" => array("assets/js/main.min.js"))) ?>

<?php snippet('navigation') ?>

<main>
	<div class="werkblad">
		<p class="description"></p>
		<p class="user"></p>
		<figure class="full__image__container">
			<img class="full__image" src=""/>
		</figure>
	</div>
</main>

<script type="text/javascript">
	function getQueryVariable(variable) {
	  var query = window.location.search.substring(1);
	  var vars = query.split("&");
	  for (var i=0;i<vars.length;i++) {
	  	var pair = vars[i].split("=");
	    if(pair[0] == variable){return pair[1];}
	  }
	  return(false);
	}
            
	var source = "/api/resource/" + getQueryVariable("resourceId")  
	window.fetch(source)
	  .then(function(response){
		  if (response.status >= 200 && response.status < 300) {  
				return response.json(); //we don't process it any further
			} else {
				throw response.statusText;
			}
		})
		.then(function(json){    
		 	var img = document.querySelector(".werkblad img")
			var description = document.querySelector(".werkblad .description")
			description.appendChild(document.createTextNode(json.description))
			var user = document.querySelector(".werkblad .user")         
			user.appendChild(document.createTextNode(json.name))
			img.src = json.image_url          
			
			console.log("json", json)
		})
		.catch(function(ex) {
			alert(ex)
	  })


</script>	



<?php snippet('footer') ?>
