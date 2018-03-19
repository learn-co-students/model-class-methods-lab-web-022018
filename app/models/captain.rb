class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.operators_of_boat_type("Catamaran")
  end

  def self.sailors
    self.operators_of_boat_type("Sailboat")
  end

  def self.talented_seafarers
    Captain.where(id:
      Boat.all_by_class("Motorboat").pluck(:captain_id).compact
    ).where(id:
      Boat.all_by_class("Sailboat").pluck(:captain_id).compact
    )
  end

  def self.non_sailors
    Captain.where.not(id: self.sailors)
  end

  def self.operators_of_boat_type(type_name)
    Captain.where(id:
      Boat.all_by_class(type_name)
      .pluck(:captain_id)
    )
  end
end
