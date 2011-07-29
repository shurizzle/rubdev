#--
# Copyleft shura. [ shura1991@gmail.com ]
#
# This file is part of rubdev.
#
# rubdev is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# rubdev is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with rubdev. If not, see <http://www.gnu.org/licenses/>.
#++

require 'rubdev/c'
require 'rubdev/context'
require 'rubdev/device'

module RubDev
  class Monitor
    def ref
      RubDev::C.udev_monitor_ref(@pointer)
      self
    end

    def unref
      RubDev::C.udev_monitor_unref(@pointer)
      self
    end

    def context
      Context.allocate.tap {|i|
        i.instance_variable_set(:@pointer, RubDev::C.udev_monitor_get_udev(@pointer))
      }
    end

    class << self
      private :new

      def from_netlink (context, name)
        self.allocate.tap {|i|
          i.instance_variable_set(:@pointer, RubDev::C.udev_monitor_new_from_netlink(context.to_c, name))
        }
      end

      def from_socket (context, path)
        self.allocate.tap {|i|
          i.instance_variable_set(:@pointer, RubDev::C.udev_monitor_new_from_socket(context.to_c, path))
        }
      end
    end

    def enable_receiving
      RubDev::C.udev_monitor_enable_receiving(@pointer)
    end

    def buffer_size= (size)
      return false unless size.is_a?(Integer)
      RubDev::C.udev_monitor_set_receive_buffer_size(@pointer, size)
    end

    def fd
      RubDev::C.udev_monitor_get_fd(@pointer)
    end

    def receive_device
      Device.allocate.tap {|i|
        i.instance_variable_set(:@pointer, RubDev::C.udev_monitor_receive_device(@pointer))
      }
    end

    def filter_add_match_subsystem_devtype (subsystem, devtype=nil)
      RubDev::C.udev_monitor_filter_add_match_subsystem_devtype(@pointer, subsystem, devtype)
    end

    def filter_add_match_tag (tag)
      RubDev::C.udev_monitor_filter_add_match_tag(@pointer, tag)
    end

    def filter_update
      RubDev::C.udev_monitor_filter_update(@pointer)
    end

    def filter_remove
      RubDev::C.udev_monitor_filter_remove(@pointer)
    end

    def to_io
      IO.for_fd(fd)
    end
  end
end
