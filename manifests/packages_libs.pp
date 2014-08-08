#===========================
# Packages 
#===========================

$cloudera_dependency = [
    "zsh",
    "rsync",
    "python-virtualenv",
    "python-setuptools",
    "python-pip",
    "build-essential",
    "python-dev",
    "vim"
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
