Puppet::Type.type(:nextcloud_ldap_config).provide(:occ) do
  defaultfor :operatingsystem => :debian

  # Provider commands
  commands :occ => 'occ'

  mk_resource_methods

  def self.instances
    instances = []

    # Get the current LDAP configuration
    config = occ(['ldap:show-config', 's01', '--show-password']).split("\n")

    # Process each LDAP configuration definition
    config.each do |line|
      if line =~ /^\| [a-zA-Z]/
        key, value = /^\|[ ]([^ ]*)[ ]*\|[ ]*([^ \|]*).*$/.match(line).captures

        # Ignore configuration title
        if key != 'Configuration'

          # New instance
          instances << new(
            :name   => key,
            :ensure => :present,
            :value  => value
          )
        end
      end
    end
    instances
  end

  def self.prefetch(resources)
    instances.each do |prov|
      if resource = resources[prov.name]
        resource.provider = prov
      end
    end
  end

  def create
    notice("Create: #{resource[:name]} -> #{resource[:value]}")
    occ(['ldap:set-config', 's01', resource[:name], resource[:value]])
    @property_hash[:ensure] == :present
  end

  def exists?
    @property_hash[:ensure] == :present
  end
end
