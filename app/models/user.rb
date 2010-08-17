class User < ActiveRecord::Base
  validates_presence_of :fb_uid, :email
  validates_uniqueness_of :fb_uid
end
