class Public::UsersGamesController < ApplicationController

	def create
		@users_game = UsersGame.new(users_game_params)
		# ↓選択したゲームが既に登録済みだった場合、重複して保存しない
		@users_game_registered = UsersGame.find_by(game_id: @users_game.game_id)
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
	end

	def destroy
	end
	
	private
	
	def users_game_params
		params.permit(:user_id, :game_id)
	end

end
