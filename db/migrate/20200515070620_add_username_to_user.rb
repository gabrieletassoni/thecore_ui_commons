class AddUsernameToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :username, :string
    add_index :users, :username

    puts "Computing username for existing emails"
    User.reset_column_information
    User.all.each do |u|
      puts "User: #{u.email} into #{u.email.split("@").first}"
      u.username = u.email.split("@").first
      u.save!
    end
  end
end
