class Game < ApplicationRecord

	validates :title, presence: true

	has_many :users_games

end
