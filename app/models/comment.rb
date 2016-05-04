class Comment < ActiveRecord::Base
	acts_as_votable
	belongs_to :user
	belongs_to :post
	validates :message, presence: true
	validates :user,
		presence: true
	validates :post,
		presence: true
end
