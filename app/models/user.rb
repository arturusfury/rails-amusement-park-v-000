class User < ActiveRecord::Base
  has_secure_password

  has_many :rides
  has_many :attractions, through: :rides

  def mood
    if self.happiness && self.nausea
      nausea >= happiness ? 'sad' : 'happy'
    end
  end

  def num_of_rides
    attractions.count
  end
end
