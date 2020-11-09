class CreateUsersComments < ActiveRecord::Migration[5.2]
  def change
    create_table :users_comments do |t|

      t.integer :user_id
      t.integer :commented_id
      t.text :text

      t.timestamps
    end
  end
end
