#!/usr/bin/env ruby

class CPU
  attr_accessor :num, :mhz, :cores, :num2

  def initialize(num, mhz, cores, num2)
    @num = num
    @mhz = mhz
    @cores = cores
    @num2 = num2
    if num2 == 4
      raise "unsupported cpu generation"
    end
  end

  def == (other)
    mhz == other.mhz && cores == other.cores && num2 == other.num2
  end

  def != (other)
    not (self == other)
  end

  def print
    puts num, mhz, cores, num2
  end
end


class Memory
  attr_accessor :type, :size

  def initialize(type, size)
    if type == :ddr3
      raise "unsupported memory type"
    else
      @type = type
      @size = size
    end
  end

  def == (other)
    type == other.type && size == other.size
  end

  def print
    puts type, size
  end
end

class Server
  attr_accessor :memory, :cpu

  def initialize
    @memory = []
    @cpu = []
  end

  def add_memory(other)
    if memory.size + 1 > 16
      raise "too much memory"
    else
      memory.push(other)
    end
  end

  def add_cpu(other)
    if cpu.empty?
      cpu.push(other)
    elsif other != cpu[0]
      raise "different cpus"
    elsif cpu.size + 1 > 2
      raise "too much cpus"
    else
      cpu.push(other)
    end
  end

  def print_memory
    memory.each do |m|
      m.print
    end
  end

  def print_cpu
    cpu.each do |c|
      c.print
    end
  end

  def memory_size
    memory_size = 0
    memory.each do |m|
      memory_size += m.size
    end
    memory_size
  end

  def bootable?
    memory.any? && cpu.any?
  end

end


#def test
#  server = Server.new
#  server.add_memory Memory.new(:ddr4, 16)
#  server.add_cpu CPU.new(2, 2500, 12, 3)
#  puts server.bootable?
#end
#
#test
