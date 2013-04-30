class redstack {
  file {"/etc/environment":
    owner => root,
    group => root,
    mode => '0644',
    content => template('redstack/environment.erb'),
  } ->
  file {"/home/vagrant/install_redstack.sh":
    owner => vagrant,
    group => vagrant,
    mode => '0740',
    replace => false,
    content => template('redstack/install_redstack.sh.erb'),
  } ~>
  exec { "su - vagrant -c '/home/vagrant/install_redstack.sh 2>&1 | tee -a /tmp/redstack_install.log&'": 
    provider => shell,
    cwd => "/home/vagrant/",
    #user => vagrant,
    #group => vagrant,
    refreshonly => true,   
  }
}
