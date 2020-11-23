class Game < ApplicationRecord

	validates :title, presence: true, length: { in: 2..30 }

	has_many :users_games
	has_many :notifications
	has_many :players, through: :users_games, source: :user

end
