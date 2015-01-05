## Overview

This module makes it easy to manage ZFS filesystems and their mountpoints.

See blog post for details: [Zfsdir: Simple ZFS management with Puppet](http://blog.zach.st/2015/01/05/zfsdir-simple-zfs-management-with-puppet.html)

## Usage

    zfsdir { 'rpool/test':
        ensure => 'present',
        zfs    => {
            recordsize  => '16K',
            mountpoint  => "/test",
            compression => "on",
        },
        file   => {
            owner => 'mzach',
            group => 'bin'
        },
    }

For use with hiera, one could define a nested hash in the following form (e.g. in YAML):

    ---
    zfsdirs:
      rpool/testfs:
        zfs:
          recordsize: 8K
          mountpoint: /testfs
          compression: "on"
        file:
          owner: nobody
          group: bin
      rpool/test2
        zfs:
          mountpoint: /test2
        file:
          mode: 0777

The resources are constructed with the [create_resources function](http://docs.puppetlabs.com/references/latest/function.html#createresources) from hiera:

    $zfsdirs = hiera_hash('zfsdirs',{})
    create_resources(zfsdir, $zfsdirs)


## Reference
- [zfs](https://docs.puppetlabs.com/references/latest/type.html#zfs) resource type
- [file](https://docs.puppetlabs.com/references/latest/type.html#file) resource type

## Limitations

Tested on:
- Solaris 11

## TODO
  - More tests
  - Deal with file-user dependency
  - Make module ready for Puppet Forge
