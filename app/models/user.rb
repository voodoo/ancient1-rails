class User < ApplicationRecord
  has_many :links, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  #validates :username, uniqueness: true, allow_nil: true
  
  def voted_for?(link)
    votes.exists?(link_id: link.id)
  end

  def generate_login_token
    self.login_token = SecureRandom.urlsafe_base64(32)
    self.login_token_valid_until = 30.minutes.from_now
    save!
  end

  def valid_login_token?(token)
    login_token == token && login_token_valid_until > Time.current
  end

  def clear_login_token
    update(login_token: nil, login_token_valid_until: nil)
  end
end