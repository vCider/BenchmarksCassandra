# Define: apt::key
#
# Add key to keyring
#
# Usage:
#  apt::key { "key id":
#      url => 'key url',
#  }
#
#
define apt::key ( $url="" ) { 

    case $url {
        '' : { 
            exec { "aptkey_add_${name}":
	   	path    => ['/usr/local/bin', '/opt/local/bin', '/usr/bin', '/usr/sbin', '/bin', '/sbin'],
                command => "gpg --recv-key ${name} ; gpg -a --export | apt-key add -",
                unless  => "/usr/bin/apt-key list | grep -q ${name}",
		notify  => Exec["aptget_update"],
            }
        }
        default: {  
            exec { "aptkey_add_${name}":
                command => "wget -O - ${url} | apt-key add -",
	        unless  => "apt-key list | grep -q ${name}",
            }
        }
    }
}
