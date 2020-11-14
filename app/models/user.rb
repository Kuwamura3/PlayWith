class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable, :registerable,
				 :recoverable, :rememberable, :validatable, :authentication_keys => [:name]

	validates :name, presence: true

	has_many :relationships
	has_many :users_comments
	has_many :notifications
	has_many :users_games
	has_many :posts

  attachment :image #画像投稿用

	enum voice: { 未登録: 0, ＯＫ: 1, ＮＧ: 2}

	# emailカラムを使用しない
	def email_required?
		false
	end

	def email_changed?
		false
	end

	def will_save_change_to_email?
		false
	end

end
