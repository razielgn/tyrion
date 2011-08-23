module Tyrion
  module Persistence
    extend ActiveSupport::Concern
    
    module ClassMethods
      def create attributes = {}
        new.tap do |n|
          attributes.each_pair{ |k, v| n.send(:write_attribute, k.to_s, v) }
        end
      end
      
      def create! attributes = {}
        create(attributes).tap{ |doc| doc.save }
      end
      
      def delete_all
        storage[klass_name].clear
      end
      
      def delete attributes = {}
        where(attributes).each(&:delete)
      end
    end
    
    module InstanceMethods
      def save
        self.class.storage[klass_name] << self
        self.class.save_storage klass_name
      end
      
      def delete
        self.class.storage[klass_name].delete_if{ |doc| self == doc }
        self.class.save_storage klass_name
      end
    end
  end
end