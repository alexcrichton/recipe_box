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

  def apply_omniauth(omniauth)
    if email.blank?
      self.email = omniauth['user_info']['email']

      if omniauth['extra'] && omniauth['extra']['user_hash']
        self.email ||= omniauth['extra']['user_hash']['email']
      end
    end

    if name.blank?
      self.name = omniauth['user_info']['name']
    end

    if fb_uid.blank?
      self.fb_uid = omniauth['uid']
    end
  end

  def password_required?
    false
  end

end
