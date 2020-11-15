class BookmarksController < ApplicationController
  def create
    bookmark = current_user.bookmarks.build(board_id: params[:board_id])
    bookmark.save!
    flash[:success] = t('.success')
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.bookmarks.find_by(board_id: params[:board_id]).destroy!
    flash[:success] = t('.success')
    redirect_back(fallback_location: root_path)
  end
end
