class BookmarksController < ApplicationController
	before_action :authorized?
	before_action :current_bookmark, only: :destroy

	require 'will_paginate/array'
	require 'create_screenshot_controller.rb'

	def index
		current_user_bookmarks = current_user.bookmarks.search(params[:search], current_user.id)
		@bookmarks = current_user_bookmarks.paginate(:page => current_page(params[:page]), :per_page => per_page)
	end

	def create
		bookmark = current_user.bookmarks.new(bookmark_params)
		bookmark.check_url_and_add_preview(bookmark_params[:url])

		flash[:error] = bookmark.errors.full_messages.join(". ") unless bookmark.save

		redirect_to bookmarks_path
	end

	def destroy
		if @current_bookmark
			@current_bookmark.delete
		else
			flash[:error] = "Can't find this bookmark!"
		end
		redirect_to bookmarks_path
	end


	private

	def current_bookmark
		@current_bookmark = current_user.bookmarks.find(params[:id])
	end

	def new_bookmark
		@new_bookmark = current_user.bookmarks.new()
	end

	def bookmark_params
		params.require(:bookmark).permit(:url)
	end


	helper_method :new_bookmark
end
