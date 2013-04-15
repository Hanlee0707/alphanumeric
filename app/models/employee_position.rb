class EmployeePosition < ActiveRecord::Base
  attr_accessible :employee_id, :level, :position
  belongs_to :employee
  has_many :employee_position_types
end
