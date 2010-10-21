class User < ActiveRecord::Base
  devise :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name, :fb_uid

  has_many :recipes

  validates_uniqueness_of :email, :fb_uid
  validates_presence_of :name

  def display_name
    name.blank? ? email : name
  end

  def apply_omniauth omniauth
    self.email        = omniauth['extra']['user_hash']['email']
    self.name         = omniauth['user_info']['name']
    self.fb_uid       = omniauth['uid']
    self.access_token = omniauth['credentials']['token']
    self.timezone     = omniauth['extra']['user_hash']['timezone']
    self.fb_username  = omniauth['user_info']['nickname']
  end

  def password_required?
    false
  end

end
