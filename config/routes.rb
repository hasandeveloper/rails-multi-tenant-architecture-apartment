class SubdomainConstraint
  def self.matches?(request)
    subdomains = %w{ www admin }
    # binding.pry
    request.subdomain.present? && !subdomains.include?(request.subdomain)
  end
end

Rails.application.routes.draw do
  constraints SubdomainConstraint do
    resources :projects
  end
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
