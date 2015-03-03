class PostsController < ApplicationController
  before_action :log_into_the_system 
  before_action :set_post, only: [:show, :destroy]

  # GET /posts
  # GET /posts.json

  # GET /posts/1
  # GET /posts/1.json

  # GET /posts/new

  # GET /posts/1/edit

  # POST /posts
  # POST /posts.json
  def create
    @user=current_user
    @post = @user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @user, notice: 'Post was successfully created.' }
      else
        format.html { redirect_to @user, alert: "Post wasn't successfully created." }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @user=@post.user
    @post.destroy
    respond_to do |format|
      format.html { redirect_to @user, notice: 'Post was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:content, :user_id, :image)
    end
end
