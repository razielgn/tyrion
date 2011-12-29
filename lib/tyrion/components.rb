module Tyrion
  module Components
    def self.included(receiver)
      receiver.class_eval do
        include Tyrion::Attributes
        include Tyrion::Querying
        include Tyrion::Validations
        include Tyrion::Storage
        include Tyrion::Persistence
      end
    end
  end
end