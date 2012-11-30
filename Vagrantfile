Vagrant::Config.run do |config|
  config.vm.host_name = "my-devstack"
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.customize ["modifyvm", :id, "--memory", 1024]
  config.vm.network :hostonly, "10.10.10.43"
  config.vm.boot_mode='gui'

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.module_path = "modules"
    puppet.manifest_file = "vagrant.pp"
    puppet.options = ["--verbose", "--node_name_value", "my-devstack", "--http_proxy_host", "proxy-us.intel.com", "--http_proxy_port", "911"]
  end
end
