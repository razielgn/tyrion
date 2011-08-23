module Tyrion
  module Querying
    extend ActiveSupport::Concern
    
    module ClassMethods
      def all
        storage[klass_name].dup
      end
      
      def where attributes = {}
        all.map do |doc|
          match = attributes.each_pair.map do |k, v|
            operator = if v.is_a? Regexp
              :=~
            else
              :==
            end
            
            true if doc.send(:read_attribute, k.to_s).send(operator, v)
          end.compact
          
          doc if match.count == attributes.count
        end.compact
      end
      
      def method_missing(method, *args)
        if method.to_s =~ /^find_by_(.+)$/
          attr = $1
          arg = args.shift || raise("Provide at least one argument!")
          
          all.each do |doc|
            operator = if arg.is_a? Regexp
              :=~
            else
              :==
            end
            
            return doc if doc.attributes[attr].send(operator, arg)
          end
          
          nil
        else
          super
        end
      end
    end
  
    module InstanceMethods
    end
  end
end