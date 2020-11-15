class Game < ApplicationRecord

	validates :title, presence: true

	has_many :users_games
	has_many :players, through: :users_games, source: :user

end
