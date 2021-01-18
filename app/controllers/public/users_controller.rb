class Public::UsersController < ApplicationController
	before_action :authenticate_user!, only: [:edit]

	def search
	end

	def gamer
		@game = Game.find_by(id: params[:game_id])
		@users = @game.players.where(is_deleted: false).page(params[:page]).per(PER)
	end

	def index
		@users = User.where(is_deleted: false).page(params[:page]).per(PER)
	end

	def edit
		@user = User.find(params[:id])
		@users_games = current_user.playings.order(:game_id)
		#↑ユーザーの遊びたいゲームを、ゲームid順に取得
		@games = Game.all
		unless current_user == @user
			flash[:alert] = "他のユーザー情報は編集できません"
			redirect_to edit_user_path(current_user)
		end
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
			if user_signed_in?
				redirect_to user_path(@user)
			elsif admin_signed_in?
				redirect_to admin_user_path(@user)
			end
		else
			# @users_games = current_user.playings.order(:game_id)
			# @games = Game.all
			# render "edit"
			@users = User.all
			@users_games = @user.playings.order(:game_id)
			@users_comments = UsersComment.where(commented_id: params[:id]).order(id: "DESC") #降順
			@notifications = Notification.where(user_id: @user.id).order(id: "DESC")
			if user_signed_in?
				render template: "public/users/show"
			elsif admin_signed_in?
				render template: "admin/users/show"
			end
		end
	end
	
	private
	
	def user_params
		params.require(:user).permit(:image, :name, :introduction, :voice, :twitter, :discord_name, :discord_number, :is_deleted)
	end

end
