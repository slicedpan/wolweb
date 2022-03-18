module WolWeb
  class Machine
    attr_reader :service_statuses, :name, :ip_address, :mac_address    

    def initialize(id:, name:, ip_address:, mac_address:)
      @id = id
      @name = name
      @ip_address = ip_address
      @mac_address = mac_address
      @service_statuses = {:steam => false, :network => false}
    end

    def serialize
      {
        :id => @id,
        :name => @name,
        :ip_address => @ip_address,
        :mac_address => @mac_address,
        :service_statuses => @service_statuses
      }
    end
  end
end