class splunk::service {

  if $::operatingsystemmajrelease == '7' {

    include ::systemd

    file { '/etc/systemd/system/splunk.service':
      ensure => file,
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => 'puppet:///modules/profile/splunk/splunk.service',
      } ~>
      Exec['systemctl-daemon-reload']

      file { '/usr/local/bin/disable_thp.sh':
        ensure => file,
        owner  => 'root',
        group  => 'root',
        mode   => '0755',
        source => 'puppet:///modules/profile/splunk/disable_thp.sh',
      }

      file { '/etc/systemd/system/thp-disable.service':
        ensure => file,
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        source => 'puppet:///modules/profile/splunk/thp-disable.service',
        } ~>
        Exec['systemctl-daemon-reload']
  }
  package { 'splunk':
    ensure => present,
  }

  service { 'splunk':
    ensure    => running,
    enable    => true,
    subscribe => [Package['splunk'] ],
  }

}
