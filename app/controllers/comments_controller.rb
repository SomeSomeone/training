class CommentsController < ApplicationController
	before_action :log_into_the_system 
  	
  	def create

    @comment = Comment.new(comment_params)
     
    @post= Post.find(params[:post_id])

    @comment.user=current_user
    @comment.post=@post

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post, notice: 'Comment was successfully created.' }
      else
        format.html { redirect_to @post, alert: "Comment wasn't successfully created." }
      end
    end

  end

  def destroy
  	@comment=Comment.find(params[:id])
  	@post=@comment.post
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @post, notice: 'Post was successfully destroyed.' }
    end
  end

  private 
  def comment_params
  	params.require(:comment).permit(:message)
  end

end
