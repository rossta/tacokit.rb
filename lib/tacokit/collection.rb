require "forwardable"

module Tacokit
  class Collection
    include Enumerable
    extend Forwardable

    MAX = 1000

    def_delegators :@collection, :[], :empty?, :size

    def initialize(client, method, path, options)
      @client  = client
      @method  = method
      @path    = path
      @options = options

      @before = options.fetch(:before, nil)
      @limit  = options.fetch(:limit, 50)
      @max    = options.fetch(:max, MAX)

      @collection = []

      fetch_next_page
    end

    def each(start = 0)
      return to_enum(:each, start) unless block_given?
      Array(@collection[start..-1]).each do |element|
        yield(element)
      end
      unless last?
        start = [@collection.size, start].max
        fetch_next_page
        each(start, &Proc.new)
      end
      self
    end

    private

    def last?
      @last_response_empty || @collection.length >= @max
    end

    def fetch_next_page
      response = @client.send(@method, @path, @options.merge(before: @before, limit: @limit))
      @last_response_empty = response.empty?
      @collection += response
      @before = response.last["id"] unless @last_response_empty
    end
  end
end
