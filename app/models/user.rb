class User < ApplicationRecord
  has_many :campaigns_as_gm, class_name: 'Campaign', foreign_key: 'gm_id'
  has_many :characters, foreign_key: 'player_id'
  has_many :campaigns_as_player, through: :characters, source: :campaign

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  has_secure_password

  def self.find_or_create_by_oauth(auth)
    self.find_or_create_by(uid: auth[:uid], provider: auth[:provider]) do |u|
        u.username = auth["info"]["first_name"]
        u.email = auth["info"]["email"]
        u.password = SecureRandom.hex(16)
    end
  end

  def campaigns
    self.campaigns_as_gm + self.campaigns_as_player
  end

end
