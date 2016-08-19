#add this to httpd.conf to integrate webservice in kirby site

<Location /api/>
    ProxyPass http://127.0.0.1:3000/api/
    ProxyPassReverse http://127.0.0.1:3000/api/
</Location>

<Location /admin/>
    ProxyPass http://127.0.0.1:3000/admin/
    ProxyPassReverse http://127.0.0.1:3000/admin/
</Location>
