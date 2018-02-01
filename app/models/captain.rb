class Captain < ActiveRecord::Base
  has_many :boats

  def self.find_by_boat_type(type)
  	Captain.joins(:boats).joins("JOIN boat_classifications ON boats.id = boat_classifications.boat_id").joins("JOIN classifications ON boat_classifications.classification_id = classifications.id").where("classifications.name = ?", type).group(:captain_id)
  end

  def self.catamaran_operators
  	self.find_by_boat_type('Catamaran')
  end

  def self.sailors
  	self.find_by_boat_type('Sailboat')
  end

  def self.talented_seamen
  	Captain.joins(:boats).joins("JOIN boat_classifications ON boats.id = boat_classifications.boat_id").joins("JOIN classifications ON boat_classifications.classification_id = classifications.id").select("captains.name, captains.id").distinct.where("classifications.name = 'Sailboat' or classifications.name = 'Motorboat'").group("classifications.id")
  end

  def self.non_sailors
		where.not("id IN (?)", self.sailors.pluck(:id))
	end

end
