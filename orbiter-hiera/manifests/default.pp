## common entry-point into Puppet config.

## if is_vagrant is defined, then we're running under Vagrant.  Use other
## logic/facts to detect environmental stuff.
if $::is_vagrant {
    $data_center = 'vagrant'
} else {
    $data_center = 'amazon'
}
#class test_hiera ($ut_zone = hiera('ut_zone','somebs')) {
#	notify {"we are testing hiera! $ut_zone":}
#}

#$my_val = hiera('ut_zone')
#$my_val = $ut_zone
#notify {"are we having fun $my_val":}
include role::ui
#include test_hiera
