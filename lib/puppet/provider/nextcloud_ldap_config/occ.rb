Puppet::Type.type(:nextcloud_ldap_config).provide(:occ) do
  defaultfor :operatingsystem => :debian

  # Provider commands
  commands :occ => 'occ'

  mk_resource_methods

  def self.instances
    instances = []

    # Get the current LDAP configuration
    config = occ('ldap:show-config').split("\n")

    # Process each LDAP configuration definition
    config.each do |line|
      if line =~ /^\| [a-zA-Z]/
        key, value = /^\|[ ]([^ ]*)[ ]*\|[ ]*([^ \|]*).*$/.match(line).captures

        # Ignore configuration title
        if key != 'Configuration'
          notice("Discovered LDAP configuration: #{key} = #{value}")

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
    ldap_config = instances
    resources.keys.each do |name|
      if provider = ldap_config.find{ |conf| conf.name == name }
        resources[name].provider = provider
      end
    end
  end

  def create
    occ(['ldap:set-config', 's01', resource[:name], resource[:value]])
  end

  def exists?
    @property_hash[:ensure] == :present
  end
end
