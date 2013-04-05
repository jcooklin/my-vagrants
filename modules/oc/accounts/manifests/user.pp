define add_user ( $email = undef , $uid = undef , $ssh_key = undef) {

  $username = $title

  if $ssh_key {
    create_resources(add_ssh_key, { "$username" => $ssh_key})
  }

  if $uid and $email {
    user { $username:
      comment => "$email",
      home    => "/home/$username",
      shell   => "/bin/bash",
      uid     => $uid
    }

    group { $username:
      gid     => $uid,
      require => User[$username]
    }

    file { "/home/$username/":
      ensure  => directory,
      owner   => $username,
      group   => $username,
      mode    => 750,
      require => [ User[$username], Group[$username] ]
    }

  }
}
