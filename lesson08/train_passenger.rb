require_relative 'train'
# methods for Train type :passenger
class TrainPassenger < Train
  def initialize(number)
    super(number, :passenger)
  end

  def wagon_add(wagon)
    return unless @type == wagon.type

    super(wagon)
  end
end
