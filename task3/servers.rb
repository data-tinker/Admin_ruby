#!/usr/bin/env ruby

class CPU
  attr_accessor :mhz, :cores, :type

  def initialize(mhz, cores, type)
    @mhz = mhz
    @cores = cores
    @type = type
  end

  def == (other)
    mhz == other.mhz && cores == other.cores && type == other.type
  end

  def != (other)
    not (self == other)
  end

  def print
    puts mhz, cores, type
  end
end


class Memory
  attr_accessor :type, :size

  def initialize(type, size)
      @type = type
      @size = size
  end

  def == (other)
    type == other.type && size == other.size
  end

  def print
    puts type, size
  end
end

class Server
  attr_accessor :memory, :cpu, :memory_conf, :cpu_conf

  def initialize
    @memory = []
    @cpu = []
    @memory_conf = []
    @cpu_conf = []
  end

  def memory_slots(num, type)
    @memory_conf = [num, type]
  end

  def cpu_sockets(num, type)
    @cpu_conf = [num, type]
  end

#  def << (other)
#    if other.class.superclass.name == CPU
#      add_cpu(other)
#    else
#      add_memory(other)
#    end
#  end

  def add_memory(other)
    memory.push(other)
  end

  def check_cpu(other)
    if cpu.size  > cpu_conf[0]
      raise "No more sockets left"
    elsif other.type == :ivybridge
      raise "Unsupported CPU type"
    elsif cpu.size == 0
      cpu.push(other)
    elsif other != cpu[0]
      raise "All CPUs should by identical"
    end
  end

  def add_cpu(other)
    if check_cpu(other)
      cpu.push(other)
    end
  end

  def << other
    if other.class.superclass.name == "CPU"
      add_cpu(other)
    elsif other.class.superclass.name == "Memory"
      add_memory(other)
    elsif other.class.name == "CPU"
      add_cpu(other)
    else
      add_memory(other)
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

class R530 < Server
  def initialize
    @memory = []
    @cpu = []
    memory_slots 16, :ddr4
    cpu_sockets 2, :haswell
  end
end

class R920 < Server
  def initialize
    @memory = []
    @cpu = []
    memory_slots 32, :ddr3
    cpu_sockets 4, :ivybridge
  end
end

class E5_4650 < CPU
  def initialize
    super 2100, 12, :haswell
  end
end

class E5_4660 < CPU
  def initialize
    super 2100, 14, :haswell
  end
end

class E5_2620 < CPU
  def initialize
    super 2100, 6, :ivybridge
  end
end

class DDR3_16 < Memory
  def initialize
    super :ddr3, 16
  end
end

class DDR4_16 < Memory
  def initialize
    super :ddr4, 16
  end
end

def test
  server = R530.new
  server << E5_4650.new
  server << E5_4660.new
end

test