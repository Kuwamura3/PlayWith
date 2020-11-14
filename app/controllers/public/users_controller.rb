class Public::UsersController < ApplicationController

	def search
	end

	def gamer
	end

	def index
		@users = User.page(params[:page]).per(PER)
		@users_games = UsersGame.all
	end

	def edit
		@user = User.find(params[:id])
		@users_games = UsersGame.where(user_id: current_user.id).order(:game_id)
		#↑ユーザーの遊びたいゲームを、ゲームid順に取得
		@games = Game.all
	end

	def show
		@user = User.find(params[:id])
		@users_games = UsersGame.where(user_id: params[:id]).order(:game_id)
		#↑ユーザーの遊びたいゲームを、ゲームid順に取得
		@users_comments = UsersComment.where(commented_id: params[:id]).order(id: "DESC") #降順
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			# サクセスメッセージ
			redirect_to user_path(@user)
		else
			# エラーメッセージ
			render "edit"
		end
	end
	
	private
	
	def user_params
		params.require(:user).permit(:image, :name, :introduction, :voice, :twitter, :discord_name, :discord_number)
	end

end
