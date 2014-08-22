file { "/etc/sudoers":
    owner => "root",
    group => "root",
    mode => 400,
    source => "puppet:///files/sudoers"
}   

file { "/home/cloudera/.bashrc":
    owner => "cloudera",
    group => "cloudera",
    mode => 644,
    source => "puppet:///files/.bashrc"
}   

