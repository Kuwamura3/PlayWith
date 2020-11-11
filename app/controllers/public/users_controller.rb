class Public::UsersController < ApplicationController

	def search
	end

	def game
	end

	def index
		@users = User.page(params[:page]).per(PER)
	end

	def edit
		@user = User.find(params[:id])
		@games = Game.all
	end

	def show
		@user = User.find(params[:id])
		@users_comments = UsersComment.all.order(id: "DESC") #降順
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
