class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    Boat.limit(5)
  end

  def self.dinghy
    Boat.where("length < '20'")
  end

  def self.ship
    Boat.where("length >= 20")
  end

  def self.last_three_alphabetically
    Boat.order("name DESC").limit(3)
  end

  def self.without_a_captain
    Boat.where('captain_id IS NULL')
  end

  def self.sailboats
    self.all_by_class("Sailboat")
  end

  def self.all_by_class(classification_name)
    Boat.where(id:
      BoatClassification.where(classification:
        Classification.find_by(name: classification_name)).pluck(:boat_id))
  end

  def self.with_three_classifications
    Boat.joins(:boat_classifications).group(:boat_id).having('count(boat_id) = 3')
  end

  def self.longest
    Boat.order("length DESC").limit(1)
  end



end
