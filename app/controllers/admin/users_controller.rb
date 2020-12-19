class Admin::UsersController < ApplicationController
	before_action :authenticate_admin!, only: [:index, :edit, :show]

	def index
		@users = User.page(params[:page]).per(PER)
	end

	def edit
		@user = User.find(params[:id])
		@users_games = @user.playings.order(:game_id)
		#↑ユーザーの遊びたいゲームを、ゲームid順に取得
		@games = Game.all
	end

	def show
		@user = User.find(params[:id])
		@users_games = @user.playings.order(:game_id)
		@users_comments = UsersComment.where(commented_id: params[:id]).order(id: "DESC") #降順
	end

	def update
		# @user = User.find(params[:id])
		# if @user.update(user_params)
		# 	flash[:notice] = "プロフィールを更新しました"
		# 	redirect_to admin_user_path(@user)
		# else
		# 	@users = User.all
		# 	@users_games = @user.playings.order(:game_id)
		# 	@users_comments = UsersComment.where(commented_id: params[:id]).order(id: "DESC") #降順
		# 	render "admin/show"
		# end
	end
end
