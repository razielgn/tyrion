module Tyrion
  module Document
    extend ActiveSupport::Concern
    include Tyrion::Components
    
    module ClassMethods      
      def klass_name
        to_s.downcase
      end
    end
    
    module InstanceMethods      
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
