Rails.application.config.session_store :cookie_store, key: 'refer_and_earn_v2_app2_session', domain: {
  production:   '.klocapps.com',
  staging:      '.klocapps.com',
  development:  '.lvh.me'
}.fetch(Rails.env.to_sym, :all)