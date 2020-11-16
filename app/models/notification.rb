class Notification < ApplicationRecord

	belongs_to :user
	belongs_to :sender, class_name: "User"
	belongs_to :game

	enum kind: { フォロー: 0, 新規投稿: 1, 希望投稿: 2}

end
