class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
  	joins(boats: :classifications).where(classifications:{name:'Catamaran'})
  end

  def self.sailors
  	joins(boats: :classifications).where(classifications:{name:'Sailboat'}).group(:captain_id)
  end

  def self.talented_seafarers
  	sail = self.sailors
  	motor = joins(boats: :classifications).where(classifications:{name:'Motorboat'}).group(:captain_id)
  	where('id in (?)', sail & motor)
  end

  def self.non_sailors
  	where.not('id in (?)', self.sailors.pluck(:id))
  end

  

end
