class Public::UsersGamesController < ApplicationController

	def create
		@users_game = UsersGame.new(users_game_params)
		if current_user.users_games.present?
			@users_game_registered = current_user.users_games.find_by(game_id: @users_game.game_id)
			if !@users_game_registered.present?
				if @users_game.save
					# サクセスメッセージ
					redirect_to edit_user_path(current_user)
				else
					# エラーメッセージ(選択してください)
					#	render "edit"
				end
			else
				# エラーメッセージ(登録済み)
				#	render "edit"
			end
		else

			if @users_game.save
				# サクセスメッセージ
				redirect_to edit_user_path(current_user)
			else
				# エラーメッセージ(選択してください)
				#	render "edit"
			end

		end
	end

	def destroy
	end
	
	private
	
	def users_game_params
		params.permit(:user_id, :game_id)
	end

end
