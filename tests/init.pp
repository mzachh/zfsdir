# The baseline for module testing used by Puppet Labs is that each manifest
# should have a corresponding test manifest that declares that class or defined
# type.
#
# Tests are then run by using puppet apply --noop (to check for compilation
# errors and view a log of events) or by fully applying the test in a virtual
# environment (to compare the resulting system state to the desired state).
#
# Learn more about module testing here:
# http://docs.puppetlabs.com/guides/tests_smoke.html
#
# Usage: puppet apply --hiera_config zfsdir/tests/hiera-tests-yaml -v --noop tests/init.pp

zfsdir { 'rpool/test':
  ensure => 'present',
  zfs    => {
    recordsize  => '16K',
    mountpoint  => '/test',
    compression => 'on',
  },
  file   => {
    owner => 'root',
    group => 'bin'
  },

}
$zfsdirs = hiera_hash('zfsdirs',{})
create_resources(zfsdir, $zfsdirs)
