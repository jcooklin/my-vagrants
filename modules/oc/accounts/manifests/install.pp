class accounts::install (
  $password_hash = '$6$YhmDUYdJ$U/KchieL6wnKGRrlT9fQM3.M5wbjnQshhFp17EF8TMb/Y5VCWDqpg.g6FwdpLKl0Boqj/rJCdVuOIPF6xR2vj.'
){
  @user { "root":
    ensure   => "present",
    name     => "root",
    password => 'bullshit',
  }
  User <| title == "root" |>
  notify {"wtf":}
}
