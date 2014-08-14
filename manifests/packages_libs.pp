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
    "zlibssl-dev",
]
package { $cloudera_dependency: 
    ensure => "installed"
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
# Install Ruby
#===========================
file { "/home/cloudera/Downloads/ruby/":
    ensure => "directory",  
    owner  => "root",  
    group  => "root",  
    recurse => "true",  
    mode   => "0744",  
    source => "puppet:///files/ruby/",  
}

file { "/home/cloudera/Downloads/rubygems/":
    ensure => "directory",  
    owner  => "root",  
    group  => "root",  
    recurse => "true",  
    mode   => "0744",  
    source => "puppet:///files/rubygems/",  
}

exec { "intsall-ruby":
    command => "sh install.sh",
    path => "/home/cloudera/Downloads/ruby/"
}

exec { "intsall-ruby":
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
