class ChangeDatatypeIntroductionOfUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :introduction, :string, default: "よろしくお願いします"
  end
end
