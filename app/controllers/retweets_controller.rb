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
    @retweet = Retweet.new(tweet_params)

    respond_to do |format|
      if @retweet.save
        format.html { redirect_to @retweet, notice: 'retweet was successfully created.' }
        format.json { render :show, status: :created, location: @retweet }
      else
        format.html { render :new }
        format.json { render json: @retweet.errors, status: :unprocessable_entity }
      end
    end
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
