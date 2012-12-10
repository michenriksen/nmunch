module Nmunch

  # Public: Nmunch report class
  #
  # Keeps track of discovered nodes and publishes nodes to registered subscribers
  class Report
    attr_reader :options

    # Public: Initialize a new report
    #
    # options - Hash of command line options
    def initialize(options)
      @options          = options
      @subscribers      = []
      @discovered_nodes = []
    end

    # Public: Register a new subscriber
    #
    # subscriber - An object that responds to #process(node)
    #
    # All subscribers will be notified of new nodes and it is up to each subscriber
    # to do something meaningful with the node.
    #
    # Returns nothing
    def register_subscriber(subscriber)
      @subscribers << subscriber
    end

    # Public: Publish a new node to all registered subscribers
    #
    # node - An instance of Nmunch::Node
    #
    # Already discovered nodes or nodes with meta addresses (e.g. DHCP requests)
    # will be ignored.
    #
    # Returns nothing
    def publish_node(node)
      if !node.meta_address? && !@discovered_nodes.include?(node)
        @subscribers.each { |s| s.process(node) }
        @discovered_nodes << node
      end
    end

    # Public: Get a summary
    #
    # Returns a simple summary telling how many live nodes were discovered
    # TODO: Make the summary more detailed
    def summary
      " Discovered #{@discovered_nodes.count} live node(s)"
    end
  end
end