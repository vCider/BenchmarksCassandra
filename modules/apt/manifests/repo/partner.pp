class apt::repo::partner {

    # Add partnet repository
    # apt::key { "99B656EA8683D8A2": }

    apt::repository { "partner":
        url        => "http://archive.canonical.com/",
        distro     => "${lsbdistcodename}",
        repository => "partner",
	#require    => Exec["aptkey_add_99B656EA8683D8A2"],
    }

}

