require 'gossip'
require 'comments'
class ApplicationController < Sinatra::Base

  get'/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get'/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end

  get '/gossips/:id/' do
    gossip = Gossip.find(params['id'].to_i)
    erb :show, locals: {gossip: gossip, comments: Comments.all(params['id'])}
  end

  post '/gossips/:id/' do
    com = Comments.new(params['comment'], params['id'])
    com.save
    redirect '/'
  end

  get '/gossips/:id/edit/' do
    gossip = Gossip.find(params['id'].to_i)
    erb :edit, locals: {gossip: gossip}
  end

  post '/gossips/:id/edit/' do
    Gossip.update(params['id'].to_i, params["gossip_author"], params["gossip_content"])
    redirect '/'
  end
  
end