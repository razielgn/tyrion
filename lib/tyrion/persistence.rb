module Tyrion
  module Persistence
    def self.included(receiver)
      receiver.extend ClassMethods
      receiver.send :include, InstanceMethods
    end

    module ClassMethods
      def create(*args)
        new(*args).tap{ |doc| doc.save }
      end

      def delete_all
        storage[klass_name].clear
      end
    end

    module InstanceMethods
      def initialize(*args)
        super(*args)
        @persisted = false
      end

      def save
        if valid?
          self.class.storage[klass_name] << self
          self.class.save_storage klass_name
          @persisted = true

          true
        else
          false
        end
      end

      def delete
        self.class.storage[klass_name].delete_if{ |doc| self == doc }
        self.class.save_storage(klass_name)
      end

      def persisted?
        @persisted
      end
    end
  end
end