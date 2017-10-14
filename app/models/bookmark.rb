class Bookmark < ApplicationRecord
	mount_uploader :preview, PreviewUploader
	
	belongs_to :user

	validates :url, presence: true

	def self.search(search, user_id)
	  if search.blank?
	  	bookmarks = Bookmark.where(user_id: user_id)
	  else
	    bookmarks = Bookmark.where(url: search, user_id: user_id)
	  end
	end

end
