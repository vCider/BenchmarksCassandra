class cassandra::encryption{

      include cassandra::ec2multiregion

      file{ '/opt/cassandra/conf/.keystore':
        ensure   => present,
	mode	 => '0644',
	owner	 => root,
	group	 => root,
	source	 => 'puppet:///modules/cassandra/cert/keystore',
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

#      file { '/opt/cassandra/conf/cassandra.yaml':
#        ensure   => present,
#        mode     => '0644',
#        owner    => 'root',
#        group    => 'root',
#        content  => template('cassandra/cassandra_yaml.ec2multiregion.encryption.erb'),
#        require  => [File['/opt/cassandra'], Exec['extract_cassandra']],
#        notify   => Service['cassandra'],
#      }


#      file{ '/opt/jce_policy-6.zip':
#        ensure   => present,
#        mode     => '0644',
#        owner    => root,
#        group    => root,
#        source   => 'puppet:///modules/cassandra/jce_policy-6.zip',
#        require  => Package['sun-java6-jre'],
# 	 notify   => Exec['unzip_jce'],
#      }

#      exec{ 'unzip_jce':
#        path       => ['/usr/local/bin', '/opt/local/bin', '/usr/bin', '/usr/sbin', '/bin', '/sbin'],
#        command    => "unzip jce_policy-6.zip",
#        cwd        => '/opt',
#        creates    => '/opt/jce',
#        require    =>  File['/opt/jce_policy-6.zip'],
#      }

}