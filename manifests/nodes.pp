stage { 'pre': before => Stage['main'] }
#--------------------------------------------
# Base
node basenode {
  class { "base": stage => pre; }
}

#--------------------------------------------
# Graphite servers

node default inherits basenode {

  group { "vagrant": ensure => "present"; } ->
  user  { "vagrant": ensure => "present"; } 

}
