class Public::UsersGamesController < ApplicationController


# current_user使えばもっと簡単では？？？？？後で修正
	def create
		@users_game = UsersGame.new(users_game_params)
		@users_game_own = UsersGame.where(user_id: current_user.id)
		if @users_game_own.present?
			# ↓選択したゲームが既に登録済みだった場合、重複して保存しない
			@users_game_registered = @users_game_own.find_by(game_id: @users_game.game_id)
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
