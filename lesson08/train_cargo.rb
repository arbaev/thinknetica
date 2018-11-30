require_relative 'train'
# methods for Train type :cargo
class TrainCargo < Train
  def initialize(number)
    super(number, :cargo)
  end

  def wagon_add(wagon)
    return unless @type == wagon.type

    super(wagon)
  end
end
