# Magento Ansible Vagrant Box

An [idempotent][8] Ubuntu 12.04 LTS / Apache 2.4 / PHP 5.4 / APC / PHP-FPM /
MySQL 5.5 / XDebug/ XHProf / Mailcatcher Vagrant box, built via Ansible,
set up with Magento in mind.

Currently only tested on OS X (Yosemite), would very much appreciate
feedback of people using this succesfully (or not) on other OS's.


## OS X Quick Start

Make sure you have these things (you've already got [brew][12], right?!):

    brew install vagrant
    vagrant plugin install vagrant-bindfs
    brew install ansible

Then run:

    vagrant up

The MySQL username is `root` with no password, you can simply SSH in and
type `mysql`. If you're not sure where to go next, see the section
[Install Magento](#install-magento) for more info.


## URLs

* [http://192.168.56.101][1] - Web Root
* [http://192.168.56.101:81][2] - XHProfUI
* [http://192.168.56.101:82][3] - Mailcatcher


## How To

### Install Magento

Point a DNS label at the box:

    echo "192.168.56.101 magento.dev" | sudo tee -a /etc/hosts

Create a DB and install Magento

    vagrant ssh
    mysqladmin create magento
    sudo n98-magerun install --installationFolder=/vagrant/public

Done, just visit [magento.dev](magento.dev)!

### Set Up a Cron Job

SSH in to the box and add a cron job to the `www-data` user by using
`sudo crontab -e -u www-data`


## Features

### XDebug

Set to allow remote debugging, profiling and tracing. Install the
[XDebug Helper][4] chrome extension to trigger these things. Calls back
to the default port of 9000 for debugging, profiles and traces get spat
out in the `profiler-runs/xdebug` directory in order to allow easy usage
of apps like kcachegrind / qcachegrind, or online tools like [Blackfire]
[6].

### XHProf

As per Xdebug, XHProf spits out profile runs to `profiler-runs/xhprof`
to allow you to use to use Blackfire or whatever. Also exposes the runs
via XHProfUI at [http://192.168.56.101:81][2], and has graphvix for
showing call graphs. Use the [XHProf Helper][5] for chrome to make it
easier

### Mailcatcher

Stops e-mails going to their intended recipients,a nd instead shows them
in a web interface, which is at [http://192.168.56.101:82][3], which
allows you to see the e-mails that have been sent.


## Notes

### Why Ubuntu 12 / Apache 2.4 / PHP 5.4 / etc

I choose Ubuntu 12.04 LTS because it allows easy installation of PHP
5.4.

I chose Apache mainly because I didn't see a need for nginx - Apache 2.4
with PHP-FPM is performant and familiar. Also, Apache can read Magento's
.htaccess files, the only part it doesn't read are the `mod_php` settings,
which don't change between versions and I have replicated in the Apache
config.

I chose PHP5.4 because it is the most supported version through the
Magento versions (1.9+ supports it natively, and 1.6 - 1.8 can be patched
to support it).

### BindFS

[BindFS][9] allows you to rebind a directory with different permissions,
which is ideal for Vagrant environments, as the default NFS permissions
map to the `501:20` in the guest, using BindFS lets you remap the
permissions so that the files are user:group of `www-data`, which just
makes things easier.

You'll get a yellow message (see below) on vagrant up saying "Bindfs
seems to not be installed on the virtual machine", please note this isn't
an error, it's just the vagrant BindFS plugin installing BindFS on the
guest.

![BindFS Warning](https://monosnap.com/file/46mEbnGBDj2ojoO7bwdWqFJA9wKMYU.png)

### Apache Setup

The port 80 vhost purposefully doesn't have a `ServerName`, which means
you can point whatever the hell you want at it and it will dutifully
serve up the web root.

### Vagrant Port Mapping

I haven't added any, if you want to expose your VM to external hosts you
can add some if you like, but I prefer to use [ngrok][10]. You could
also look in to [Vagrant share][11].

### Variables

I purposefully didn't bother with extracting things in to variables in
order to make the Ansible roles easier to read, and I don't yet envisage
using this template on multiple servers where variables might get
overridden. Basically, I just wanted to keep things simple.


[1]: http://192.168.56.101 "Web root"
[2]: http://192.168.56.101:81 "XHProf"
[3]: http://192.168.56.101:82 "Mailcatcher"
[4]: https://chrome.google.com/webstore/detail/xdebug-helper/eadndfjplgieldjbigjakmdgkmoaaaoc?hl=en "Chrome XDebug Helper"
[5]: https://chrome.google.com/webstore/detail/xhprof-helper/adnlhmmjijeflmbmlpmhilkicpnodphi?hl=en "Chrome XHProf Helper"
[6]: https://blackfire.io/ "Blackfire Profiler"
[8]: http://en.wikipedia.org/wiki/Idempotence "Idempotence"
[9]: http://bindfs.org/ "BindFS"
[10]: https://ngrok.com/ "Introspected tunnels to localhost"
[11]: http://docs.vagrantup.com/v2/share/ "Vagrant share"
[12]: http://brew.sh/ "Homebrew"
