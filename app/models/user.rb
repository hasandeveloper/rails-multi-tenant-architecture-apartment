class User < ApplicationRecord
    after_create :create_tenant

    def create_tenant
        Apartment::Tenant.create(subdomain)
    end

end
