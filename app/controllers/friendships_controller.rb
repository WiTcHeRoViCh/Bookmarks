class FriendshipsController < ApplicationController
	before_action :authorized?
	before_action :current_friend, only: :show

	def index
		@friends = current_user.friends
	end

	def show
		current_friend_bookmarks = @current_friend.bookmarks.search(params[:search], @current_friend.id)
		@bookmarks = current_friend_bookmarks.paginate(:page => current_page(params[:page]), :per_page => per_page)
	end

	private

	def current_friend
		@current_friend = User.find(params[:id])
	end

end
