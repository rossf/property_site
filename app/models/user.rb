class User
  include Dynamoid::Document
  
  table :name => :users, :key => :email, :read_capacity => 400, :write_capacity => 400

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable
      #:omniauthable, :omniauth_providers => [:facebook, :gplus, :pinterest, :yahoo, :weibo]

  field :email
  field :name
  field :provider
  field :uid
  field :encrypted_password
  field :default_language
  field :authentication_token
  field :sign_in_count, :integer
  field :current_sign_in_at, :datetime
  field :last_sign_in_at, :datetime
  field :current_sign_in_ip
  field :last_sign_in_ip
  
  validates :email, presence: true
  validates :encrypted_password, presence: true
  
  def self.find_for_facebook_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      unless user.persisted?
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name   # assuming the user model has a name
        user.image = auth.info.image # assuming the user model has an image
        user.save!
      end
    end
  end
  
  def self.find_for_gplus_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      unless user.persisted?
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name   # assuming the user model has a name
        user.image = auth.info.image # assuming the user model has an image
        user.save!
      end
    end
  end
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
  
  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end
 
  private
  
  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end

end