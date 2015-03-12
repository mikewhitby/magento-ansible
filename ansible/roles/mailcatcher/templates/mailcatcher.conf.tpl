description "Mailcatcher"

start on runlevel [2345]
stop on runlevel [!2345]

respawn

exec /usr/bin/env mailcatcher --foreground --http-ip={{ ansible_eth1['ipv4']['address'] }} --http-port 82
