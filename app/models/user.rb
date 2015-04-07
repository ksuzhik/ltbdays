class User < ActiveRecord::Base
  has_many :payments
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :birthdate, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }, on: :create
  
  mount_uploader :avatar, AvatarUploader 
  self.per_page = 10
  
  default_scope{order('first_name, last_name desc')}
  scope :find_by_birth_month, ->(month){where('MONTH(birthdate) = ?', month) if month.present?}
  scope :search, ->(search){where('first_name like ? or last_name like ?', "#{search}", "#{search}") if search.present? && search.length > 0}

  
  def send_password_reset
    self.password_resets_token = User.new_token
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver_now
  end
  
  
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_token)
    end
end
