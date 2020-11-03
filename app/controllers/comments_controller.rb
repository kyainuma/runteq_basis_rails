class CommentsController < ApplicationController
  def index
    @comments = Comment.all.includes(:board).order(created_at: :desc)
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.board_id = params[:board_id]
    @board = Board.find(params[:board_id])
    @comments = @board.comments.includes(:user).order(created_at: :desc)
    if @comment.save
      redirect_to board_path(@board.id), success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render 'boards/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
