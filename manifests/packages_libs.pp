#===========================
# Packages 
#===========================
$cloudera_dependency = [
    "zsh",
    "rsync",
    "build-essential",
    "python-dev",
    "python-virtualenv",
    "python-setuptools",
    "python-pip",
    "vim",
    "zlib1g-dev",
    "zlib1g",
    "libssl-dev",
    "ruby1.9.3",
    "sshpass",
]
package { $cloudera_dependency: 
    ensure => "installed"
}

#===========================
# Install Ruby
#===========================

file { "/etc/alternatives/ruby":
    ensure => "/usr/bin/ruby1.9.3";
}

file { "/etc/alternatives/gem":
    ensure => "/usr/bin/gem1.9.3";
}

file { "/etc/puppet/files":
    ensure => 'present',
}

file { "/etc/puppet/files/update_rubygems.sh":
    ensure => 'present',
    owner => "root",
    group => "root",
    mode => 755,
    source => "puppet:///files/update_rubygems.sh"
}   

exec {'/etc/puppet/files/update_rubygems.sh': 
    command => '/bin/bash /etc/puppet/files/update_rubygems.sh',
    require => File['/etc/puppet/files/update_rubygems.sh'],
    path => '/etc/puppet/files/:/usr/bin',
}

#===========================
# Python Libs
#===========================
$python_libs = [
    "virtualenv",
    "avro",
    "numpy"
]
pip { $python_libs:
    ensure => "installed"
}
define pip($ensure = installed) {
    case $ensure {
        installed: {
            exec { "pip install $name":
                path => "/usr/local/bin:/usr/bin:/bin",
            }
        }
        latest: {
            exec { "pip install --upgrade $name":
                path => "/usr/local/bin:/usr/bin:/bin",
            }
        }
        default: {
            exec { "pip install $name==$ensure":
                path => "/usr/local/bin:/usr/bin:/bin",
            }
        }
    }
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
# Install Puppet Module
#===========================

file { "/etc/puppet/files/install_puppet-module.sh":
    ensure => 'present',
    owner => "root",
    group => "root",
    mode => 755,
    source => "puppet:///files/install_puppet-module.sh"
}   

exec {'/etc/puppet/files/install_puppet-module.sh': 
    command => '/bin/bash /etc/puppet/files/install_puppet-module.sh',
    require => File['/etc/puppet/files/install_puppet-module.sh'],
    path => '/etc/puppet/files/:/usr/bin',
}

