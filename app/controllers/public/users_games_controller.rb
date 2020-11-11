class Public::UsersGamesController < ApplicationController

  def create
    @users_game = UsersGame.new(users_game_params)
    if @users_game.save
			# サクセスメッセージ
			redirect_to edit_user_path(current_user)
		else
			# エラーメッセージ
		# 	render "edit"
		end
  end

  def destroy
  end
	
	private
	
	def users_game_params
		params.permit(:user_id, :game_id)
	end

end
