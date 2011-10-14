class cassandra::client{

      include apt
      require apt::repo::partner

      exec { 'jre_noninteractive':
            command    => '/bin/echo "sun-java6-jre shared/accepted-sun-dlj-v1-1 boolean true" | /usr/bin/debconf-set-selections',
            logoutput  => false,
            #creates    => '/usr/bin/java'
      }

      package { 'sun-java6-jre':
         ensure   => present,
         require  => [ Exec['jre_noninteractive'], File['/etc/apt/sources.list.d/partner.list'], Exec[aptget_update]],
      }

      file { '/opt/apache-cassandra-0.8.2-src.tar.gz':
        ensure   => file,
        owner    => root,
        group    => root,
        source   => 'puppet:///modules/cassandra/apache-cassandra-0.8.2-src.tar.gz',
        #recurse  => true,
	notify   => Exec['extract_cassandra'],
      }

      exec { 'extract_cassandra':
        path    => ['/usr/local/bin', '/opt/local/bin', '/usr/bin', '/usr/sbin', '/bin', '/sbin'],
	command => "tar -xzf apache-cassandra-0.8.2-src.tar.gz",
	cwd     => '/opt',
	creates  => '/opt/apache-cassandra-0.8.2-src',
	require =>  File['/opt/apache-cassandra-0.8.2-src.tar.gz'],
      }

      file { '/opt/cassandra':
        ensure   => link,
	target   => '/opt/apache-cassandra-0.8.2-src', 
        owner    => root,
        group    => root,
	require  => Exec['extract_cassandra'],
      }

      file { '/var/log/cassandra':
        ensure   => directory,
        owner    => root,
        group    => root,
      }

      file { '/var/lib/cassandra':
        ensure   => directory,
        owner    => root,
        group    => root,
      }



}