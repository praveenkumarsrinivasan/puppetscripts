file { "/etc/hosts":
    owner => "root",
    group => "root",
    mode => 644,
    content => template("tyconet/hosts.erb") 
}   
