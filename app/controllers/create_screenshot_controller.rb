class CreateScreenshot < ApplicationController

	def initialize(url)
		@url = url
	end

	def create_screen
		filename = @url.gsub("https://", "").gsub('/', '.')
		screenshot = Webshot::Screenshot.instance
		file_with_screen = screenshot.capture @url, "tmp/images/"+ filename +".png", width: 1024, height: 800
		return file_with_screen
	end

end