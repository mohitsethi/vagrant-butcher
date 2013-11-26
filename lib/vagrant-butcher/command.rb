module Vagrant
  module Butcher
    class Command < Vagrant.plugin("2", "command")

      def initialize
        
      end

      def self.synopsis
        "Delete node and client from Chef server."
      end

      def execute
        require 'pry-debugger';binding.pry
        return 0
      end
    end
  end
end
