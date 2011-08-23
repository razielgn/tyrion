module Tyrion
  module Components
    extend ActiveSupport::Concern
    
    include Tyrion::Attributes
    include Tyrion::Persistence
    include Tyrion::Querying
    include Tyrion::Storage
  end
end