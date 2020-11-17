class CommentsController < ApplicationController
  # before_action :set_comments, only: %i[create destroy]

  def create
    @comment = current_user.comments.build(comment_params)
    # @board = Board.find(params[:board_id])
    # @comments = @board.comments.order(created_at: :desc)
    @comment.save
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    # @board = Board.find(@comment.board_id)
    # @comments = @board.comments.order(created_at: :desc)
    @comment.destroy!
  end

  def update
    @comment = current_user.comments.find(params[:id])
    if @comment.update(comment_update_params)
      render json: { comment: @comment }, status: :ok
    else
      render json: { comment: @comment, errors: { messages: @comment.errors.full_messages } }, status: :bad_request
    end
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
