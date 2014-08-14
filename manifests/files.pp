file { "/etc/puppet/puppet.conf":
    owner => "root",
    group => "root",
    mode => 644,
    source => "puppet:///files/puppet.conf"
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
