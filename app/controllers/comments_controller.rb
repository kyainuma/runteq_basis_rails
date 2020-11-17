class CommentsController < ApplicationController
  # before_action :set_comments, only: %i[create destroy]

  def create
    @comment = current_user.comments.build(comment_params)
    @board = Board.find(params[:board_id])
    @comments = @board.comments.order(created_at: :desc)
    @comment.save
    # if @comment.save
    #  redirect_to board_path(@comment.board), success: t('defaults.message.created', item: Comment.model_name.human)
    # else
    #  redirect_to board_path(@comment.board), danger: t('defaults.message.not_created', item: Comment.model_name.human)
    # end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @board = Board.find(@comment.board_id)
    @comments = @board.comments.order(created_at: :desc)
    @comment.destroy!
  end

  def update
    @comment = current_user.comments.find(params[:id])
    @comment.update!(comment_update_params)
    render json: @comment
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(board_id: params[:board_id])
  end

  def comment_update_params
    params.require(:comment).permit(:body)
  end

  def set_comments
    @comments = Board.find(params[:board_id]).comments.order(created_at: :desc)
  end
end
