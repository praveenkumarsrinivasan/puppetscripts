define accounts::virtual ($uid,$realname,$pass,$sshkeytype,$sshkey) {
    include accounts::params

    # Pull in values from accounts::params
    $homepath =  $accounts::params::homepath
    $shell    =  $accounts::params::shell

  # Create the user
    user { $title:
        ensure            =>  'present',
        uid               =>  $uid,
        gid               =>  $title,
        shell             =>  $shell,
        home              =>  "${homepath}/${title}",
        comment           =>  $realname,
        password          =>  $pass,
        managehome        =>  true,
        require           =>  Group[$title],
    }
    
    # Create a matching group
    group { $title:
        gid               => $uid,
    }

    # Ensure the home directory exists with the right permissions
    file { "${homepath}/${title}":
        ensure            =>  directory,
        owner             =>  $title,
        group             =>  $title,
        mode              =>  '0750',
        require           =>  [ User[$title], Group[$title] ],
    }

    # Ensure the .ssh directory exists with the right permissions
    file { "${homepath}/${title}/.ssh":
        ensure            =>  directory,
        owner             =>  $title,
        group             =>  $title,
        mode              =>  '0700',
        require           =>  File["${homepath}/${title}"],
    }

    # Add user's SSH key
    if ($sshkey != '') {
        ssh_authorized_key {$title:
            ensure          => present,
            name            => $title,
            user            => $title,
            type            => $sshkeytype,
            key             => $sshkey,
        }
    }
}

@accounts::virtual { 'cloudera':
  uid             =>  5001,
  realname        =>  'Cloudera',
  pass            =>  '<insert password hash here>',
    password => '$6$m6AiKz4RuKnmg$DKDxOKzYN2eEG1l9XAyoHoBQHzPLtQNdDD/BwwoybBjLjRvVKeT/zpv.I33aeRIfcK9yLskSajv2qxWhUqyLt0',
  groups => ["sudo"],
  shell => '/bin/bash',
  sshkeytype      =>  'ssh-rsa',
  sshkey          =>  '<insert SSH key here>',
  require         =>  Class['accounts::config'],
}

