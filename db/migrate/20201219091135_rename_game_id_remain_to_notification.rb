class RenameGameIdRemainToNotification < ActiveRecord::Migration[5.2]

  def change
    rename_column :notifications, :game_id_remain, :game_deleted
    change_column :notifications, :game_deleted, :string
  end

end
