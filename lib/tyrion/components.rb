module Tyrion
  module Components
    def self.included(receiver)
      receiver.class_eval do
        include Tyrion::Attributes
        include Tyrion::Validations
        include Tyrion::Persistence
        include Tyrion::Querying
        include Tyrion::Storage
      end
    end
  end
end