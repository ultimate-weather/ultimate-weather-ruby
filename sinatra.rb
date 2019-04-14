require 'sinatra'

get '/' do
  'Welcome to Ultimate Weather'
end

get '/place/indy/current_temp' do
  '21'
end

get '/zip/46420/current_temp' do
  '67'
end
