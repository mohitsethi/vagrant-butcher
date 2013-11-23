module Vagrant
  module Butcher
    class Command < Vagrant.plugin("2", "command")
      include Vagrant::Butcher::Action

      def execute
        with_target_vms([], :reverse => true) do |machine|
          machine.action(:cleanup)
        end
        return 0
      end
    end
  end
end
