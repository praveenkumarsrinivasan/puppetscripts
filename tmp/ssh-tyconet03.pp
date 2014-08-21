sshkeys::create_key { 'tyconet03':
    home     => '/home/tyconet03/',
}

sshkeys::set_authorized_key {'tyconet03@tyconet03 to tyconet02@tyconet02':
  local_user  => 'tyconet02',
  remote_user => 'tyconet03@tyconet03',
  home        => '/home/tyconet02',
}

