class Item < ActiveRecord::Base
  attr_accessible :name, :price

  has_many :comments, as: :commentable
end
