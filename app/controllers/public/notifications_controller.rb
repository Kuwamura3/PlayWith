class Public::NotificationsController < ApplicationController

	def destroy_all
		@notifications = current_user.notifications
		if @notifications.destroy_all
			flash[:notice] = "全ての通知を削除しました"
			redirect_to user_path(current_user)
		end
	end

	def create
		@notification = Notification.new(notification_params)
		@notification.user_id = current_user.id
		if @notification.save
			flash[:notice] = "フォロワーへの投稿を作成しました"
			@followers = current_user.followers
			@followers.each do |follower|
				@notification = Notification.new(notification_params)
				@notification.user_id = follower.id
				@notification.save
			end
			redirect_to user_path(params[:sender_id])
		else
			flash.now[:alert] = "投稿に失敗しました"
			@user = User.find(params[:sender_id])
			@users_games = current_user.playings.order(:game_id)
			@users_comments = UsersComment.where(commented_id: params[:id]).order(id: "DESC") #降順
			render template: "public/users/show"
		end
	end

	def destroy
		@notification = Notification.find(params[:id])
		if @notification.destroy
			flash[:notice] = "通知を削除しました"
			redirect_to user_path(current_user)
		end
	end

	private

	def notification_params
		params.permit(:sender_id, :game_id, :kind)
	end

end
