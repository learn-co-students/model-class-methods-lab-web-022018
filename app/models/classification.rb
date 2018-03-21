class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    Classification.all
  end

  def self.longest
    l = 0
    longest_boat = nil
    Boat.all.each do |b|
      if b.length > l
        longest_boat = b
        l = b.length
      end
    end
    Classification.joins(:boats).where("boats.name = '#{longest_boat.name}'")
  end
end
