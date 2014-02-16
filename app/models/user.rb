class User < ActiveRecord::Base

  attr_accessor :password
  attr_accessible :email, :password, :password_confirmation, :first_namer, :last_name
  before_save :encrypt_password
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  validates :first_namer, presence: true, length: { minimum: 4 }
  validates :last_name, presence: true, length: { minimum: 4 } 
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i                
  validates :password, presence: true, length: { minimum: 4 }   


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

   def full_name
    "#{first_namer} #{last_name}"
  end

def self.search(search)
  if search
    where('name LIKE ?', "%#{search}%")
  else
    scoped
  end
end
  
end