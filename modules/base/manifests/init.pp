class base {
  file {"/etc/apt/apt.conf":
  	owner => root,
	group => root,
	mode => '0644',
	content => template('base/apt.conf.erb'),
  } ->

  group { "puppet": ensure => "present"; }  ->

  class { "aptitude": } ->
  package { "openjdk-6-jre": ensure => "present", } ->
  package { "curl": ensure => "present", } ->
  package { "git-core": ensure => "installed", } -> 
  package { "vim": ensure => "installed", } ->
  package { "wget": ensure => "installed", } ->
  package { "ubuntu-desktop": ensure => "installed", notify => Exec["/sbin/reboot"] }

  exec { "/sbin/reboot": refreshonly => "true" }

}
