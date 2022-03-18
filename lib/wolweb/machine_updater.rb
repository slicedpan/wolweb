module WolWeb
  class MachineUpdater
    def self.call(machine)
      machine.service_statuses[:network] = system("ping -c 1 -W 0.25 #{machine.ip_address}")
      machine.service_statuses[:steam] = system("timeout 0.25 nc -z #{machine.ip_address} 27036")
    end
  end
end