ServerName {{ ansible_eth1['ipv4']['address'] }}
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot {{ vagrant_root }}/public
    ErrorLog ${APACHE_LOG_DIR}/vagrant-error.log
    CustomLog ${APACHE_LOG_DIR}/vagrant-access.log combined
    SetEnv MAGE_IS_DEVELOPER_MODE true
    ProxyPassMatch ^/(.*\.php(/.*)?)$ fcgi://127.0.0.1:9000{{ vagrant_root }}/public/$1
    <Directory {{ vagrant_root }}/public>
        Options All
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
