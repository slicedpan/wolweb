require_relative "lib/wolweb/app"
require_relative "lib/wolweb/machine_store"
require "yaml"

config = YAML.load_file("config.yml")
machine_store = WolWeb::MachineStore.new(config["machines"])
WolWeb::App.set :machine_store, machine_store
WolWeb::App.set :interface, config["interface"] || "eth0"
WolWeb::App.set :root, __dir__
machine_store.begin
run WolWeb::App