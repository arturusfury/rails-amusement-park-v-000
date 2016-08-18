class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :attraction

  def take_ride
    if check_height && check_tickets
      start_ride
    elsif !check_height && check_tickets
      'Sorry. ' + ticket_issue
    elsif check_height && !check_tickets
      'Sorry. ' + height_issue
    else
      'Sorry. ' + ticket_issue + ' ' + height_issue
    end
  end

  def start_ride
    user.update(
      happiness: user.happiness + attraction.happiness_rating,
      nausea: user.nausea + attraction.nausea_rating,
      tickets: user.tickets - attraction.tickets
    )
    "Thanks for riding the #{attraction.name}!"
  end

  def check_height
    user.tickets < attraction.tickets ? false : true
  end

  def check_tickets
    user.height < attraction.min_height ? false : true
  end

  def ticket_issue
    "You do not have enough tickets the #{attraction.name}."
  end

  def height_issue
    "You are not tall enough to ride the #{attraction.name}."
  end
end
