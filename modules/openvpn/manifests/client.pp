class openvpn::client{

      include openvpn 

      file { '/etc/openvpn': 
        ensure   => directory,
        owner    => root,
        group    => root,
        source   => 'puppet:///modules/openvpn/client/openvpn',
        recurse  => true,
        notify   => Service['openvpn'],
      }

      file { '/etc/openvpn/openvpn.conf':
        ensure   => present,
        mode     => '0644',
        owner    => 'root',
        group    => 'root',
        content  => template('openvpn/openvpn.conf.erb'),
        require  => [File['/etc/openvpn'], Package['openvpn']],
        notify   => Service['openvpn'],
      }



}