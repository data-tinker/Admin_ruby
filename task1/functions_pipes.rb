#!/usr/bin/env ruby

require 'yaml'
require 'pry'
servers = YAML::load(File.open('servers.yml'))


def find_ssd_only_ids(servers)
  servers.select{|server| server[:storage].select{|storage| storage[:type] != :ssd}.empty?}.map{|server| server[:id]}
end


def find_ids_with_ram_over_100(servers)
  servers.select{|server| server[:ram].reduce(&:+) > 100}.map{|server| server[:id]}
end


def find_ssd_volume_per_server(servers)
  servers.map do |server|
    {server[:id] => server[:storage].select{|storage| storage[:type] == :ssd}.reduce(0){|acc, storage| acc + storage[:size]}}
  end
end


def sorted_ids_by_cpu_frequency(servers)
  servers.sort_by {|server| server[:cpu][0][:frequency]}.map{|server| server[:id]}
end

print "#{find_ssd_only_ids(servers)}\n"
