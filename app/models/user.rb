class User < ActiveRecord::Base
  devise :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name, :fb_uid

  has_many :recipes

  validates_uniqueness_of :email, :fb_uid
  validates_presence_of :name

  def friends
    @friends ||= begin
      ids = if current_user
        Rails.cache.fetch(current_user.fb_uid + '_fb_friends') do
          MiniFB.get(current_user.access_token, current_user.fb_uid,
            :type => 'friends').data
        end
      else
        []
      end

      User.where :fb_uid => ids.map(&:id)
    end
  end

  def to_param
    fb_username.blank? ? fb_uid : fb_username
  end

  def first_name
    name.split(' ').first
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
