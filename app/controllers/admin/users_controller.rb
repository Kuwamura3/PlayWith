class Admin::UsersController < ApplicationController
	before_action :authenticate_admin!, only: [:index, :edit, :show]

	def index
		@users = User.page(params[:page]).per(PER)
	end

	def edit
	end

	def show
		@user = User.find(params[:id])
		@users_games = @user.playings.order(:game_id)
		@users_comments = UsersComment.where(commented_id: params[:id]).order(id: "DESC") #降順
	end

	def update
	end
end
