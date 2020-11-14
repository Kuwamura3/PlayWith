class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|

      t.integer :receiver_id
      t.integer :sender_id
      t.integer :type

      t.timestamps
    end
  end
end
