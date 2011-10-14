class openvpn {

      package { 'openvpn':
        ensure    => installed,
      }

	  
      file { '/etc/default/openvpn':
        ensure   => present,
        mode     => '0644',
        owner    => 'root',
        group    => 'root',
        source   => 'puppet:///modules/openvpn/openvpn',
        require  => Package['openvpn'],
        notify   => Service['openvpn'],
      }

      service { 'openvpn':
        ensure       => running,
        pattern      => 'openvpn',
   	require      => Package['openvpn'],
	#refreshonly  => true,
      }
}