class SessionsController < ApplicationController
	before_action :find_or_create_user, only: :create
	before_action :find_user_friends, only: :create

	def new
		
	end

	def create
		session[:user_id] = @user.id
		redirect_to bookmarks_path
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_path
	end


	private

	def auth_params
		request.env['omniauth.auth']
	end

	def find_or_create_user
		@user = User.find_or_create_by(uid: auth_params[:uid], email: auth_params[:info][:email])
	end

	def find_user_friends
		graph = Koala::Facebook::API.new(auth_params[:credentials][:token])
		user_friends = graph.get_connection("me", "friends")

		user_friends.each do |friend|
			user_friend = User.find_by(uid: friend["id"])
			@user.friendships.find_or_create_by(friend_id: user_friend.id)
		end
	end

end
