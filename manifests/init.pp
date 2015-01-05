# == Define: zfsdir
#
# Configures a ZFS filesystem and sets the correct file permissions for the mountpoint.
#
# === Parameters
#
# [*zfs*]
# This parameter contains a hash of the zfs properties. The hash will be handed over to the zfs resource type.
# The 'title' of "zfsdir" will be used as 'name' for the zfs resource.
# If the "file" parameter is used, 'mountpoint' must be set.
#
# [*ensure*]
# Optional. Default 'ensure'= 'present'
#
# [*file*]
# This *optional* parameter contains a hash, which will be handed over to the file resource type. The zfs mountpoint attribute will be used as 'title' for the file resource.
#
# === Examples
#
#   zfsdir { 'rpool/test':
#     ensure => 'present',
#     zfs    => {
#       recordsize  => '16K',
#       mountpoint  => '/test',
#       compression => 'on',
#     },
#     file   => {
#       owner => 'root',
#     },
#
# === Authors
#
# Manuel Zach <mzach-oss@zach.st>
#
# === Copyright
#
# Copyright 2015 Manuel Zach.
#
define zfsdir ($zfs, $ensure = 'present', $file = nil)
{
  $zfs_params = {
    "${title}" => merge(
      { 'ensure' => $ensure },
      $zfs
    ),
  }

  create_resources(zfs, $zfs_params)

  if $file != nil and $ensure != 'absent' {
    $mountpoint = $zfs['mountpoint']
    if $mountpoint == undef {
      err("ZFS mountpoint for ${title} must be definied")
    }
    $file_params = {
      "${mountpoint}" => merge(
        { 'require' => "zfs[${title}]" },
        $file
      ),
    }
    create_resources(file, $file_params)
  }
}
