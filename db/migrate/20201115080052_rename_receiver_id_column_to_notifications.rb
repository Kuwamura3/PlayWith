class RenameReceiverIdColumnToNotifications < ActiveRecord::Migration[5.2]

  def change
    rename_column :notifications, :receiver_id, :user_id
  end

end
