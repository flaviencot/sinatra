require 'gossip'

class ApplicationController < Sinatra::Base
  
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"],params["gossip_content"]).save
    redirect '/'
  end

  get '/gossips/:id' do
    id = params[:id].to_i
    # read the CSV file and retrieve the row with the specified ID
    csv = CSV.read("./db/gossip.csv")
    if csv[id-1]
      gossip = Gossip.new(csv[id-1][0], csv[id-1][1])
      erb :gossip, locals: {gossip: gossip}
    else
      "Gossip not found"
    end
  end

end