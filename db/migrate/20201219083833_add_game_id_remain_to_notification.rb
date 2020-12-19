class AddGameIdRemainToNotification < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :game_id_remain, :integer
  end
end
