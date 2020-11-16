class Public::GamesController < ApplicationController

  def top
    @games = Game.joins(:users_games).group(:id).order("count(users_games.user_id)DESC").limit(5)
    #遊んでいる人数が多いゲームTOP5を選出
  end

  def about
  end

  def search
    @word = params[:search_content]
    if params[:search_content]
      if params[:search_model] == "1"
        if user_signed_in?
          @users_games = current_user.users_games
        end
        @contents = Game.where("title LIKE ?", "%#{params[:search_content]}%").page(params[:page]).per(PER)
        # render :search
      elsif params[:search_model] == "2"
        @contents = User.where("name LIKE ?", "%#{params[:search_content]}%").page(params[:page]).per(PER)
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
