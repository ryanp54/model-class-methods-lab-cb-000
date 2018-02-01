class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
  	Classification.all
  end

  def self.longest
  	maximum = includes(:boats).maximum(:length)
  	includes(:boats).where(boats: { length: maximum })
  end

end
