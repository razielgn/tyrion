class Car
  include Tyrion::Document
  
  field :model
  field :plate
  
  validates :plate, :presence => true
end