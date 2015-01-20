class User < ActiveRecord::Base
  has_many :tasks

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true

  scope :with_github_state, ->(state_param) { where(github_state: state_param).where.not(github_state: nil) }

  def self.from_omniauth(auth)
    where("email = ? OR provider = ? AND uid = ? ", auth.info.email, auth.provider, auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
    end
  end

  def generate_github_state!
    self.update_attributes(github_state: self.generate_github_state)
    self.github_state
  end

  def generate_github_state
    SecureRandom.hex
  end

  def authorized_for_github!(authorized_token)
    self.update_attributes(github_access_token: authorized_token, github_state: 'completed')
  end
  
  def is_github_authorized?
    self[:github_access_token] && self[:github_state] == 'completed'
  end
end
