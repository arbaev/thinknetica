require_relative 'train'

class TrainPassenger < Train

  def initialize(number)
    super(number, :passenger)
  end

end
