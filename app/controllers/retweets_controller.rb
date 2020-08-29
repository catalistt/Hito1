class RetweetsController < ApplicationController
  def index
    @retweets = Retweet.All
  end


  def show
    
  end


  def new
    @retweet = Retweet.new
  end

  def edit
  end

  def create
    #misma lógica que para likes

    #pasos para obtener el id de tweets a través de format (hash que "manda")
    tweet = Tweet.find_by(id:params[:format])
    tweet_id = tweet.id
    #obtener el id de user a través del helper de devise
    user_id = current_user.id
    tiene_retweet = Retweet.where(user_id: user_id, tweet_id: tweet_id).present?

    #luego de tener al tweet y user asociado, hay que determinar si existe un registro de ese retweet
    #considerar que el registro sea mayor a 0, sino quedará negativo
    if tiene_retweet && tweet.retweets_count > 0
      #si tiene retweet, entonces que lo elimine del registro de la tabla tweet
      tweet.retweets_count-=1
    else
      #se crea un retweet con el usuario y tweet correspondiente
      Retweet.create(user_id:user_id, tweet_id:tweet_id)
      #se traspasa la info a la tabla tweet
      tweet.retweets_count+=1
    end
    #para recargar la página con los nuevos likes/dislikes
    redirect_back(fallback_location: root_path)
    #para guardar en la tabla de tweets
    tweet.save
  end

  def update
    respond_to do |format|
      if @retweet.update(retweet_params)
        format.html { redirect_to @retweet, notice: 'retweet was successfully updated.' }
        format.json { render :show, status: :ok, location: @retweet }
      else
        format.html { render :edit }
        format.json { render json: @retweet.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @retweet.destroy
    respond_to do |format|
      format.html { redirect_to retweets_url, notice: 'retweet was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_retweet
      @retweet = Retweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def retweet_params
      params.require(:retweet).permit(:user, :tweet)
    end
end
