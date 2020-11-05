class BoardsController < ApplicationController
  def top; end

  def show
    @board = Board.find(params[:id])
    @comment = Comment.new
    @comments = @board.comments.includes(:user).order(created_at: :desc)
  end

  def index
    @boards = Board.all.includes(:user).order(created_at: :desc)
  end

  def new
    @board = Board.new
    @comment = Comment.new
    @title = "掲示板作成"
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to boards_path, success: t('defaults.message.created', item: Board.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_created', item: Board.model_name.human)
      render :new
    end
  end

  def edit
    @board = Board.find(params[:id])
    @title = "掲示板編集"
    render 'new'
  end

  def update
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to edit_board_path(@board), success: t('defaults.message.updated', item: Board.model_name.human)
    else    
      flash.now[:danger] = t('defaults.message.not_updated', item: Board.model_name.human)
      render :new
    end
  end
  
  private

  def board_params
    params.require(:board).permit(:title, :body, :board_image, :board_image_cache)
  end
end
