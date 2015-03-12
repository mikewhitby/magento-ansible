ServerName {{ ansible_eth1['ipv4']['address'] }}
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot {{ vagrant_root }}/public
    ErrorLog {{ vagrant_root }}/logs/apache/error.log
    CustomLog {{ vagrant_root }}/logs/apache/access.log combined
    SetEnv MAGE_IS_DEVELOPER_MODE true
    ProxyPassMatch ^/(.*\.php(/.*)?)$ fcgi://127.0.0.1:9000{{ vagrant_root }}/public/$1
    <Directory {{ vagrant_root }}/public>
        Options All
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
