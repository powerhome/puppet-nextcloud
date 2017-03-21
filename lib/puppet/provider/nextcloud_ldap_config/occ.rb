require 'tempfile'

Puppet::Type.type(:nextcloud_ldap_config).provide(:occ) do
  defaultfor :operatingsystem => :debian

  # Provider commands
  commands :occ => 'occ'

  mk_resource_methods

  def self.instances
    instances = []

    # Get all databases
    databases = ldapsearch('-Q', '-LLL', '-Y', 'EXTERNAL', '-b', 'cn=config', '-H', 'ldapi:///', "(olcDbNoSync=*)").split("\n\n")

    # Process each database definition
    databases.each do |block|
      db_attrs = block.gsub("\n ", "").split("\n")
      suffix   = nil

      # Attributes to ignore
      ignore_attrs = Regexp.union([
        /^dn: /,
        /^olcRootPW:: /,
        /^olcDbIndex: /,
        /^olcSyncrepl: /,
        /^olcAccess: /,
        /^objectClass: /,
        /^olcSuffix: /
      ])

      # Get the database suffix
      db_attrs.each do |line|
        if line =~ /^olcSuffix: /
          suffix = line.split(' ')[1]
        end
      end

      # Get database attributes
      db_attrs.each do |line|

        # Ignore certain attributes
        if line.match(ignore_attrs)
          next
        end

        # Other attributes
        db_entry = line.split(': ')
        attribute = db_entry[0]
        value = db_entry[1]

        # New instance
        instances << new(
          :name      => "#{suffix} #{attribute}",
          :ensure    => :present,
          :attribute => attribute,
          :value     => value,
          :suffix    => suffix
        )
      end
    end
    instances
  end

  def self.prefetch(resources)
    db_config = instances
    resources.keys.each do |name|
      if provider = db_config.find{ |conf| conf.name == name }
        resources[name].provider = provider
      end
    end
  end

  def create
    dn = getDN(resource[:suffix])

    # Attribute LDIF
    t  = Tempfile.new("ldap_dbconf")

    # Generate the attribute LDIF
    t << "dn: #{dn}\n"
    t << "changetype: modify\n"
    t << "add: #{resource[:attribute]}\n"
    t << "#{resource[:attribute]}: #{resource[:value]}\n"
    t.close()

    # Run the attribute LDIF
    ldapmodify('-Y', 'EXTERNAL', '-H', 'ldapi:///', '-f', t.path)
  end

  def exists?
    @property_hash[:ensure] == :present
  end

  def getDN(suffix)
    ldapsearch('-Q', '-LLL', '-Y', 'EXTERNAL', '-b', 'cn=config', '-H', 'ldapi:///', "(olcSuffix=#{suffix})").split("\n").collect do |line|
      if line =~ /^dn: /
        return line.split(' ')[1]
      end
    end
  end
end
