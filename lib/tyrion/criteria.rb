module Tyrion
  class Criteria
    include Enumerable

    attr_reader :klass

    def initialize(storage, klass)
      @storage = storage
      @klass = klass
      @constraints = []
    end

    def all
      self
    end

    def where(params = {})
      @constraints << [:where, params]
      self
    end

    def limit(n)
      @constraints << [:limit, n]
      self
    end

    def skip(n)
      @constraints << [:skip, n]
      self
    end

    def asc(*keys)
      @constraints << [:sort, [keys, true]]
      self
    end

    def desc(*keys)
      @constraints << [:sort, [keys, false]]
      self
    end

    def inspect
      "<Criteria:0x#{__id__.to_s(16)}\n" +
      " Model:#{@klass.capitalize},\n" +
      " Constraints: " + @constraints.inspect[1..-2] + ">"
    end

    def each(&block)
      fetch_documents if not @data
      @data.each{ |c| block.call(c) }
    end

    def last
      to_a.last
    end

    private

    def fetch_documents
      @data = @storage.dup

      @constraints.each do |con|
        type, args = con

        case type
        when :where
          @data = @data.select do |doc|
            args.each_pair.map do |k, v|
              doc.read_attribute(k) == v
            end.inject(&:&)
          end
        when :limit
          @data = @data.take(args)
        when :skip
          @data = Array(@data[args..-1])
        when :sort
          keys, dir = args
          if @data.respond_to? :sort_by!
            @data.sort_by! do |doc|
              keys.map{|s| doc.read_attribute(s) }
            end
          else
            @data.sort! do |a, b|
              first = keys.map{|s| a.read_attribute(s) }
              second = keys.map{|s| b.read_attribute(s) }
              first <=> second
            end
          end
          @data.reverse! unless dir
        end
      end
    end
  end
end
