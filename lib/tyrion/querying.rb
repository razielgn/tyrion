require 'forwardable'

module Tyrion
  module Querying
    def self.included(receiver)
      receiver.extend ClassMethods
    end

    module ClassMethods
      extend Forwardable

      def_delegators :new_criteria, :all, :where, :first, :last, :limit,
                                    :skip, :asc, :desc

      def count
        storage[klass_name].count
      end

      private

      def new_criteria
        Criteria.new(storage[klass_name], klass_name)
      end
    end
  end
end
