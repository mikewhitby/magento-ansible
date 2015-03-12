Vagrant.require_version ">= 1.5"

Vagrant.configure("2") do |config|

    config.vm.provider :virtualbox do |v|
        v.name = "Magento"
        v.customize [
            "modifyvm", :id,
            "--name", "Magento",
            "--memory", 2048,
            "--natdnshostresolver1", "on",
            "--cpus", 1,
        ]
    end

    config.vm.box = "ubuntu/precise64"
    
    config.vm.network :private_network, ip: "192.168.56.101"
    config.ssh.forward_agent = true

    config.vm.provision "ansible" do |ansible|
        ansible.playbook = "ansible/site.yml"
        ansible.inventory_path = "ansible/dev"
        ansible.limit = 'all'
        ansible.extra_vars = {
            private_interface: "192.168.56.101",
            hostname: "Magento"
        }
    end
    
    if Vagrant.has_plugin?('vagrant-bindfs')
        config.vm.synced_folder ".", "/mnt/bindfs", type: "nfs"
        config.bindfs.bind_folder "/mnt/bindfs", "/vagrant", user: 'www-data', group: 'www-data'
    else
        config.vm.synced_folder ".", "/vagrant", type: "nfs"
    end
end
