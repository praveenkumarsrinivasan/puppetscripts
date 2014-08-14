user { 'cloudera':
    ensure => 'present',
    managehome => true,
    groups => ["sudo"],
    shell => '/bin/bash',
    home => '/home/cloudera',
    comment => 'Cloudera',
    password => '$6$m6AiKz4RuKnmg$DKDxOKzYN2eEG1l9XAyoHoBQHzPLtQNdDD/BwwoybBjLjRvVKeT/zpv.I33aeRIfcK9yLskSajv2qxWhUqyLt0',
}

