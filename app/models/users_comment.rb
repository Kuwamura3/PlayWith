class UsersComment < ApplicationRecord

	validates :text, presence: true, length: { in: 2..100 }

	belongs_to :user

end
