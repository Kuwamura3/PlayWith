class Public::PostsController < ApplicationController

  def create
    @post = Post.new(post_params)
    if @post.save
      # サクセスメッセージ
      redirect_to user_path(params[:user_id])
    else
      # エラーメッセージ
			@user = User.find(params[:user_id])
			@users_games = current_user.playings.order(:game_id)
			@users_comments = UsersComment.where(commented_id: params[:id]).order(id: "DESC") #降順
			render template: "public/users/show"
		end
  end

  private

  def post_params
    params.permit(:user_id, :game_id, :kind)
  end

end
