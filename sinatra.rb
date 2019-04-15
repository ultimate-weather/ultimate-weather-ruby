require 'sinatra'

get '/now' do
  headers "Expires" => "0"
  'Ultimate Weather - the always reloaded page' + Time.now.to_s
end

get '/slashed/?' do
  'Ultimate Weather  - a trailing slash in the URL (or none) will both work here!' + Time.now.to_s
end

get '/place/indy/current_temp' do
  '21'
end

get '/zip/46420/current_temp' do
  '67'
end

get '/haml' do
  haml :hamilee
end

get '/haml_with_var' do
  @day='Monday'
  @time=Time.now
  haml :hamilee
end

get '/erby' do
  erb :erby
end

get '/' do
  headers 'Expires' => '0'
  'Welcome to Ultimate Weather'
  "Your params zip is #{params[:zip]}"
end

not_found do
  "Something went wrong with the format of your request - and the route wasn't found from that URL"
end

