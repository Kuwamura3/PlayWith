class Relationship < ApplicationRecord

	belongs_to :user
	belongs_to :follow, class_name: "User"

	validates :user_id, presence: true
	validates :follow_id, presence: true

	# def create_notification_by(current_user)
	# 	notification = notification.new(
	# 		user_id: params[:follow_id],
	# 		sender_id: current_user.id,
	# 		kind: "フォロー"
	# 	)
		
	# 	notification.save if notification.valid?
	# end

end
