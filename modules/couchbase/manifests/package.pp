class couchbase::package {

  exec {'couchbase-wget':
    provider => shell,
    command => '(cd /tmp && wget http://packages.couchbase.com/releases/2.0.0/couchbase-server-community_x86_64_2.0.0.deb)',
  } ->
  package { 'couchbase':
    provider => dpkg,
    ensure => installed,
    source => "/tmp/couchbase-server-community_x86_64_2.0.0.deb",
  }

}
