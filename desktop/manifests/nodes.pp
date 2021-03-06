stage { 'pre': before => Stage['main'] }

#--------------------------------------------
# Base

node basenode {
  class { "base": stage => pre; }
}

#--------------------------------------------

node default inherits basenode {

  include desktop

  group { "vagrant": ensure => "present"; } ->
  user  { "vagrant": ensure => "present"; } 

}
