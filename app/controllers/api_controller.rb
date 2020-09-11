class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  def news
    tweets = Tweet.all.last(50).reverse
    latest_retweets = Retweet.all.group_by(&:tweet_id).map{|s| s.last.last}

    tweets = tweets.map do |tweet|
      #Auxiliar para obtener el último retweet del tweet asociado
      aux_rt = latest_retweets.select { |rt| rt.tweet_id == tweet.id}
      #Auxiliar para solo obtener el id del usuario asociado al retweet
      aux_rt2 = aux_rt.map do |hash|
        hash[:user_id]
      end
      #Auxiliar para reemplazar los datos null
      aux_rt3 = 'no retweets'
      if aux_rt2[0] != nil
        aux_rt3 = aux_rt2[0]
      end
        

      #lógica del hash a devolver
      { 
        id: tweet.id, 
        content: tweet.content, 
        user: tweet.user_id,  
        like_count: tweet.likes_count,
        retweets_count: tweet.retweets_count,
        retwitter_from: aux_rt3
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

  def tweets
    user = User.authenticate(params[:email], params[:password])
    @tweet = Tweet.new(tweet_params)
    @tweet.user = user
  end


  private
  def tweet_params
    params.require(:tweet).permit(:content, :user_id, :like_count, :retweets_count)
  end

end