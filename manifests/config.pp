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
  managehome => true,
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

ssh_authorized_key { 'timogoebel-iphone-ssh-key':
  ensure => 'present',
  type => 'rsa',
  user => 'timogoebel',
  key => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQCqrTOxQZqLd5IzsXad6xHPw75/cZCDxH1URRRfSrJ7mtrxk4pCrAAEHsnSZn4gSNlRSJtDip/SEvITyodBgX4Z7nahnQmX5L7MB2dUqCP7STLyqTVPVg+N8hlPyrTPdPtFEMGC2Wq1OYblc7MUAz9G3k+QSl00aVWAmVdM5M5jvqSm1KAgWDI2hCpYp10Rv506hO1QfyahxcpTO+HIuEN0EEZa7tjQo7aTC37cySkdvCgtpQksVhbV1HOXzg/oxlAmpKegkbZQyw3QhBc8csDltD+3OymrgVfxL1S787o5GUUUTq9ktkp/n3dTA/pxFG85G9oGBVk4KJrzfuF3ug1GEtGiS5Z2kSQ8uHIQF8KeXPPNTsaZLwbqZ+6c/C8YSS8kFlx0oyha+hkBYDF20GemwYRnuB5HYb6IVoYJQtQvHrd4L+e5azHd+BItdsYtCDGcRfUCcGG82+m+aS3YUgeiBV//x893MHdPW+WGgNEqyxGvYdZOOzxykPJr6yGQfR86WVf6AhRsQJcTh/SVFIAelEsvqjmsPIMUfxCHMtZ/PvRNr8K09ri7bUMXmUTvRDuMbD3cAAgpSkQAp+2CLRIFF3RdhOCqZvJDv5BUm0JCe9RZUJ4mY9NfAXD4sAbswN7ZtA365dNtMe0cglqpS5sjVJT4seZv9wgKXxqV47b/5w==',
  require => File['/home/timogoebel/.ssh'],
}

user { 'pi':
  ensure => 'absent',
}

class { 'sudo': }

sudo::conf { 'admins':
  priority => 10,
  content  => '%admins ALL=(ALL) NOPASSWD: ALL',
}

class { 'ngrok': }
