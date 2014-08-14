sshkeys::create_key { 'cloudera':
    home     => '/home/cloudera/',
}

sshkeys::set_authorized_key {'cloudera@tyconet02.tyco.com to cloudera@tyconet03.tyco.com':
  local_user  => 'cloudera',
  remote_user => 'cloudera@tyconet03.tyco.com',
  home        => '/home/cloudera',
}
