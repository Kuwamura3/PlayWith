class Public::UsersController < ApplicationController

	def search
	end

	def game
	end

	def index
		@users = User.page(params[:page]).per(PER)
	end

	def edit
	end

	def show
		@user = User.find(params[:id])
		@users_comments = UsersComment.all.order(id: "DESC") #降順
	end

	def update
	end

end
