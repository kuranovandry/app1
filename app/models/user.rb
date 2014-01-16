class User < ActiveRecord::Base
attr_accessor :password
attr_reader :password_has

before_save :encrypt_password
attr_accessible :email, :first_name, :last_name, :password, :password_confirmation

validates :first_name, presence: true, length: { minimum: 4 }
validates :last_name, presence: true, length: { minimum: 4 } 
validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i 
validates :email, uniqueness: true                 
validates :password, presence: true, length: { minimum: 4 }   
validates_confirmation_of :password
validates_presence_of :password, :on => :create
  
def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

end
