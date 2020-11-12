class Public::GamesController < ApplicationController

  def top
    @games = Game.joins(:users_games).group(:id).order("count(users_games.user_id)DESC").limit(5)
    #遊んでいる人数が多いゲームTOP5を選出
  end

  def about
  end

  def search
  end

  def index
    @games = Game.page(params[:page]).per(PER)
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      #notice: "ゲームを新規登録しました"
      redirect_to games_path
    else
      #alert: "ゲームのタイトルを入力して下さい"
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
