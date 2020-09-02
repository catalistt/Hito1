class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]

  def index

    @tweet = Tweet.new
    @followings = current_user.followings.ids
    @tweets = Tweet.tweets_for_me(@followings).order('created_at desc').page params[:page]
    
    #@tweets = Tweet.order('created_at desc').page params[:page]
  end

  def show
    @tweet = Tweet.find(params[:id])
    @user_c = current_user.id
    @likes = @tweet.likes
     

  end


  def new
    @tweet = Tweet.new
  end

  def edit
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    
    respond_to do |format|
      if @tweet.save
        format.html { redirect_to root_path, notice: 'Tweet was successfully created.' }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tweet_update = Tweet.find(params[:id])
    if @tweet_update.present?
      @tweet_update.destroy
    end
    redirect_to root_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:content, :likes_count, :retweets_count, :user, :image_url, likes_attributes: [:user_id, :tweet_id])
    end
end
