class vcider{

      file{'/opt/vcider':
        ensure  => directory;
      }

      file{'/opt/vcider/dist':
        ensure   => directory,
	source   => 'puppet:///modules/vcider/dist',      
	recurse  => true, 
	require  => File['/opt/vcider'],
      }

      # Install vCider Package
      package { 'vcider':
          ensure    => installed,
          provider  => dpkg,
          source    => $::architecture ? {
                      'i386'   => '/opt/vcider/dist/vcider_1.0.0a_i386.deb',
                      'x86_64' => '/opt/vcider/dist/vcider_1.0.0a_amd64.deb',
                      },
          require   => File['/opt/vcider/dist'],
	  #notify    => Exec['restart_vcider'],
      }

      # vCider token 
      file{'/etc/vcider/account.key':
        ensure   => present,
	mode     => '0640',
	owner    => 'root',
	group    => 'root',
        source   => 'puppet:///modules/vcider/account.key',
        require  => Package['vcider'],
	notify   => Exec['restart_vcider'],
      }

      file{'/etc/vcider/vcider.conf':
        ensure   => present,
        mode     => '0640',
        owner    => 'root',
        group    => 'root',
        source   => 'puppet:///modules/vcider/vcider.conf',
        require  => Package['vcider'],
        notify   => Exec['restart_vcider'],
      }

      exec{'restart_vcider':
        path         => ['/usr/local/bin', '/opt/local/bin', '/usr/bin', '/usr/sbin', '/bin', '/sbin'],
	command      => "/etc/init.d/vcider-nmd restart",
	subscribe    => File['/etc/vcider/account.key'],
	refreshonly  => true,
      }
      
}