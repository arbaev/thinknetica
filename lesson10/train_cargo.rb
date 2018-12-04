require_relative 'train'
# methods for Train type :cargo
class TrainCargo < Train
  validate :number, :presence
  validate :number, :format, TRAIN_NUMBER_FORMAT
  validate :type, :include, TRAIN_TYPES

  def initialize(number)
    super(number, :cargo)
  end

  def wagon_add(wagon)
    return unless @type == wagon.type

    super(wagon)
  end
end
