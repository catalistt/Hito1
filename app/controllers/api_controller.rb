class ApiController < ApplicationController

  def news
    tweets = Tweet.all.last(50).reverse

    tweets = tweets.map do |tweet| { 
        id: tweet.id, 
        content: tweet.content, 
        user: tweet.user_id,  
        like_count: tweet.likes_count,
        retweets: tweet.retweets_count,
        #retwitter_from:
        }
      end
      if tweets
        render json: tweets, status: :ok
      else
        #Error en formato json
        render json: { error: "Error: tweets no encontrados." }, status: 400
      end
    
  end

  def dates
    #convertir los strings recibidos en fechas 
    from = Date.strptime(params[:from],("%Y-%m-%d"))
    to = Date.strptime(params[:to],("%Y-%m-%d"))

    #consulta entre rango de fechas
    tweets = Tweet.where(created_at: from..to)
    
    if tweets
      render json: tweets, status: :ok
    else
      #Error en formato json
      render json: { error: "Error: fechas o parámetros no encontrados." }, status: 400
    end
  end
end
