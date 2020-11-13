class Public::RelationshipsController < ApplicationController

	def index
	end

	def create
		path = Rails.application.routes.recognize_path(request.referer)
		# ↑遷移元を参照
		@user = User.find(params[:follow_id])
		following = current_user.follow(@user)
		if following.save
			flash[:success] = "ユーザーをフォローしました"
			if path[:action] == "show"
				redirect_to user_path(@user)
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
			else
				redirect_to users_path
			end
		else
			flash.now[:alert] = "ユーザーのフォロー解除に失敗しました"
			redirect_to user_path(@user)
		end
	end

end
