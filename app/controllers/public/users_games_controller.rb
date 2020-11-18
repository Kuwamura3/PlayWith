class Public::UsersGamesController < ApplicationController

	def create
		path = Rails.application.routes.recognize_path(request.referer)

		# 編集画面からの場合、selectからのデータを受け取る
		if path[:action] == "edit"
			if params[:game_id].present?
				@users_game = current_user.users_games.find_or_initialize_by(game_id: params[:game_id])
				if @users_game.new_record?
					@users_game.save
					flash[:notice] = "遊びたいゲームを登録しました"
					redirect_to edit_user_path(current_user)
				else
					flash.now[:alert] = "そのゲームは登録済みです"
					@user = current_user
					@users_games = current_user.playings.order(:game_id)
					@games = Game.all
					render template: "public/users/edit"
				end
			else
				flash.now[:alert] = "ゲームを選択してください"
				@user = current_user
				@users_games = current_user.playings.order(:game_id)
				@games = Game.all
				render template: "public/users/edit"
			end

		# 一覧画面からの場合、eachで取得できるgame_idを受け取る
		else
			@users_game = current_user.users_games.new(game_id: params[:game_id])
			if @users_game.save
				flash.now[:notice] = "遊びたいゲームを登録しました"
				@game = Game.find(params[:game_id])
				@users_games = current_user.users_games
				# redirect_to games_path
			end
		end
	end

	def destroy
		path = Rails.application.routes.recognize_path(request.referer)

		@users_game = current_user.users_games.find_by(game_id: params[:id])
		if @users_game.destroy
			if path[:action] == "edit"
				flash[:notice] = "遊びたいゲームの登録を解除しました"
				redirect_to edit_user_path(current_user)
			else
				flash.now[:notice] = "遊びたいゲームの登録を解除しました"
				@game = Game.find(params[:id])
				@users_games = current_user.users_games
				# redirect_to games_path
			end
		end
	end

end
