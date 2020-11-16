class Public::UsersController < ApplicationController

	def search
	end

	def gamer
		@game = Game.find_by(id: params[:game_id])
		@users = @game.players.page(params[:page]).per(PER)
	end

	def index
		@users = User.page(params[:page]).per(PER)
	end

	def edit
		@user = User.find(params[:id])
		@users_games = current_user.playings.order(:game_id)
		#↑ユーザーの遊びたいゲームを、ゲームid順に取得
		@games = Game.all
	end

	def show
		@users = User.all
		@user = User.find(params[:id])
		@users_games = @user.playings.order(:game_id)
		@users_comments = UsersComment.where(commented_id: params[:id]).order(id: "DESC") #降順
		@notifications = Notification.where(user_id: @user.id).order(id: "DESC")
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			flash[:notice] = "プロフィールを更新しました"
			redirect_to user_path(@user)
		else
			flash.now[:alert] = "プロフィールの更新に失敗しました"
			@user = User.find(params[:id])
			@users_games = current_user.playings.order(:game_id)
			@games = Game.all
			render "edit"
		end
	end
	
	private
	
	def user_params
		params.require(:user).permit(:image, :name, :introduction, :voice, :twitter, :discord_name, :discord_number)
	end

end
