###########################################################################################
##     Example Configuration for Cassandra Cluster with Vcider Virtual Network Module    ##
###########################################################################################
#
# Initial Tokesn are calculated for 8 nodes cluster. 
# Vcider Virtual Network is 192.168.2.0/24
# Seed Nodes are 192.168.2.1 and 192.168.2.6
#

node basenode {
  include vcider
  include cassandra
}

#Node 1
node 'HOSTNAME-1'{
  $seed_host      = "192.168.2.1,192.168.2.6"
  $vcider_address = "192.168.2.1"
  $initial_token   = 0
  include vcider
  include cassandra
}

#Node 2
node 'HOSTNAME-2'{
  $seed_host      = "192.168.2.1,192.168.2.6"
  $vcider_address = "192.168.2.2"
  $initial_token   = 85070591730234615865843651857942052864
  include vcider
  include cassandra
}

#Node 3
node 'HOSTNAME-3'{
  $seed_host      = "192.168.2.1,192.168.2.6"
  $vcider_address = "192.168.2.3"
  $initial_token   = 85070591730234615865843651857942052864
  include vcider
  include cassandra
}

#Node 4
node 'HOSTNAME-4'{
  $seed_host      = "192.168.2.1,192.168.2.6"
  $vcider_address = "192.168.2.4"
  $initial_token   = 127605887595351923798765477786913079296
  include vcider
  include cassandra
}

####################
#Client
node 'HOSTNAME-CLIENT1'{
  $seed_host = "192.168.2.1,192.168.2.6"
  $vcider_address = "192.168.2.5"
  include vcider
  include cassandra::client
}

node 'HOSTNAME-CLIENT2'{
  $seed_host = "192.168.2.1,192.168.2.6"
  $vcider_address = "192.168.2.10"
  include vcider
  include cassandra::client
}

####################

#Node5
node 'HOSTNAME-6'{
  $seed_host = "192.168.2.1,192.168.2.6"
  $vcider_address = "192.168.2.6"
  $initial_token   = 1
  include vcider
  include cassandra
}

node 'HOSTNAME-7'{
  $seed_host = "192.168.2.1,192.168.2.6"
  $vcider_address = "192.168.2.7"
  $initial_token   = 85070591730234615865843651857942052865
  include vcider
  include cassandra
}

node 'HOSTNAME-8'{
  $seed_host = "192.168.2.1,192.168.2.6"
  $vcider_address = "192.168.2.8"
  $initial_token   = 85070591730234615865843651857942052865
  include vcider
  include cassandra
}

node 'HOSTNAME-9'{
  $seed_host = "192.168.2.1,192.168.2.6"
  $vcider_address = "192.168.2.9"
  $initial_token   = 127605887595351923798765477786913079297
  include vcider
  include cassandra
}


