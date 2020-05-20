class AddUsernameToUser < ActiveRecord::Migration[6.0]
  class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :trackable, :validatable
    # TODO: If it works, these must be added to another gem one which deal 
    # more with sessions
    # devise :database_authenticatable
    # devise :rememberable
    # devise :trackable
    # devise :validatable
    # devise :timeoutable, timeout_in: 30.minutes 
    # REFERENCES
    has_many :role_users, dependent: :destroy, inverse_of: :user
    has_many :roles, through: :role_users, inverse_of: :users
    # VALIDATIONS
    validates :email, uniqueness: { case_sensitive: false }, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
    validates :password, presence: true, on: :create
    validates :password_confirmation, presence: true, on: :create
    validate :check_password_and_confirmation_equal
    validates_each :admin do |record, attr, value|
      # Don't want admin == false if the current user is the only admin
      record.errors.add(attr, I18n.t("validation.errors.cannot_unadmin_last_admin")) if record.admin_changed? && record.admin_was == true && User.where(admin: true).count == 1
    end
  
    def display_name
      email
    end
  
    def has_role? role
      roles.include? role
    end
  
    protected
  
    def check_password_and_confirmation_equal
      errors.add(:password, I18n.t("validation.errors.password_and_confirm_must_be_the_same")) unless password == password_confirmation
    end
  end
  
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
