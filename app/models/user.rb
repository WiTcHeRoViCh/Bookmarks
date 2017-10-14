class User < ApplicationRecord
	has_many :bookmarks, dependent: :delete_all
	has_many :friendships
	has_many :friends, through: :friendships, foreign_key: 'friend_id'
end
