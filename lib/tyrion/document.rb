module Tyrion
  
  # Base module to persist objects.
  module Document
    def self.included(receiver)
      receiver.extend ClassMethods
      
      receiver.class_eval do
        include Tyrion::Components
        include InstanceMethods
      end
    end
    
    module ClassMethods
      protected
      
      def klass_name
        to_s.downcase
      end
    end
    
    module InstanceMethods
      
      # Checks for equality.
      # @example Compare two objects
      #   object == other
      # @param [Object] The other object to compare with
      # @return [true, false] True if objects' attributes are the same, false otherwise.
      def == other
        other.attributes == attributes
      end
      
      def initialize(attrs = {})
        @attributes = attrs.stringify_keys
        @new_document = true
      end
      
      private
      
      def klass_name
        self.class.to_s.downcase
      end
    end
  end
end
