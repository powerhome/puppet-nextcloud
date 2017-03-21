Puppet::Type.newtype(:nextcloud_ldap_config) do
  @doc = 'Configures Nextcloud LDAP settings'

  ensurable

  newparam(:name, :namevar => true) do
    desc "The LDAP configuration directive name"
  end

  newparam(:value) do
    desc "The value to set for the configuration directive"
  end

  newparam(:config) do
    desc 'LDAP configuration ID'
    defaultto 's01'
  end
end
