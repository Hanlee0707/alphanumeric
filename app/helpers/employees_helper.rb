module EmployeesHelper
  def generate_temporary_password
    o =  [('a'..'z'),('A'..'Z'),(0..9)].map{|i| i.to_a}.flatten
    password = (0...12).map{ o[rand(o.length)] }.join
  end

  def list_of_positions
    EmployeePositionType.select(:position_type).uniq.map { |x| x.position_type }
  end

  def list_of_levels(position)
    EmployeePositionType.where(:position_type => position).select(:number_of_levels).map { |pos| pos.number_of_levels }
  end

end
