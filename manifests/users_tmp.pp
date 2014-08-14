module { 'puppetlabs/puppetdb':
    ensure     => present,
    modulepath => '/etc/puppet/modules',
}

module { 'dalen/puppetdbquery':
    ensure     => present,
    modulepath => '/etc/puppet/modules',
}

module { 'jtopjian/sshkeys':
    ensure     => present,
    modulepath => '/etc/puppet/modules',
}
exec { 'ssh-keygen':
    user => 'cloudera',
    command => 'ssh-keygen -q -t rsa -b 4096 -f /home/cloudera/.ssh/id_rsa -N ""',
    path => '/home/cloudera/',
}

file {"/home/cloudera/.ssh/id_rsa":
    mode   => '600',
    owner  => 'cloudera',
    group  => 'cloudera',
}

file {"/home/cloudera/.ssh/id_rsa.pub":
    mode   => '644',
    owner  => 'cloudera',
    group  => 'cloudera',
}

ssh_authorized_key { "cloudera":
    ensure  => present,
    user    => 'cloudera',
    type    => 'ssh-rsa',
    key     => generate("/etc/puppet/modules/tyconet/bin/extract_key", "~/.ssh/id_rsa.pub"),
}
exec { "ssh-copy":
    command => 'ssh-copy-id -i ~/.ssh/id_rsa.pub cloudera@tyconet01.tyco.com',
}
