class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :comment

  referenced_in :user
  embedded_in :commentable, :inverse_of => :comments

  validates_presence_of :user, :commentable, :comment
end
