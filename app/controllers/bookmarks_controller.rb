class BookmarksController < ApplicationController
	before_action :authorized?

	def index
		current_user_bookmarks = current_user.bookmarks.search(params[:search], current_user.id)
		@bookmarks = current_user_bookmarks.paginate(:page => params[:page], :per_page => 5)
	end

	def create
		bookmark = current_user.bookmarks.new(bookmark_params)
		url = bookmark_params[:url]

		unless url.length.zero?
			if url_exist?(url)
				bookmark.preview = create_preview(url)
			else
				unless url.start_with?("https://") || url.start_with?("http://")
					bookmark.url.insert(0, "https://")
				end
			end
		end
		
		flash[:error] = "Your post was not saved!" unless bookmark.save
		clean_tempfile

		redirect_to bookmarks_path
	end


	private

	def new_bookmark
		@new_bookmark = current_user.bookmarks.new()
	end

	def bookmark_params
		params.require(:bookmark).permit(:url)
	end

	def parse_img(tempfile, content_type, filename)
		ActionDispatch::Http::UploadedFile.new({
    		tempfile: tempfile,
    		content_type: content_type,
    		filename: filename
		})	
	end

	def url_exist?(url_string)
		url = URI.parse(url_string)
  		req = Net::HTTP.new(url.host, url.port)
		req.use_ssl = (url.scheme == 'https')
		path = url.path if url.path.present?
		res = req.request_head(path || '/')
		res.code != "404"
	
	rescue Exception
		false
	end

	def create_preview(url)
		filename = url.gsub("https://", "").gsub('/', '.')
		f = Screencap::Fetcher.new(url)
		screenshot = f.fetch(:output => 'tmp/images/'+filename+'.png', :width => 1024, :height => 768)
		preview = parse_img(screenshot, '.png' ,filename)
		return preview
	
	rescue Exception
		create_icon(url)
	end

	def create_icon(url)
		object = LinkThumbnailer.generate(url)
		object.favicon = object.url + object.favicon unless object.favicon.to_s.start_with?("https://") || object.favicon.to_s.start_with?("http://")

		image_handle = open(object.favicon)
		filename = object.favicon.to_s.split("/").last.split(".").first
		content_type = object.favicon.to_s.split("/").last.gsub(filename, "")

		@tempfile = Tempfile.new(filename)
		@tempfile.binmode
		@tempfile.write image_handle.base_uri.read
		@tempfile.rewind

		icon = parse_img(@tempfile, content_type, filename)
		return icon
	
	rescue Exception
		nil
	end

	def clean_tempfile
    	if @tempfile
    		@tempfile.close
    		@tempfile.unlink
    	end
	end

	helper_method :new_bookmark
end
