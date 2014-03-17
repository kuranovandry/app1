class Comment < ActiveRecord::Base
  attr_accessible :user_id, :body, :commentable_id, :commentable_type
  belongs_to :user
  belongs_to :commentable, polymorphic: true
end
