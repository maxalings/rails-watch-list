class BookmarksController < ApplicationController
  before_action :set_list, only: [:new, :create] # Ensure @list is set for these actions

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = @list.bookmarks.build(bookmark_params) # Use @list set by set_list

    if @bookmark.save
      redirect_to list_path(@list), notice: 'Bookmark was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@bookmark.list), notice: 'Bookmark was successfully deleted.'
  end

  private

  def set_list
    @list = List.find(params[:list_id]) # Fetch the list using the nested list_id
  end

  def bookmark_params
    params.require(:bookmark).permit(:movie_id, :comment) # Strong parameters for bookmark
  end
end
