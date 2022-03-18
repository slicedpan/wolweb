require_relative "machine"
require_relative "machine_updater"

module WolWeb
  class MachineStore
    attr_reader :machines

    def initialize(machine_info)
      @machines = machine_info.map.with_index do |info, id|
        Machine.new(info.transform_keys{ |k| k.to_sym }.merge({:id => id})) 
      end
    end

    def begin
      Thread.new do
        loop do
          begin
            @machines.each do |machine|
              MachineUpdater.call(machine)
            end
          rescue StandardError => e
            puts "Error updating machines: #{e}\n#{e.backtrace.join("\n")}"
          end
          sleep(15)
        end
      end
    end
  end
end