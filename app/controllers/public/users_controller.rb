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
  end

  def update
  end

end
