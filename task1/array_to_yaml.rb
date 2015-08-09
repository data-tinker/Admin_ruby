#!/usr/bin/env ruby

require 'yaml'
require 'pp'

servers = [
  {
    :id => 1,
    :model => 'R530',
    :cpu => [{:cores => 8, :frequency => 2.5}],
    :ram => [16, 16, 16, 16],
    :storage => [{:type => :ssd, :size => 400}, {:type => :ssd, :size => 400}, {:type => :ssd, :size => 400}, {:type => :ssd, :size => 400}]
  },
  {
    :id => 2,
    :model => 'R530',
    :cpu => [{:cores => 8, :frequency => 2.8}],
    :ram => [16, 16, 16, 16, 16, 16, 16, 16],
    :storage => [{:type => :sas, :size => 600}, {:type => :sas, :size => 600}]
  },
  {
    :id => 3,
    :model => 'R530',
    :cpu => [{:cores => 8, :frequency => 2.3}],
    :ram => [16, 16, 16, 16, 16, 16, 16, 16],
    :storage => [{:type => :sas, :size => 600}, {:type => :sas, :size => 600}, {:type => :ssd, :size => 400}, {:type => :ssd, :size => 400}]
  }
]
File.open('./servers.yml', 'w') {|file| file.write(servers.to_yaml)}
