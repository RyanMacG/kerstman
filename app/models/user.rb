class User < ActiveRecord::Base
  has_many :groups, dependent: :destroy
  before_save { email.downcase }
  before_create :create_remember_token
  validates_presence_of :name
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates_format_of :email, with: VALID_EMAIL_REGEX, message: 'Must be a valid email address'
  validates_uniqueness_of :email, case_sensitive: false, message: 'Sorry this email is already taken'
  validates :password, length: { minimum: 6 }
  validates_confirmation_of :password,
  if: lambda { |m| m.password.present? }

  has_secure_password

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private
  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end
