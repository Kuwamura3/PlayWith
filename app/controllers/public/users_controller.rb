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
  end

  def update
  end

end
