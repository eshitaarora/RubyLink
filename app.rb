#app.rb

require 'sinatra'
require 'securerandom'
# app.rb

# app.rb

require 'sinatra/base'
require 'webrick'

# Set the web server handler explicitly to WEBrick
configure { |c| c.server = 'webrick' }

# Rest of your code...

# Run the application
Sinatra::Application.run!


# In-memory data store to hold the URL mappings
$url_mappings = {}

get '/' do
  erb :index
end

post '/shorten' do
  long_url = params[:long_url]
  short_url = generate_short_url

  $url_mappings[short_url] = long_url

  erb :shortened, locals: { short_url: short_url }
end

get '/:short_url' do
  short_url = params[:short_url]
  long_url = $url_mappings[short_url]

  redirect long_url || '/'
end

def generate_short_url
  # Generate a unique short URL using a random alphanumeric string
  SecureRandom.urlsafe_base64(6)
end
