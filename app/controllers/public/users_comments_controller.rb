class Public::UsersCommentsController < ApplicationController

	def create
		@users_comment = UsersComment.new(comment_params)
		@users_comment.user_id = current_user.id
		@users_comment.commented_id = params[:id]
		if @users_comment.save
			#notice: "コメントを投稿しました"
			redirect_to user_path(params[:id])
		else
			#alert: "コメントの内容を入力して下さい"
			@user = User.find(params[:id])
			@users_games = current_user.playings.order(:game_id)
			@users_comments = UsersComment.where(commented_id: params[:id]).order(id: "DESC") #降順
			render template: "public/users/show"
		end
	end

	private
	
	def comment_params
		params.permit(:text)
	end

end
