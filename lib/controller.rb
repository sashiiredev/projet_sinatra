require 'gossip'

class ApplicationController < Sinatra::Base

  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end

  get '/gossips/:id/' do
    id = params['id']
    to_print = Gossip.find(id)
    if to_print.comment != nil
      comment = to_print.comment.split('..;..')
    end
    erb :show, locals: {gossip: to_print, nb: id, comment: comment}
  end

  get '/gossips/:id/edit/' do
    id = params['id']
    to_print = Gossip.find(id)
    erb :edit, locals: {nb: id, gossip: to_print}
  end

  post '/gossips/:id/edit/' do
    id = params['id'].to_i
    Gossip.edit(id, params["new_gossip_author"], params["new_gossip_content"])
    redirect '/'
  end

  post '/gossips/:id/' do
    id = params['id'].to_i
    Gossip.comment(id, params["gossip_comment"])
    redirect '/'
  end
end
