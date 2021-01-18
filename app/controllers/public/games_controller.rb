class Public::GamesController < ApplicationController
	before_action :authenticate_user!, only: [:new]

  def top
    @games = Game.joins(:users_games).group(:id).order("count(users_games.user_id)DESC").limit(5)
    #遊んでいる人数が多いゲームTOP5を選出
    @users_count = User.all.count
    @games_count = Game.all.count
  end

  def about
  end

  def search
    @word = params[:search_content]
    if params[:search_content]
      if params[:search_model] == "1" #検索欄でGamesを選択
        if user_signed_in?
          @users_games = current_user.users_games
        end
        @contents = Game.where("title LIKE ?", "%#{params[:search_content]}%").page(params[:page]).per(PER)
        # render :search
      elsif params[:search_model] == "2" #検索欄でUsersを選択
        @contents = User.where(is_deleted: false).where("name LIKE ?", "%#{params[:search_content]}%").page(params[:page]).per(PER)
        render template: "public/users/search"
      end
    end
  end

  def index
    @games = Game.page(params[:page]).per(PER)
    if user_signed_in?
      @users_games = current_user.users_games
    end
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
