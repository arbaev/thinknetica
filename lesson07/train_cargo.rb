require_relative 'train'

class TrainCargo < Train
  def initialize(number)
    super(number, :cargo)
  end

  def wagon_add(wagon)
    return unless self.type == wagon.type

    super(wagon)
  end

end
