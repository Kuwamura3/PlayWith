class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable, :registerable,
				 :recoverable, :rememberable, :validatable

	has_many :relationships
	has_many :users_comments
	has_many :notifications
	has_many :users_games
	has_many :posts

end
