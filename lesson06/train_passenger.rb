require_relative 'train'

class TrainPassenger < Train

  def initialize(number)
    super(number, :passenger)
  end

  def wagon_add(wagon)
    return unless self.type == wagon.type
    super(wagon)
  end

end
