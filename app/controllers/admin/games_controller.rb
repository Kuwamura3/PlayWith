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
		unless params[:game_id] == params[:game_id_remain]
			@game_remain = Game.find(params[:game_id_remain])
			@game = Game.find(params[:game_id])

			@game.players.each do |user|
				@users_game = user.users_games.find_or_initialize_by(game_id: params[:game_id_remain])
				if @users_game.new_record?
					@users_game.save
				end
			end

			@users = User.all
			@users.each do |user|
				@notification = Notification.new
				@notification.user_id = user.id
				@notification.sender_id = user.id
				@notification.kind = "統合"
				@notification.game_id = @game_remain.id
				@notification.game_deleted = @game.title
				@notification.save
			end

			@game.destroy

			flash[:notice] = "「#{@game.title}」を「#{@game_remain.title}」に統合しました"
			redirect_to admin_games_path
		else
			flash.now[:alert] = "異なる２種のゲームを選択してください"
			@games = Game.page(params[:page]).per(PER)
			render :index
		end
	end
	
	private

	def game_params
		params.permit(:title)
	end

end
