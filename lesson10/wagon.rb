require_relative 'manufacturer'
require_relative 'validation'
# common Wagon methods
class Wagon
  include Manufacturer
  include Validation

  attr_reader :type
  validate :type, :presence
  validate :type, :include, Train::TRAIN_TYPES

  def initialize(type)
    @type = type
    validate!
  end
end
