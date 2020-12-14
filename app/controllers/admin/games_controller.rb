class Admin::GamesController < ApplicationController
	before_action :authenticate_admin!, only: [:index, :new]

  def index
    @games = Game.page(params[:page]).per(PER)
  end

  def create
    @game = Game.new(game_params)
    unless Game.find_by(title: @game.title)
      if @game.save
        flash[:notice] = "ゲームを新規登録しました"
        redirect_to games_path
      else
        render :new
      end
    else
      flash.now[:alert] = "そのゲームは登録済です"
      render :new
    end
  end

  def new
  end
  
  private

  def game_params
    params.permit(:title)
  end

end
