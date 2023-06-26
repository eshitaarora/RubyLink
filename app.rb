# app.rb

require 'sinatra'
require 'securerandom'

# Data structure to store URL mappings
URL_MAP = {}

# Home page
get '/' do
  erb :index
end

# Shorten URL
post '/shorten' do
  long_url = params[:long_url]
  short_url = generate_short_url
  URL_MAP[short_url] = long_url
  erb :shortened, locals: { short_url: short_url }
end

# Redirect to the original URL
get '/:short_url' do |short_url|
  long_url = URL_MAP[short_url]
  if long_url
    redirect long_url
  else
    'Short URL not found'
  end
end

# Helper method to generate a unique short URL
def generate_short_url
  loop do
    short_url = SecureRandom.urlsafe_base64(6)[0...6]
    return short_url unless URL_MAP.key?(short_url)
  end
end
