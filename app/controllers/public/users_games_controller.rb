class Public::UsersGamesController < ApplicationController

	def create
		path = Rails.application.routes.recognize_path(request.referer)

		# 編集画面からの場合、selectからのデータを受け取る
		if path[:action] == "edit"
			@users_game = UsersGame.new(users_game_params)

			# ↓ゲーム登録があるか
			if current_user.users_games.present?
				# ↓ゲーム登録がある場合、今回登録するゲームが登録済みでないか
				@users_game_registered = current_user.users_games.find_by(game_id: @users_game.game_id)
				if !@users_game_registered.present?
					if @users_game.save
						# サクセスメッセージ
						redirect_to edit_user_path(current_user)
					else
						# エラーメッセージ(選択してください)
						@user = current_user
						@users_games = current_user.playings.order(:game_id)
						@games = Game.all
						render template: "public/users/edit"
					end
				else
					# エラーメッセージ(登録済み)
					@user = current_user
					@users_games = current_user.playings.order(:game_id)
					@games = Game.all
					render template: "public/users/edit"
				end
			else
				if @users_game.save
					# サクセスメッセージ
					redirect_to edit_user_path(current_user)
				else
					# エラーメッセージ(選択してください)
					@user = current_user
					@users_games = current_user.playings.order(:game_id)
					@games = Game.all
					render template: "public/users/edit"
				end
			end

		# 一覧画面からの場合、idを受け取る
		else
			@users_game = UsersGame.new
			@users_game.game_id = params[:game_id]
			@users_game.user_id = current_user.id
			if @users_game.save
				# サクセスメッセージ
				redirect_to games_path
			end
		end
	end

	def destroy
		path = Rails.application.routes.recognize_path(request.referer)

		# 編集画面からの場合idを受け取るので、一意に定まる
		if path[:action] == "edit"
			@users_game = UsersGame.find_by(game_id: params[:id])
			if @users_game.destroy
				# サクセスメッセージ
				redirect_to edit_user_path(current_user)
			end

		# 一覧画面からの場合game_idを受け取るので、current_userのものを削除する
		else
			@users_game = current_user.users_games.find_by(game_id: params[:id])
			if @users_game.destroy
				# サクセスメッセージ
				redirect_to games_path
			end
		end
	end
	
	private
	
	def users_game_params
		params.permit(:user_id, :game_id)
	end

end
