#!/usr/bin/ruby

require "io/console"

IS_DEBUG = false
LOOP_INTERVAL_SEC = 1

is_exit_required = false

Signal.trap("SIGINT") {
  puts "\nCTRL+C detected"
  is_exit_required = true
}


def read_proc_stat
  cpu_core_vs_cpu_times = {}

  File.foreach("/proc/stat") { |line|
    matched = line.match(/^cpu(\d+)\s+(.+)$/)

    next if matched.nil?
    next if matched[1].empty?  # total line

    # 0 : user
    # 1 : nice
    # 2 : system
    # 3 : idle
    # 4 : iowait
    # 5 : irq
    # 6 : softirq
    # 7 : steal
    # 8 : guest
    # 9 : guest_nice
    values = matched[2].split.map { |val|
        val.to_i
    }

    cpu_core_vs_cpu_times[matched[1].to_i] = values
  }

  return cpu_core_vs_cpu_times
end

def calc_cpu_load(prev_cpu_core_vs_cpu_times, cur_cpu_core_vs_cpu_times)
  cpu_core_vs_cpu_load = {}

  cur_cpu_core_vs_cpu_times.keys.each { |index|
    if !prev_cpu_core_vs_cpu_times.keys.include?(index)
      cpu_core_vs_cpu_load[index] = 0.0
      next
    end

    prev_total = prev_cpu_core_vs_cpu_times[index].sum
    cur_total = cur_cpu_core_vs_cpu_times[index].sum

    diff_total = cur_total - prev_total

    # 3 : idle
    prev_idle = prev_cpu_core_vs_cpu_times[index][3]
    cur_idle = cur_cpu_core_vs_cpu_times[index][3]

    diff_idle = cur_idle - prev_idle

    # calc load
    cpu_core_vs_cpu_load[index] = (diff_total - diff_idle).to_f / diff_total.to_f
  }

  if IS_DEBUG
    puts "calc_cpu_load()"
    cpu_core_vs_cpu_load.each { |i, l|
      puts "    #{i} : #{l} [pct]"
    }
  end

  return cpu_core_vs_cpu_load
end

def read_cpu_temperature
  cpu_vs_temp = {}
  cpu_vs_core_vs_temp = Hash.new { |h, k| h[k] = {} }

  cpu = -1
  `sensors`.each_line { |line|
    matched = line.match(/^Package id (\d+):\s+\+(\d+\.\d+)°C\s/)
    if !matched.nil?
      # package line
      cpu = matched[1].to_i
      deg = matched[2].to_f

      cpu_vs_temp[cpu] = deg
      next
    end

    matched = line.match(/^Core\s(\d+):\s+\+(\d+\.\d+)°C\s/)
    if !matched.nil?
      # core line
      core = matched[1].to_i
      deg = matched[2].to_f

      cpu_vs_core_vs_temp[cpu][core] = deg
      next
    end
  }

  if IS_DEBUG
    puts "cpu package"
    cpu_vs_temp.each { |cpu, temp|
      puts "    #{cpu} : #{temp} [degC]"
    }
    puts "cpu/core"
    cpu_vs_core_vs_temp.each { |cpu, core_vs_temp|
      core_vs_temp.each { |core, temp|
        puts "    #{cpu}/#{core} : #{temp} [degC]"
      }
    }
  end

  return cpu_vs_temp, cpu_vs_core_vs_temp
end

def read_gpu_stats
  output = `nvidia-smi --query-gpu=utilization.gpu,temperature.gpu,memory.used,memory.total --format=csv,noheader,nounits`

  elms = output.split(",").map { |elm| elm.strip! }

  gpu_load = elms[0].to_f
  gpu_temp = elms[1].to_f
  vram_used = elms[2].to_f
  vram_total = elms[3].to_f

  if IS_DEBUG
    puts "read_gpu_stats()"
    puts "    gpu_load    = #{gpu_load} [pct]"
    puts "    gpu_temp    = #{gpu_temp} [degC]"
    puts "    vram_used   = #{vram_used} [MiB]"
    puts "    vram_total  = #{vram_total} [MiB]"
  end

  return gpu_load, gpu_temp, vram_used, vram_total
end

def read_proc_meminfo
  label_vs_size = {}

  File.foreach("/proc/meminfo") { |line|
    matched = line.match(/^(\w+):\s+(\d+)\s+kB$/)

    next if matched.nil?

    label_vs_size[matched[1]] = matched[2].to_i
  }

  ram_total = label_vs_size["MemTotal"]
  ram_used = ram_total - label_vs_size["MemAvailable"]
  swap_total = label_vs_size["SwapTotal"]
  swap_used = swap_total - label_vs_size["SwapFree"]

  if IS_DEBUG
    puts "read_proc_meminfo()"
    puts "    ram_total   = #{ram_total} [kB]"
    puts "    ram_used    = #{ram_used} [kB]"
    puts "    swap_total  = #{swap_total} [kB]"
    puts "    swap_used   = #{swap_used} [kB]"
  end

  return ram_total, ram_used, swap_total, swap_used
end

def read_proc_loadavg
  elms = File.read("/proc/loadavg").split

  load_1min = elms[0].to_f
  load_5min = elms[1].to_f
  load_15min = elms[2].to_f

  running_task = elms[3]

  if IS_DEBUG
    puts "read_proc_loadavg()"
    puts "    load_1min     = #{load_1min} [task/cores]"
    puts "    load_5min     = #{load_5min} [task/cores]"
    puts "    load_15min    = #{load_15min} [task/cores]"
    puts "    running_task  = #{running_task} [running_task/all_tasks]"
  end

  return load_1min, load_5min, load_15min, running_task
end

def read_proc_diskstats
  device_vs_read_write = {}

  File.foreach("/proc/diskstats") { |line|
    elms = line.split

    device = elms[2].strip
    matched = device.match(/^nvme\d+n\d+$|^sd[a-z]+$/)  # nvmeXnX or sdX

    next if matched.nil?

    sector_size = `cat /sys/class/block/#{device}/queue/hw_sector_size`.to_i

    # 5 : read sectors
    # 9 : write sectors
    r_bytes = elms[5].to_i * sector_size
    w_bytes = elms[9].to_i * sector_size

    device_vs_read_write[device] = [r_bytes, w_bytes]
  }

  if IS_DEBUG
    puts "read_proc_diskstats()"
    device_vs_read_write.each{ |device, (read, write)|
      puts "    #{device} : read=#{read} [byte], write=#{write} [byte]"
    }
  end

  return device_vs_read_write
end

def calc_device_rw(prev_device_vs_read_write, cur_device_vs_read_write)
  device_vs_read_write = {}

  cur_device_vs_read_write.each { |device, (cur_read, cur_write)|
    if !prev_device_vs_read_write.keys.include?(device)
      device_vs_read_write[device] = [0, 0]
      next
    end

    (prev_read, prev_write) = prev_device_vs_read_write[device]

    diff_read = (cur_read - prev_read) / LOOP_INTERVAL_SEC
    diff_write = (cur_write - prev_write) / LOOP_INTERVAL_SEC

    device_vs_read_write[device] = [diff_read, diff_write]
  }

  if IS_DEBUG
    puts "calc_disk_rw()"
    device_vs_read_write.each { |device, (read, write)|
      puts "    #{device} : read=#{read} [byte/sec], write#{write} [byte/sec]"
    }
  end

  return device_vs_read_write
end

def read_proc_net_dev
  interface_vs_rx_tx = {}

  File.foreach("/proc/net/dev") { |line|
    next if !line.include?(":")

    device, data = line.split(":", 2)

    device.strip!

    # 0 : receive bytes
    # 8 : transmit bytes
    elms = data.split

    interface_vs_rx_tx[device] = [elms[0].to_i, elms[8].to_i]
  }

  if IS_DEBUG
    puts "read_proc_net_dev()"
    interface_vs_rx_tx.each { |intf, (rx, tx)|
      puts "    #{intf} : receive=#{rx} [byte], transmit=#{tx} [byte]"
    }
  end

  return interface_vs_rx_tx
end

def calc_net_io(prev_interface_vs_rx_tx, cur_interface_vs_rx_tx)
  interface_vs_rx_tx = {}

  cur_interface_vs_rx_tx.each { |intf, (cur_rx, cur_tx)|
    if !prev_interface_vs_rx_tx.keys.include?(intf)
      interface_vs_rx_tx[intf] = [0.0, 0.0]
      next
    end

    (prev_rx, prev_tx) = prev_interface_vs_rx_tx[intf]

    diff_rx = (cur_rx - prev_rx) / LOOP_INTERVAL_SEC
    diff_tx = (cur_tx - prev_tx) / LOOP_INTERVAL_SEC

    interface_vs_rx_tx[intf] = [diff_rx, diff_tx]
  }

  if IS_DEBUG
    puts "calc_net_io()"
    interface_vs_rx_tx.each { |intf, (rx, tx)|
      puts "    #{intf} : rx=#{rx} [byte/sec], tx=#{tx} [byte/sec]"
    }
  end

  return interface_vs_rx_tx
end



prev_cpu_core_vs_cpu_times = read_proc_stat()
prev_device_vs_read_write = read_proc_diskstats()
prev_interface_vs_rx_tx = read_proc_net_dev()

sleep LOOP_INTERVAL_SEC

loop {
  exit if is_exit_required

  proc_start_sec = Process.clock_gettime(Process::CLOCK_MONOTONIC)

  # CPU load
  cur_cpu_core_vs_cpu_times = read_proc_stat()
  cpu_vs_load = calc_cpu_load(prev_cpu_core_vs_cpu_times, cur_cpu_core_vs_cpu_times)
  prev_cpu_core_vs_cpu_times = cur_cpu_core_vs_cpu_times

  # CPU temp
  cpu_vs_temp, cpu_vs_core_vs_temp = read_cpu_temperature()

  # GPU
  gpu_load, gpu_temp, vram_used, vram_total = read_gpu_stats()

  # Memory
  ram_total, ram_used, swap_total, swap_used = read_proc_meminfo()

  # Load
  load_1min, load_5min, load_15min, running_task = read_proc_loadavg()

  # Disk I/O
  cur_device_vs_read_write = read_proc_diskstats()
  device_vs_read_write = calc_device_rw(prev_device_vs_read_write, cur_device_vs_read_write)
  prev_device_vs_read_write = cur_device_vs_read_write

  # Net I/O
  cur_interface_vs_rx_tx = read_proc_net_dev()
  interface_vs_rx_tx = calc_net_io(prev_interface_vs_rx_tx, cur_interface_vs_rx_tx)
  prev_interface_vs_rx_tx = cur_interface_vs_rx_tx






  # display

  cpu_line = "CPU LOAD  |  "
  cpu_vs_load.each { |cpu, ld|
    cpu_line += "#{cpu}: #{format("%.2f", ld * 100.0)}  "
  }
  cpu_line += "[%]"

  gpu_line = "GPU LOAD  |  #{gpu_load} [%]"

  ram_line = "RAM       |  #{format("%.2f", ram_used.to_f / 1024 / 1024)} / #{format("%.2f", ram_total.to_f / 1024 / 1024)} [GiB]  (#{format("%.2f", ram_used.to_f / ram_total.to_f * 100.0)} [%])"

  vram_line = "VRAM      |  #{vram_used} / #{vram_total} [MiB]  (#{format("%.2f", vram_used.to_f / vram_total.to_f * 100.0)} [%])"

  load_line = "LOAD AVG  |  #{load_1min} / #{load_5min} / #{load_15min} [1/5/15 min task/cores]   #{running_task} [running task / all tasks]"

  disk_line = "DISK R/W  |  "
  device_vs_read_write.each { |dev, (r, w)|
    disk_line += "#{dev}: #{r} / #{w}   "
  }
  disk_line += "[byte/sec]"

  net_line = "NET R/T   |  "
  interface_vs_rx_tx.each { |intf, (rx, tx)|
    net_line += "#{intf}: #{rx} / #{tx}   "
  }
  net_line += "[byte/sec]"

  tmp_cpu_line = "TMP CPU   |  "
  cpu_vs_temp.each { |cpu, temp|
    tmp_cpu_line += "#{cpu}: #{temp} "
    core_values = cpu_vs_core_vs_temp[cpu].values
    tmp_cpu_line += "( #{core_values.join(" / ")} )  "
  }
  tmp_cpu_line += "[degC]"

  tmp_gpu_line = "TMP GPU   |  #{gpu_temp} [degC]"


  total_lines = [
      cpu_line,
      gpu_line,
      ram_line,
      vram_line,
      load_line,
      disk_line,
      net_line,
      tmp_cpu_line,
      tmp_gpu_line,
  ].join("\n")


  elapsed_sec = Process.clock_gettime(Process::CLOCK_MONOTONIC) - proc_start_sec

  total_lines += "\n"
  total_lines += "calc stats elapsed time  =  #{format("%.2f", elapsed_sec * 1000)}  [ms]"

  rows, cols = STDOUT.winsize
  total_lines = "\n" * (rows - total_lines.lines.count) + total_lines
  puts total_lines

  sleep_sec = LOOP_INTERVAL_SEC - elapsed_sec
  if sleep_sec > 0.0
    sleep sleep_sec
  end
}

