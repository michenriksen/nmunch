module Nmunch
  module Subscribers

    # Public: Node subscriber to output node details to STDOUT
    #
    # This subscriber is default and will always be registered
    class Stdout < Nmunch::Subscribers::Base

      # Public: Process a new node
      #
      # node - An instance of Nmunch::Node
      #
      # Prints node information to STDOUT
      #
      # Returns nothing
      def process(node)
        output =  " #{node.ip_address}\t\t#{node.mac_address}"
        output << "\t#{Nmunch::MacOuiLookup.instance.lookup(node.mac_address)}" unless options.include?("no-prefix-lookup")
        puts Paint[output, :green]
      end
    end
  end
end