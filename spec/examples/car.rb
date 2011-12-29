class Car
  include Tyrion::Document

  field :model
  field :plate

  validates :plate, :presence => true, :format => /^\w{2}\d{3}\w{2}$/i
end