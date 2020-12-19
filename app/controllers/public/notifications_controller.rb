class Public::NotificationsController < ApplicationController

	def destroy_all
		@notifications = current_user.notifications
		if @notifications.destroy_all
			flash.now[:notice] = "全ての通知を削除しました"
			# redirect_to user_path(current_user)
		end
	end

	def create
		@notification = current_user.notifications.new(notification_params)
		if @notification.save
			flash.now[:notice] = "フォロワーへの投稿を作成しました"
			@followers = current_user.followers
			@followers.each do |follower|
				notification = follower.notifications.new(notification_params)
				notification.save
			end
			@user = current_user
			@users = User.all
			@users_games = @user.playings.order(:game_id)
			@notifications = Notification.where(user_id: @user.id).order(id: "DESC")
			# redirect_to user_path(params[:sender_id])
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
			flash.now[:notice] = "通知を削除しました"
			@users = User.all
			@user = current_user
			@notifications = Notification.where(user_id: @user.id).order(id: "DESC")
			# redirect_to user_path(current_user)
		end
	end

	private

	def notification_params
		params.permit(:sender_id, :game_id, :game_id_remain, :kind)
	end

end
