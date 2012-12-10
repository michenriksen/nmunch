module Nmunch

  # Public: A class to represent a network node
  #
  # For now it is a simple wrapper around IP and MAC address information but might
  # contain more information in the future.
  class Node
    attr_reader :ip_address, :mac_address

    # Public: Initialize a new node
    #
    # options - A hash that must contain the keys :ip_address and :mac_address
    #
    # Returns nothing
    def initialize(options)
      @ip_address  = options[:ip_address]
      @mac_address = options[:mac_address]
    end

    # Public: Determine if node has a meta address
    #
    # A node will have a meta address (0.0.0.0) if it has not yet been given a
    # DHCP lease
    #
    # Returns TRUE if meta address and FALSE if not
    def meta_address?
      ip_address == '0.0.0.0'
    end

    # Public: Convert node to string
    #
    # Returns IP address
    def to_s
      ip_address
    end

    # Public: Compare string version of node
    #
    # Returns TRUE if same and FALSE if not
    def ==(obj)
      self.to_s == obj.to_s
    end

    # Public: Convenience method to create a node from an Nmunch::Dissector instance
    #
    # dissector - An instance of Nmunch::Dissector
    #
    # Returns instance of Nmunch::Node with details from dissector
    def self.create_from_dissector(dissector)
      self.new(ip_address: dissector.ip_address, mac_address: dissector.mac_address)
    end
  end
end