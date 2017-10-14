 Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '296876317462956', 'bd8467244ec6ed53bba75aac448a2056', { scope: 'email, user_friends' }
end
