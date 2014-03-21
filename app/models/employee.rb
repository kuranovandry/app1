class Employee < ActiveRecord::Base
  attr_accessible :text, :title

set_table_name 'manager'

belongs_to :user
belongs_to :people

end
