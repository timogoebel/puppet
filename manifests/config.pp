package { 'git':
  ensure => 'latest',
}

package { 'vim':
  ensure => 'latest',
}

package { 'htop':
  ensure => 'latest',
}

group { 'admins':
  ensure => 'present',
}

user { 'timogoebel':
  ensure     => 'present',
  home       => '/home/timogoebel',
  shell      => '/bin/bash',
  managehome => 'true',
  groups => 'admins',
  require => Group['admins'],
}

file { '/home/timogoebel/.ssh':
  ensure => 'directory',
  owner => 'timogoebel',
  mode => '700',
  require => User['timogoebel'],
}

ssh_authorized_key { 'timogoebel-ssh-key':
  ensure => 'present',
  type => 'rsa',
  user => 'timogoebel',
  key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCZnoPaHvHmIQVqd2fc/w4ZMc+Zpcg2w+xx0LRtlEBKmMohOkio2oMzajAFIdxpvdtmlfXNVO7tUpgPcoPV5UdVWcHkcgzsmIwlcmZsOCExcNlQU6GosK86iyu9qSo2AVn5ttjBRFdCt2AxpLVSZmoUxQ4h5fDXK96oET0fojRzMDk82SbWwlYVJPNHGYDfA/IvxZMLs9G5DJt5vLAfElx8b/eoNQgGmFYgEZZHYiu1JYA5kr4l1MIgwWytWfmvk3Bc4YlSGEwW6Smf0lUh79vnu7DczIxWA2eSlTWDL9cYchcjxDzgOH241ecfW2M+qjLfKsaak076qQO5p/QgTuzR',
  require => File['/home/timogoebel/.ssh'],
}

user { 'pi':
  ensure => 'absent',
}

class { 'sudo': }

sudo::conf { 'admins':
  priority => 10,
  content  => "%admins ALL=(ALL) NOPASSWD: ALL",
}

class { 'ngrok': }
