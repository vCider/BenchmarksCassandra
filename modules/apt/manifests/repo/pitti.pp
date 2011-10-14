class apt::repo::pitti {

    # Add puppetlabs repository
    #apt::key { "99B656EA8683D8A2": }

    apt::repository { "pitti_postgres":
        url        => "http://ppa.launchpad.net/pitti/postgresql/ubuntu",
        distro     => "${lsbdistcodename}",
        repository => "main",
	#require    => Exec["aptkey_add_99B656EA8683D8A2"],
    }

}

