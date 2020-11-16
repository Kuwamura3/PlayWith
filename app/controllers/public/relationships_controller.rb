class Public::RelationshipsController < ApplicationController

	def index
		@followings = current_user.followings
		@followers = current_user.followers
	end

	def create
		path = Rails.application.routes.recognize_path(request.referer)
		# ↑遷移元を参照
		@user = User.find(params[:follow_id])
		following = current_user.follow(@user)
		if following.save
			flash[:success] = "ユーザーをフォローしました"
			# 通知の作成
			@notification = Notification.new
			@notification.user_id = params[:follow_id]
			@notification.sender_id = current_user.id
			@notification.game_id = "1"
			@notification.kind = "フォロー"
			@notification.save
			# @user.create_notification_by(current_user)

			if path[:action] == "show"
				redirect_to user_path(@user)
			elsif path[:controller] == "public/relationships" #フォロー一覧からの場合
				redirect_to relationships_path
			else
				redirect_to users_path
			end
		else
			flash.now[:alert] = "ユーザーのフォローに失敗しました"
			redirect_to user_path(@user)
		end
	end

	def destroy
		path = Rails.application.routes.recognize_path(request.referer)
		# ↑遷移元を参照
		@user = User.find(params[:follow_id])
		following = current_user.unfollow(@user)
		if following.destroy
			flash[:success] = "ユーザーをフォローを解除しました"
			if path[:action] == "show"
				redirect_to user_path(@user)
			elsif path[:controller] == "public/relationships" #フォロー一覧からの場合
				redirect_to relationships_path
			else
				redirect_to users_path
			end
		else
			flash.now[:alert] = "ユーザーのフォロー解除に失敗しました"
			redirect_to user_path(@user)
		end
	end

end
