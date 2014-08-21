sshkeys::create_key { 'cloudera':
    home     => '/home/cloudera/',
    ssh_keytype => 'rsa',
}

sshkeys::set_authorized_key {'cloudera@tyconet02 to cloudera@tyconet03':
  local_user  => 'cloudera',
  remote_user => 'cloudera@',
  home        => '/home/cloudera',
}
