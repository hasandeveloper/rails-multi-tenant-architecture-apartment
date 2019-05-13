class ApplicationController < ActionController::Base
    before_action :set_account

    def set_account
        binding.pry
        puts request.subdomain
    end
end
