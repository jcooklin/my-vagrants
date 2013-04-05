define add_ssh_key($key, $type) {

  $username       = $title
  $home           = $username ? { 'root' =>  "", default => "/home" }

  file { "$home/$username/.ssh":
    ensure => directory,
    owner  => $username,
    group  => $username,
    mode   => 700
  }

  ssh_authorized_key{ "${username}_${key}":
    ensure   => present,
    key      => $key,
    type     => $type,
    user     => $username,
    require => [File["$home/$username/.ssh"]]
  }
}
