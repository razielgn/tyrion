module Tyrion
  module Storage
    extend ActiveSupport::Concern
    
    included do
      load_stuff self
    end
    
    module ClassMethods
      def storage
        @storage ||= {}
      end
    
      def load_stuff klass
        klass_name = klass.to_s.downcase
        path = klass_filepath klass_name
        
        if File.exists? path
          raw_file = File.read(path)
          storage[klass_name] = MultiJson.decode(raw_file).map{ |doc| klass.create doc }
        else
          storage[klass_name] = []
        end
      end
    
      def save_storage klass_name
        path = klass_filepath klass_name
        
        File.open(path, 'w') do |f|
          f.puts MultiJson.encode(storage[klass_name].map &:attributes)
        end
        
        true
      end
      
      protected
      
      def klass_filepath klass_name
        File.join(Connection.path, klass_name + ".json")
      end
    end
    
    module InstanceMethods
    end
  end
end