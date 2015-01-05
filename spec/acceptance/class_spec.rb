require 'spec_helper_acceptance'

describe 'zfsdir class' do

  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'should work idempotently with no errors' do
      pp = <<-EOS
      zfsdir { 'rpool/test':
          ensure => 'present',
          zfs => {
              recordsize => '16K',
              mountpoint => "/test",
              compression => "on",
          },
          file => {
              owner => 'root',
          },
      }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end

  end
end
