class LikesController < ApplicationController
  def index
    @likes = Likes.all
  end

  def show
  end


  def new
    @likes = Likes.new
  end

  def edit
  end

  def create
    @likes = Likes.new(likes_params)

    respond_to do |format|
      if @likes.save
        format.html { redirect_to @likes, notice: 'likes was successfully created.' }
        format.json { render :show, status: :created, location: @likes }
      else
        format.html { render :new }
        format.json { render json: @likes.errors, status: :unprocessable_entity }
      end
    end
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

  def destroy
    @likes.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_likes
      @likes = likes.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def likes_params
      params.require(:likes).permit(:user, :likes)
    end
end
