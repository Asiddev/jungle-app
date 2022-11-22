class User < ApplicationRecord
  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password_confirmation, presence: true
  validates_length_of :password, :minimum => 5


  def self.authenticate_with_credentials(email, password)
    return nil if email == nil
    #check if email is valid before downcase then strip --> error
    @user = User.find_by_email(email.downcase.strip)
    @user && @user.authenticate(password) ? @user : nil
  end
end


