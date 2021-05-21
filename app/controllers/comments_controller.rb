class CommentsController < ApplicationController
  def create
    @comment = Comment.new(params_comment)
    if @comment.save
      redirect_to prototype_path(@comment.prototype)
    else
      @prototype = @comment.prototype
      @comments =@prototype.comments
      render "prototypes/show"
    end
  end

  private

  def params_comment
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
