module Tyrion
  module Components
    extend ActiveSupport::Concern
    
    include Tyrion::Storage
    include Tyrion::Attributes
    include Tyrion::Persistence
    include Tyrion::Querying
  end
end