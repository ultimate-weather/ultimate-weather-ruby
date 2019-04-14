require 'sinatra'

get '/frank-says' do
  'Put this in your pipe & smoke it!'
end

get '/indy/current-temp/' do
  '50'
end

get '/46420/current-temp/' do
  '66'
end
