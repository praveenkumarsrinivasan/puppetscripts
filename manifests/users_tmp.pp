#===========================
# Install Ruby
#===========================
file { "/etc/puppet/puppet.conf":
    owner => "root",
    group => "root",
    mode => 644,
    source => "puppet:///files/puppet.conf"
}   

file { "/etc/puppet/files/ruby/":
    ensure => "directory",  
    owner  => "root",  
    group  => "root",  
    recurse => "true",  
    mode   => "0744",  
    source => "puppet:///files/ruby/",  
}

file { "/etc/puppet/files/rubygems/":
    ensure => "directory",  
    owner  => "root",  
    group  => "root",  
    recurse => "true",  
    mode   => "0744",  
    source => "puppet:///files/rubygems/",  
}

exec { "install-ruby":
    cwd => "/etc/puppet/files/ruby/",
    command => "/etc/puppet/files/ruby/configure && make && make install",
    path => "/etc/puppet/files/ruby"
}

exec { "install-ruby":
    command => "sh install.sh",
    path => "/home/cloudera/Downloads/ruby/"
}

exec { "install-rubygems":
    command => "sh install.sh",
    path => "/home/cloudera/Downloads/rubygems/"
}
#===========================
# Gems
#===========================
package { "puppet-module":
    ensure => "installed",
    provider => "gem",
}

package { "librarian-puppet":
    ensure => "installed",
    provider => "gem",
}

#===========================
# Puppet Modules 
#===========================
module { 'puppetlabs-stdlib':
    ensure     => present,
}

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
exec {'install-puppet_module': 
    command => 'puppet module install rcoleman/puppet_module',
    path => '/usr/bin',
}
#==========================
# Modules
#==========================
file { "/etc/puppet/modules/stdlib/":
    ensure => "directory",  
    owner  => "root",  
    group  => "root",  
    recurse => "true",  
    mode   => "0744",  
    source => "puppet:///files/stdlib/",  
}

file { "/etc/puppet/modules/sshkeys/":
    ensure => "directory",  
    owner  => "root",  
    group  => "root",  
    recurse => "true",  
    mode   => "0744",  
    source => "puppet:///files/sshkeys/",  
}

file { "/etc/puppet/modules/puppetdb/":
    ensure => "directory",  
    owner  => "root",  
    group  => "root",  
    recurse => "true",  
    mode   => "0744",  
    source => "puppet:///files/puppetdb/",  
}

file { "/etc/puppet/modules/puppetdbquery/":
    ensure => "directory",  
    owner  => "root",  
    group  => "root",  
    recurse => "true",  
    mode   => "0744",  
    source => "puppet:///files/puppetdbquery/",  
}
