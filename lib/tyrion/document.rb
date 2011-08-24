module Tyrion
  
  # Base module to persist objects.
  module Document
    extend ActiveSupport::Concern
    include Tyrion::Components
    
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
      
      private
      
      def klass_name
        self.class.to_s.downcase
      end
    end
  end
end
