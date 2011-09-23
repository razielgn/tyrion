module Tyrion
  module Storage    
    def self.included(receiver)
      receiver.extend ClassMethods
      
      receiver.reload unless receiver == Tyrion::Components
    end
    
    module ClassMethods
      def storage
        @storage ||= {}
      end
    
      def reload
        klass_name = to_s.downcase
        path = klass_filepath klass_name
        
        if File.exists?(path)
          raw_file = File.read(path)
          storage[klass_name] = MultiJson.decode(raw_file).map{ |doc| create doc }
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
  end
end