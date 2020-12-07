class Admin::UsersController < ApplicationController
	before_action :authenticate_admin!, only: [:index, :edit, :show]

  def index
		@users = User.page(params[:page]).per(PER)
  end

  def edit
  end

  def show
  end

  def update
  end
end
