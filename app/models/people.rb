class People < ActiveRecord::Base
  attr_accessible :name


  has_many :employer, class_name: "people", foreign_key: "meneger_id"
  belongs_to :manager, class_name: "people" 


end
