module Tyrion
  module Attributes
    def self.included(receiver)
      receiver.extend ClassMethods
      receiver.send :include, InstanceMethods
    end

    module ClassMethods
      def field(name, type = String)
        name = name.to_s

        define_method("#{name}"){ attributes[name] }
        define_method("#{name}="){ |value| attributes[name] = value }
      end
    end

    module InstanceMethods
      attr_reader :attributes

      def initialize(attrs = {})
        @attributes = attrs.stringify_keys
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

      # Checks for equality.
      # @example Compare two objects
      #   object == other
      # @param [Object] The other object to compare with
      # @return [true, false] True if objects' attributes are the same, false otherwise.
      def == other
        return false unless other.is_a?(Tyrion::Document)
        other.attributes == attributes
      end

      def read_attribute(name)
        attributes[name.to_s]
      end

      def write_attribute(name, arg)
        attributes[name.to_s] = arg
      end
    end
  end
end
