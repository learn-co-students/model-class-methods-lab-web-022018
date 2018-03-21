def caps(boat_name)
  boats = Boat.all.select{|b| b.classifications.select{|c| boat_name.include?(c.name)} != []}
  captains = boats.map{|b| b.captain.name if b.captain}
end

class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    Captain.where(:name => caps("Catamaran"))
  end

  def self.sailors
    Captain.where(:name => caps("Sailboat"))
  end

  def self.talented_seafarers
    cap_m = caps("Motorboat")
    cap_s = caps("Sailboat")
    cap_ms = cap_m.select{|c| cap_s.include?(c)}
    Captain.where(:name => cap_ms)
  end

  def self.non_sailors
    boats = Boat.all.select{|b| b.classifications.select{|c| c.name == "Sailboat"} == []}
    captains = boats.map{|b| b.captain.name if b.captain}
    captains = captains.reject{|c| caps("Sailboat").include?(c)}
    Captain.where(:name => captains)
  end
end
