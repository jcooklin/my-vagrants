stage { [pre, post]: }
Stage[pre] -> Stage[main] -> Stage[post]

#--------------------------------------------

node default {
  #class { 'mysql::server':}
  hiera_include(classes)
  #class { 'role::db':}
}
