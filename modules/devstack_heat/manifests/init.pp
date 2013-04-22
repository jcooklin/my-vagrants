class devstack_heat {
  file {"/etc/environment":
    owner => root,
    group => root,
    mode => '0644',
    content => template('devstack_heat/environment.erb'),
  } ->
  file {"/home/vagrant/install_devstack.sh":
    owner => vagrant,
    group => vagrant,
    mode => '0740',
    replace => false,
    content => template('devstack_heat/install_devstack.sh.erb'),
  } ~>
  exec { "su - vagrant -c '/home/vagrant/install_devstack.sh 2>&1 | tee -a /tmp/devstack_install.log&'": 
    provider => shell,
    cwd => "/home/vagrant/",
    #user => vagrant,
    #group => vagrant,
    refreshonly => true,   
  }
}
