opts = { scope: 'user:email,repo' }

Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.production?
    provider :github, ENV['GITHUB_CLIENT_ID'], ENV['GITHUB_CLIENT_SECRET'], opts
  else
    provider :github, Rails.application.secrets.github_client_id, Rails.application.secrets.github_client_secret, opts
  end
end

# provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], scope: "user,repo,gist"
