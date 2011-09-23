module Tyrion
  module Persistence
    def self.included(receiver)
      receiver.extend ClassMethods
      receiver.send :include, InstanceMethods
    end
    
    module ClassMethods
      def create attributes = {}
        new(attributes).tap do |n|
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
        if valid?
          self.class.storage[klass_name] << self
          self.class.save_storage klass_name
          @new_document = false
          
          true
        else
          false
        end
      end
      
      def delete
        self.class.storage[klass_name].delete_if{ |doc| self == doc }
        self.class.save_storage klass_name
      end
      
      def new_document?
        @new_document
      end
    end
  end
end