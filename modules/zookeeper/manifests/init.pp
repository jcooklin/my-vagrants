class zookeeper {

  package {
    zookeeperd: ensure => latest;
  }

  service {
    zookeeper: ensure => running;
  }

  Package["zookeeperd"] ->
  Service["zookeeper"]
}
