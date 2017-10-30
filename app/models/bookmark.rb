class Bookmark < ApplicationRecord
	mount_uploader :preview, PreviewUploader
	
	belongs_to :user

	validates :url, presence: true, :uniqueness => {:scope => :user_id}

	def self.search(search, user_id)
	  if search.blank?
	  	bookmarks = Bookmark.where(user_id: user_id).sort
	  else
	    bookmarks = Bookmark.select{|bookmark| bookmark.url.split("//").last.include?(search) && bookmark.user_id == user_id }
	  end
	end

	def check_url_and_add_preview(unvalid_url)
		url = unvalid_url.remove(/[ ]*/).sub(/[\/]+$/, '')
		self.url = url

		if url.length != 0
			unless (url.start_with?("https://") || url.start_with?("http://"))
				self.url.insert(0, "https://")
			end
		end

		self.preview = CreateScreenshot.new(url).create_screen
	end

end
