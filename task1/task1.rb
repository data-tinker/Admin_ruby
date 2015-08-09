#!/usr/bin/env ruby

require 'minitest/autorun'
require './functions'
require 'yaml'

class Learning1Test < Minitest::Test

  def setup
    @servers = YAML::load(File.open('servers.yml'))
  end

  def test_ssd_only
    assert_equal [1], find_ssd_only_ids(@servers)
  end

  def test_find_ids_with_ram_over_100
    assert_equal [2,3], find_ids_with_ram_over_100(@servers)
  end

  def test_find_ssd_volume_per_server
    assert_equal [{1 => 1600}, {2 => 0}, {3 => 800}], find_ssd_volume_per_server(@servers)
  end

  def test_sorted_ids_by_cpu_frequency
    assert_equal [3,1,2], sorted_ids_by_cpu_frequency(@servers)
  end

end
