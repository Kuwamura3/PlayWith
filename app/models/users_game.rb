class UsersGame < ApplicationRecord

	validates :user_id, presence: true
	validates :game_id, presence: true

	belongs_to :user
	belongs_to :game

end
