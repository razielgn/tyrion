module Tyrion
  module Validations
    def self.included(receiver)
      receiver.class_eval do
        include ActiveModel::Validations
        include ActiveModel::Conversion
      end
    end
  end
end