class openvpn::server{

      include openvpn 

      file { '/etc/openvpn': 
        ensure   => directory,
        owner    => root,
        group    => root,
        source   => 'puppet:///modules/openvpn/server/openvpn',
        recurse  => true,
        notify   => Service['openvpn'],
      }


}