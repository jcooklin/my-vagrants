stage { 'pre': before => Stage['main'] }

#--------------------------------------------
# Base

node basenode {
  class { "base": stage => pre; }
}

#--------------------------------------------

node default inherits basenode {

  group { "vagrant": ensure => "present"; } ->
  user  { "vagrant": ensure => "present"; } 

  include zookeeper

}
