class BoardsController < ApplicationController
  def top; end

  def index
    @boards = Board.all
  end
end
