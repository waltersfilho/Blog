class Post < ActiveRecord::Base
	acts_as_votable
	belongs_to :user
	has_many :comments, dependent: :destroy
	validates :title,
		uniqueness: true,
		presence: true
	validates :body,
		length: {minimum: 100, 
			maximum:5000}
	validates :user,
		presence: true
end

