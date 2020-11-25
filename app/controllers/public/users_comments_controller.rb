class Public::UsersCommentsController < ApplicationController

	def create
		@users_comments = UsersComment.where(commented_id: params[:commented_id]).order(id: "DESC") #降順
		@user = User.find(params[:commented_id])
		# ↑非同期で更新した後のための定義
		@users_comment = current_user.users_comments.new(comment_params)
		if @users_comment.save
			flash.now[:notice] = "コメントを投稿しました"
			# redirect_to user_path(params[:id])
		else
			# flash.now[:alert] = "コメントの内容を入力して下さい"
			# @users = User.all
			# @users_games = current_user.playings.order(:game_id)
			# @notifications = Notification.where(user_id: @user.id).order(id: "DESC")
			# @user = User.find(params[:id])
			# @users_comments = UsersComment.where(commented_id: params[:id]).order(id: "DESC") #降順
			# render template: "public/users/show"
		end
	end

	private
	
	def comment_params
		params.permit(:text, :commented_id)
	end

end
