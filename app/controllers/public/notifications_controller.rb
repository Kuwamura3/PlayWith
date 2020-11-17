class Public::NotificationsController < ApplicationController

	def destroy_all
		@notifications = current_user.notifications
		if @notifications.destroy_all
			# redirect_to user_path(current_user)
		end
	end

	def create
		@notification = Notification.new(notification_params)
		@notification.user_id = current_user.id
		if @notification.save
			# サクセスメッセージ
			@followers = current_user.followers
			@followers.each do |follower|
				@notification = Notification.new(notification_params)
				@notification.user_id = follower.id
				@notification.save
			end
			@user = current_user
			@users_games = @user.playings.order(:game_id)
			@notifications = Notification.where(user_id: @user.id).order(id: "DESC")
			# redirect_to user_path(params[:sender_id])
		else
			# エラーメッセージ
			@user = User.find(params[:sender_id])
			@users_games = current_user.playings.order(:game_id)
			@users_comments = UsersComment.where(commented_id: params[:id]).order(id: "DESC") #降順
			render template: "public/users/show"
		end
	end

	def destroy
		@notification = Notification.find(params[:id])
		if @notification.destroy
			#サクセスメッセージ
			@users = User.all
			@user = current_user
			@notifications = Notification.where(user_id: @user.id).order(id: "DESC")
			# redirect_to user_path(current_user)
		end
	end

	private

	def notification_params
		params.permit(:sender_id, :game_id, :kind)
	end

end
