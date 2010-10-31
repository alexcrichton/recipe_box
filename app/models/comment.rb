class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true, :counter_cache => true
  belongs_to :user

  validates_presence_of :user, :commentable, :comment
end
