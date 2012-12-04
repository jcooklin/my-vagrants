class desktop {
  package { "ubuntu-desktop": ensure => "installed", notify => Exec["/sbin/reboot"] }
  exec { "/sbin/reboot": refreshonly => "true" }
}
