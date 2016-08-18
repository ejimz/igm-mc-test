module Rb_manager
  module Helpers
    def get_domain_info(domain)
      return `geoiplookup #{domain}`
    end
  end
end
