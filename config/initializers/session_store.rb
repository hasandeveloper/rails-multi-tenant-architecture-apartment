Rails.application.config.session_store :cookie_store, key: '_myapp_session', domain: {
  production:   '.klocapps.com',
  staging:      '.klocapps.com',
  development:  '.lvh.me'
}.fetch(Rails.env.to_sym, :all)