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
        redirect_to admin_games_path
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

  def edit
    @games = Game.all
  end

  def integration
    if params[:game_id] == params[:game_id_remain]
      flash.now[:alert] = "異なる２種のゲームを選択してください。"
      @games = Game.page(params[:page]).per(PER)
      render :index
    end
  end
  
  private

  def game_params
    params.permit(:title)
  end

end
