#!/usr/bin/env ruby

require 'yaml'
servers = YAML::load(File.open('servers.yml'))


def find_ssd_only_ids(servers)
  result = []
  servers.each do |server|
    @only_ssd = true
    server[:storage].each do |server_storage|
      if server_storage[:type] != "ssd".to_sym
        @only_ssd = false
      end
    end
    if @only_ssd == true
      result.push(server[:id])
    end
  end
  return result
end


def find_ids_with_ram_over_100(servers)
  result = []
  servers.each do |server|
    ram_sum = 0
    server[:ram].each do |server_ram|
      #print server_ram
      ram_sum += server_ram
    end
    if ram_sum > 100
      result.push(server[:id])
    end
  end
  return result
end


def find_ssd_volume_per_server(servers)
  result = []
  result_hash = {}
  servers.each do |server|
    ssd_sum = 0
    server[:storage].each do |server_storage|
      if server_storage[:type] == "ssd".to_sym
        ssd_sum += server_storage[:size]
      end
    end
    result_hash = {server[:id] => ssd_sum}
    result.push(result_hash)
  end
  return result
end


def sorted_ids_by_cpu_frequency(servers)
  result = []
  array = []
  hash = {}
  servers.each do |server|
    server[:cpu].each do |server_cpu|
       hash[server_cpu[:frequency]] = server[:id]
    end
  end
  array = hash.sort
  array.each do |array|
    result.push(array[1])
  end
  return result
end


print "#{sorted_ids_by_cpu_frequency(servers)}\n"
