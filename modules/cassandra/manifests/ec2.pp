class cassandra::ec2{

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

      file { '/opt/apache-cassandra-2011-08-11_11-00-40-bin.tar.gz':
        ensure   => file,
        owner    => root,
        group    => root,
        source   => 'puppet:///modules/cassandra/apache-cassandra-2011-08-11_11-00-40-bin.tar.gz',
        #recurse  => true,
	notify   => Exec['extract_cassandra'],
      }

      exec { 'extract_cassandra':
        path    => ['/usr/local/bin', '/opt/local/bin', '/usr/bin', '/usr/sbin', '/bin', '/sbin'],
	command => "tar -xzf  apache-cassandra-2011-08-11_11-00-40-bin.tar.gz",
	cwd     => '/opt',
	creates  => '/opt/apache-cassandra-2011-08-11_11-00-40',
	require =>  File['/opt/apache-cassandra-2011-08-11_11-00-40-bin.tar.gz'],
      }

      file { '/opt/cassandra':
        ensure   => link,
	target   => '/opt/apache-cassandra-2011-08-11_11-00-40', 
        owner    => root,
        group    => root,
	require  => Exec['extract_cassandra'],
      }

      file { '/var/log/cassandra':
        ensure   => directory,
        owner    => root,
        group    => root,
      }

      file { '/mnt/cassandra':
        ensure   => directory,
        owner    => root,
        group    => root,
      }

      file { '/mnt/cassandra/data':
        ensure   => directory,
        owner    => root,
        group    => root,
	require  => File['/mnt/cassandra'],
      }

      file { '/mnt/cassandra/commitlog':
        ensure   => directory,
        owner    => root,
        group    => root,
	require  => File['/mnt/cassandra'],
      }

      file { '/mnt/cassandra/saved_caches':
        ensure   => directory,
        owner    => root,
        group    => root,
	require  => File['/mnt/cassandra'],
      }


      #file { '/var/lib/cassandra':
      #  ensure   => directory,
      #  owner    => root,
      #  group    => root,
      #}

      file { '/opt/cassandra/conf/cassandra.yaml':
        ensure   => present,
        mode     => '0644',
        owner    => 'root',
        group    => 'root',
        content  => template('cassandra/cassandra_yaml.ec2.erb'),
        require  => [File['/opt/cassandra'], Exec['extract_cassandra']],
	notify   => Service['cassandra'],
      }

      file { '/etc/init.d/cassandra':
        ensure   => present,
        mode     => '0777',
        owner    => 'root',
        group    => 'root',
	source   => 'puppet:///modules/cassandra/cassandra',
        require  => [File['/opt/cassandra'], Exec['extract_cassandra']],
        notify   => Service['cassandra'],
      }

      service { 'cassandra':
        ensure    => running,
	name      => 'cassandra',
	#start     => '/opt/cassandra/bin/cassandra > /dev/null 2>&1',
	#stop      => 'pgrep  -f cassandra | xargs kill -9',
	start     => '/etc/init.d/cassandra start',
	stop      => '/etc/init.d/cassandra stop',
	pattern   => 'cassandra',
	require   => [File['/opt/cassandra', '/opt/cassandra/conf/cassandra.yaml', '/etc/init.d/cassandra'], Exec['extract_cassandra']],
      }


      file { '/opt/cassandra/conf/cassandra-topology.properties':
        ensure   => present,
        mode     => '0744',
        owner    => 'root',
        group    => 'root',
        source   => 'puppet:///modules/cassandra/cassandra-topology.properties',
        require  => [File['/opt/cassandra'], Exec['extract_cassandra']],
      }

      file{ '/opt/cassandra/conf/.keystore':
        ensure   => present,
        mode     => '0644',
        owner    => root,
        group    => root,
        source   => 'puppet:///modules/cassandra/cert/keystore',
        require  => File['/opt/cassandra']
      }

      file{ '/opt/cassandra/conf/.truststore':
        ensure   => present,
        mode     => '0644',
        owner    => root,
        group    => root,
        source   => 'puppet:///modules/cassandra/cert/truststore',
        require  => File['/opt/cassandra']
      }

      file{ '/usr/lib/jvm/java-6-sun-1.6.0.26/jre/lib/security/US_export_policy.jar':
        ensure   => present,
        mode     => '0644',
        owner    => root,
        group    => root,
        source   => 'puppet:///modules/cassandra/jce/US_export_policy.jar',
        require  => Package['sun-java6-jre'],
        notify   => Service['cassandra'],
      }

      file{ '/usr/lib/jvm/java-6-sun-1.6.0.26/jre/lib/security/local_policy.jar':
        ensure   => present,
        mode     => '0644',
        owner    => root,
        group    => root,
        source   => 'puppet:///modules/cassandra/jce/local_policy.jar',
        require  => Package['sun-java6-jre'],
        notify   => Service['cassandra'],
      }


}