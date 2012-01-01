module Tyrion

  # Base module to persist objects.
  module Document
    def self.included(receiver)
      receiver.extend ClassMethods

      receiver.class_eval do
        include Tyrion::Attributes
        include Tyrion::Querying
        include Tyrion::Validations
        include Tyrion::Storage
        include Tyrion::Persistence
        include InstanceMethods
      end
    end

    module ClassMethods
      private

      def klass_name
        to_s.downcase
      end
    end

    module InstanceMethods
      private

      def klass_name
        self.class.to_s.downcase
      end
    end
  end
end
