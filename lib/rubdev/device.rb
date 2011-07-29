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

module RubDev
  class Device
    class << self
      private :new
    end

    def devnode
      RubDev::C.udev_device_get_devnode(@pointer)
    end

    def subsystem
      RubDev::C.udev_device_get_subsystem(@pointer)
    end

    def devtype
      RubDev::C.udev_device_get_devtype(@pointer)
    end

    def action
      RubDev::C.udev_device_get_action(@pointer)
    end

    def devpath
      RubDev::C.udev_device_get_devpath(@pointer)
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

    def driver
      RubDev::C.udev_device_get_driver(@pointer)
    end

    def devnum
      RubDev::C.udev_device_get_devnum(@pointer)
    end

    def [] (what)
      RubDev::C.udev_device_get_property_value(@pointer, what.to_s)
    end

    def ref
      RubDev::C.udev_device_ref(@pointer)
      self
    end

    def unref
      RubDev::C.udev_device_unref(@pointer)
      self
    end

    def parent
      Device.allocate.tap {|i|
        i.instance_variable_set(:@pointer, RubDev::C.udev_device_get_parent(@pointer))
      }
    end
  end
end
