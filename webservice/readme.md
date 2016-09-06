## install imagemagick before gem rmagick

> apt-get install imagemagick libmagickcore-dev libmagickwand-dev

## install zbar

sudo apt-get install zbar-tools

## install Ruby (non RVM version makes it easier to setup thin as service)

> sudo apt-get install ruby2.1 ruby2.1-dev

## install bundler and gems

> gem install bundler

> bundle install
                
## add this to httpd.conf to integrate webservice in kirby site
    
<pre>
 	<Location /api/>
   		ProxyPass http://127.0.0.1:3000/api/
    	ProxyPassReverse http://127.0.0.1:3000/api/
	</Location>
 	<Location /admin/>
   		ProxyPass http://127.0.0.1:3000/admin/
    	ProxyPassReverse http://127.0.0.1:3000/admin/
	</Location>
</pre>      

## or when using nginx
         
<pre>
	location /api {
    	proxy_pass         http://127.0.0.1:3000/api;
		proxy_set_header   Host             $host;
		proxy_set_header   X-Real-IP        $remote_addr;
  	}

	location /admin {
    	proxy_pass         http://127.0.0.1:3000/admin;
    	proxy_set_header   Host             $host;
        proxy_set_header   X-Real-IP        $remote_addr;
	}
</pre>

## make service for thin webserver

* generate init.d entry
> sudo thin install    
                                             
* make service start at boot
> sudo /usr/sbin/update-rc.d -f thin defaults   
                            
* generate boot config for thin daemon
> sudo thin config -C /etc/thin/webservice -c /home/deploy/webservice -d -u www-data -g www-data 

* run it
> sudo service thin start



 