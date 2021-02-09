class User < ActiveRecord::Base
  has_secure_password

  before_save { email.downcase! }

  validates :name, presence: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :email,  presence: true, uniqueness: { case_sensitive: false }



  def self.authenticate_with_credentials(email, password)
    email = email.strip.downcase
    @user= User.find_by_email(email)
    if @user && @user.authenticate(password)
      @user
    else
      nil
    end
  end

end
