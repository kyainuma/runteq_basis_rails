class BoardsController < ApplicationController
  def top; end

  def index
    @boards = Board.all.includes(:user)
  end
end
