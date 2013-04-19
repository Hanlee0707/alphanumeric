module EmployeesHelper
  def generate_temporary_password
    o =  [('a'..'z'),('A'..'Z'),(0..9)].map{|i| i.to_a}.flatten
    password = (0...12).map{ o[rand(o.length)] }.join
  end

  def list_of_positions
    EmployeePositionType.select(:position_type).uniq.map { |x| x.position_type }
  end

  def list_of_levels(position)
    levels = []
    i = 1
    EmployeePositionType.where(:position_type => position).select(:number_of_levels).map { |x|
      x.number_of_levels.times {
        levels.append(i) 
        i = i+1
      }
    }
    levels
  end

end
