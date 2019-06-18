class User < ApplicationRecord
    after_create :create_tenant

    def create_tenant
        Apartment::Tenant.create(subdomain)
    end

    after_destroy_commit do |shop|
        Apartment::Tenant.drop(subdomain)
    end
end
