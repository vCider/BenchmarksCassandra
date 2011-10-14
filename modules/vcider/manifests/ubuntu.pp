class vcider::ubuntu{

      include vcider

      package { 'vcider':
          ensure    => installed,
          provider  => dpkg,
          source    => $::architecture ? {
                      'i386'   => '/opt/vcider/dist/vcider_1.0.0a_i386.deb',
                      'x86_64' => '/opt/vcider/dist/vcider_1.0.0a_amd64.deb',
                      },
          require   => File['/opt/vcider/dist'],
      }

}
