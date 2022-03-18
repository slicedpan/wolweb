require "sinatra/base"
require "json"

module WolWeb
  class App < Sinatra::Application
    JSON_HEADER = {"Content-Type" => "application/json"}

    def json_response(status_code, data)
      [status_code, JSON_HEADER, [JSON.dump(data)]]
    end

    get "/machines" do
      json_response(200, {:machines => settings.machine_store.machines.map(&:serialize)})     
    end

    post "/machines/:id/wakeup" do
      begin
        machine = settings.machine_store.machines[params[:id].to_i]
        if machine.nil?
          json_response(404, {"messages" => ["Machine #{params[:id]} not found!"]})
        else
          `sudo etherwake -i #{settings.interface} #{machine.mac_address}`
          [204, {}, []]
        end
      rescue StandardError => e
        json_response(500, {"messages" => ["#{e}\n#{e.backtrace.join("\n")}"]})
      end
    end

    get "/" do
      erb :index, :locals => {:machine_store => settings.machine_store}
    end
  end
end