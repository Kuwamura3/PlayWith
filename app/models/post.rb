class Post < ApplicationRecord

	belongs_to :user

	enum kind: { 新規: 0, 遊びたい: 1}

end
