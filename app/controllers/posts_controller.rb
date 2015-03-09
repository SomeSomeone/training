class PostsController < ApplicationController
  before_action :log_into_the_system 
  before_action :set_post, only: [:show, :destroy]
  include SessionsHelper
  def show
    @post = Post.find(params[:id])
    @comments=@post.comments
    @comment=@post.comments.build
  end

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
      params.require(:post).permit(:content, :image)
    end
end
