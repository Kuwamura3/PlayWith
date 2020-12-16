class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable, :registerable,
				 :recoverable, :rememberable, :validatable, :authentication_keys => [:name]

	validates :name, presence: true, length: { in: 2..20 }
	validates :introduction, length: { maximum: 100 }
	validates :twitter, length: { in:  2..75 }, allow_blank: true
	validates :discord_name, length: { in: 2..32 }, allow_blank: true
	validates :discord_number, length: { is: 4 }, numericality: { only_integer: true }, allow_blank: true

	has_many :relationships
	has_many :followings, through: :relationships, source: :follow
	has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "follow_id"
	has_many :followers, through: :reverse_of_relationships, source: :user

	has_many :users_comments
	has_many :notifications
	has_many :users_games
	has_many :playings, through: :users_games, source: :game
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

	# フォロー関連
	def follow(other_user)
		unless self == other_user
			self.relationships.find_or_create_by(follow_id: other_user.id)
		end
	end

	def unfollow(other_user)
		relationship = self.relationships.find_by(follow_id: other_user.id)
		relationship.destroy if relationship
	end

	def following?(other_user)
		self.followings.include?(other_user)
	end

	# BANチェック
	def active_for_authentication?
		super && (self.is_deleted == false)
	end

end
