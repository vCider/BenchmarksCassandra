class vcider::redhat{

      include vcider

      package { 'vcider':
          ensure    => installed,
          provider  => rpm,
          source    => $::architecture ? {
                      'i386'   => '/opt/vcider/dist/vcider_1.0.0a_i386.rpm',
                      'x86_64' => '/opt/vcider/dist/vcider_1.0.0a_amd64.rpm',
                      },
          require   => File['/opt/vcider/dist'],
      }

}
