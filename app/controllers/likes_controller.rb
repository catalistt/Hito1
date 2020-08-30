class LikesController < ApplicationController
  def index
    @likes = Likes.all
  end

  def show
  end


  def new
    @like = Like.new
  end

  def edit
  end

  def create
    #pasos para obtener el id de tweets a través de format (hash que "manda")
      tweet = Tweet.find_by(id:params[:format])
      tweet_id = tweet.id
      #obtener el id de user a través del helper de devise
      user_id = current_user.id
      #encontrar el like correspondiente al tweet y al user
      @this_like = Like.find_by(user_id: user_id, tweet_id: tweet_id)
      @tiene_like = @this_like.present?

      #luego de tener al tweet y user asociado, hay que determinar si existe un registro de ese like
      #considerar que el registro sea mayor a 0, sino quedará negativo
      if @tiene_like && tweet.likes_count > 0
        #si tiene like, entonces dislike y destruir
        tweet.likes_count-=1
        @this_like.destroy
      else
        #se crea un like con el usuario y tweet correspondiente
        Like.create(user_id:user_id, tweet_id:tweet_id)
        #se traspasa la info a la tabla tweet
        tweet.likes_count+=1
      end
      #para recargar la página con los nuevos likes/dislikes
      redirect_back(fallback_location: root_path)
      #para guardar en la tabla de tweets
      tweet.save
  end

  def update
    respond_to do |format|
      if @likes.update(likes_params)
        format.html { redirect_to @likes, notice: 'likes was successfully updated.' }
        format.json { render :show, status: :ok, location: @likes }
      else
        format.html { render :edit }
        format.json { render json: @likes.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_likes
      @likes = likes.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def likes_params
      params.require(:likes).permit(:user_id, :tweet_id)
    end
end
