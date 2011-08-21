module Tyrion
  module Document
    class << self
      def memory
        @memory ||= {}
      end
    
      def load_stuff klass
        klass_name = klass.to_s.downcase
        path = klass_filepath klass_name
        
        if File.exists? path
          raw_file = File.read(path)
          memory[klass_name] = MultiJson.decode(raw_file).map{ |doc| klass.create doc }
        else
          memory[klass_name] = []
        end
      end
    
      def save_memory klass_name
        path = klass_filepath klass_name
        
        File.open(path, 'w') do |f|
          f.puts MultiJson.encode(memory[klass_name].map &:attributes)
        end
        
        true
      end
      
      def klass_filepath klass_name
        File.join(Connection.path, klass_name + ".json")
      end
    end
    
    module ClassMethods      
      def field(name, type = String)
        name = name.to_s
        
        define_method("#{name}"){ attributes[name] }
        define_method("#{name}="){ |value| attributes[name] = value }
      end
      
      def create attributes = {}
        new.tap do |n|
          attributes.each_pair{ |k, v| n.send(:write_attribute, k.to_s, v) }
        end
      end
      
      def create! attributes = {}
        create(attributes).tap{ |doc| doc.save }
      end
      
      def all
        Document.memory[klass_name]
      end
      
      def delete_all
        Document.memory[klass_name].clear
      end
      
      def klass_name
        to_s.downcase
      end
      
      def method_missing(method, *args)
        if method.to_s =~ /^find_by_(.+)$/
          attr = $1
          arg = args.shift || raise("Provide at least one argument!")
          
          all.each do |doc|
            operator = if arg.is_a? String
              :==
            elsif arg.is_a? Regexp
              :=~
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
      attr_reader :attributes
      
      def initialize
        @attributes = {}
      end
      
      def save
        Document.memory[klass_name] << self
        Document.save_memory klass_name
      end
      
      def delete
        Document.memory[klass_name].delete_if{ |doc| self == doc }
        Document.save_memory klass_name
      end
      
      def == other
        other.attributes == attributes
      end
      
      def method_missing(name, *args)
        attr = name.to_s
        return super unless attributes.has_key? attr.gsub("=", "")
        
        if attr =~ /=$/
          write_attribute(attr[0..-2], args.shift || raise("BOOM"))
        else
          read_attribute(attr)
        end
      end
      
      private
      
      def read_attribute(name)
        attributes[name.to_s]
      end
      
      def write_attribute(name, arg)
        attributes[name.to_s] = arg
      end
      
      def klass_name
        self.class.to_s.downcase
      end
      
    end
    
    def self.included(receiver)
      load_stuff receiver
      
      receiver.send :extend,  ClassMethods
      receiver.send :include, InstanceMethods
    end
  end
end
