class couchbase::package {

  package { 'couchbase':
    ensure => installed,
    source => "http://packages.couchbase.com/releases/2.0.0/couchbase-server-community_x86_64_2.0.0.deb",
  }

}
