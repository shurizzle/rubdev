$:.unshift File.expand_path(File.join('..', '..', 'lib'), __FILE__)
require 'rubdev'

c = RubDev::Context.new
m = RubDev::Monitor.from_netlink(c, 'udev')
m.filter_add_match_subsystem_devtype('block')
m.enable_receiving
fd = m.to_io

loop {
  fds = IO.select([fd])
  next if !fds or fds.empty?

  d = m.receive_device

  puts "Got device"
  puts "  node:      #{d.devnode}"
  puts "  subsystem: #{d.subsystem}"
  puts "  devtype:   #{d.devtype}"
  puts "  action:    #{d.action}"
  d.unref
}
