require "forwardable"

module Tacokit
  class Collection
    include Enumerable
    extend Forwardable

    MAX = 1000

    def_delegators :@collection, :[], :empty?, :size

    def initialize(client, method, path, options)
      @client, @method, @path, @options = client, method, path, options

      @page  = options.fetch(:page, 0)
      @limit = options.fetch(:limit, 50)

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
      @last_response_empty || (@page * @limit) >= MAX
    end

    def fetch_next_page
      response = @client.send(@method, @path, @options.merge(page: @page))
      @last_response_empty = response.empty?
      @page += 1
      @collection += response
    end
  end
end
