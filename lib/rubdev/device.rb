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
require 'rubdev/list'

module RubDev
  class Device
    def ref
      RubDev::C.udev_device_ref(@pointer)
      self
    end

    def unref
      RubDev::C.udev_device_unref(@pointer)
      self
    end

    def context
      Context.allocate.tap {|c|
        c.instance_variable_set(:@pointer, RubDev::C.udev_device_get_udev(@pointer))
      }
    end

    class << self
      private :new

      def from_syspath (context, syspath)
        return nil unless context.is_a?(Context) and syspath.is_a?(String)

        self.allocate.tap {|d|
          d.instance_variable_set(:@pointer, RubDev::C.udev_device_new_from_syspath(context.to_c, syspath))
        }
      end

      def from_devnum (context, type, devnum)
        return nil unless context.is_a?(Context) and type.is_a?(String) and
          type.bytesize == 1 and devnum.is_a?(Integer)

        self.allocate.tap {|d|
          d.instance_variable_set(:@pointer, RubDev::C.udev_device_new_from_devnum(context.to_c, type, devnum))
        }
      end

      def from_subsystem_sysname (context, subsystem, sysname)
        return nil unless context.is_a?(Context) and subsystem.is_a?(String) and sysname.is_a?(String)

        self.allocate.tap {|d|
          d.instance_variable_set(:@pointer, RubDev::C.udev_device_new_from_subsystem_sysname(context.to_c, subsystem, sysname))
        }
      end

      def from_environment (context)
        return nil unless context.is_a?(Context)

        self.allocate.tap {|d|
          d.instance_variable_set(:@pointer, RubDev::C.udev_device_new_from_environment(context.to_c))
        }
      end
    end

    def parent
      Device.allocate.tap {|i|
        i.instance_variable_set(:@pointer, RubDev::C.udev_device_get_parent(@pointer))
      }
    end

    def parent_with_subsystem_devtype (subsystem, devtype)
      Device.allocate.tap {|i|
        i.instance_variable_set(:@pointer, RubDev::C.udev_device_get_parent_with_subsytem_devtype(@pointer, subsystem, devtype))
      }
    end

    def devpath
      RubDev::C.udev_device_get_devpath(@pointer)
    end

    def subsystem
      RubDev::C.udev_device_get_subsystem(@pointer)
    end

    def devtype
      RubDev::C.udev_device_get_devtype(@pointer)
    end

    def syspath
      RubDev::C.udev_device_get_syspath(@pointer)
    end

    def sysname
      RubDev::C.udev_device_get_sysname(@pointer)
    end

    def sysnum
      RubDev::C.udev_device_get_sysnum(@pointer)
    end

    def devnode
      RubDev::C.udev_device_get_devnode(@pointer)
    end

    if RubDev::C.respond_to?(:udev_device_get_is_initialized)
      def initialized?
        !RubDev::C.udev_device_get_is_initialized(@pointer).zero?
      end
    end

    def devlinks
      List.new(RubDev::C.udev_device_get_devlinks_list_entry(@pointer))
    end

    def properties
      List.new(RubDev::C.udev_device_get_properties_list_entry(@pointer))
    end

    def tags
      List.new(RubDev::C.udev_device_get_tags_list_entry(@pointer))
    end

    def property (what)
      RubDev::C.udev_device_get_property_value(@pointer, what.to_s)
    end
    alias [] property

    def driver
      RubDev::C.udev_device_get_driver(@pointer)
    end

    def devnum
      RubDev::C.udev_device_get_devnum(@pointer)
    end

    def action
      RubDev::C.udev_device_get_action(@pointer)
    end

    def sysattr (what)
      RubDev::C.udev_device_get_sysattr_value(@pointer, what)
    end

    if RubDev::C.respond_to?(:udev_device_get_sysattr_list_entry)
      def sysattrs
        List.new(RubDev::C.udev_device_get_sysattr_list_entry(@pointer))
      end
    end

    def seqnum
      RubDev::C.udev_device_get_seqnum(@pointer)
    end

    if RubDev::C.respond_to?(:udev_device_get_usec_since_initialized)
      def usec
        RubDev::C.udev_device_get_usec_since_initialized(@pointer)
      end
    end

    if RubDev::C.respond_to?(:udev_device_has_tag)
      def tag? (tag)
        !RubDev::C.udev_device_has_tag(tag).zero?
      end
    end
  end
end
