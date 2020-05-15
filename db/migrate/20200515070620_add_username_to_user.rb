class AddUsernameToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :username, :string
    add_index :users, :username

    User.all.each do |u|
      u.username = u.email.split("@").first
      u.save!
    end
  end
end
