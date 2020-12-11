class Admin::GamesController < ApplicationController
	before_action :authenticate_admin!, only: [:index, :new]

  def index
    @games = Game.page(params[:page]).per(PER)
  end

  def create
  end

  def new
  end
end
