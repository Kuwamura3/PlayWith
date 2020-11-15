class Notification < ApplicationRecord

	belongs_to :user

	enum kind: { フォロー: 0, 投稿: 1, 遊びたい: 2}

end
