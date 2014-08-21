sshkeys::create_key { 'tyconet02':
    home     => '/home/tyconet02/',
}

sshkeys::set_authorized_key {'tyconet02@tyconet02 to tyconet03@tyconet03':
  local_user  => 'tyconet03',
  remote_user => 'tyconet02@tyconet02',
  home        => '/home/tyconet03',
}
