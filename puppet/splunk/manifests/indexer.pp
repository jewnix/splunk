class splunk::indexer {

  file { [ '/usr/local/', '/usr/local/bin/' ]:
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0750',
  }

  file { '/usr/local/bin/clean_frozen.sh':
    ensure => file,
    source => 'puppet:///modules/profile/clean_frozen.sh',
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
  }

  cron { 'clean_frozen':
    command => '/usr/local/bin/clean_frozen.sh',
    user    => 'root',
    hour    => 3,
    minute  => 0
  }

  if $::operatingsystemmajrelease == '7' {

    include ::systemd

    file { '/usr/local/bin/disable_thp.sh':
      ensure => file,
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
      source => 'puppet:///modules/profile/disable_thp.sh',
    }

    file { '/etc/systemd/system/thp-disable.service':
      ensure => file,
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => 'puppet:///modules/profile/thp-disable.service',
      } ~>
      Exec['systemctl-daemon-reload']

      file { '/etc/systemd/system/splunk.service':
        ensure => file,
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        source => 'puppet:///modules/profile/splunk.service',
        } ~>
        Exec['systemctl-daemon-reload']
  }

}

