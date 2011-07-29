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
require 'rubdev/list'

module RubDev
  class Enumerate
    def ref
      RubDev::C.udev_enumerate_ref(@pointer)
      self
    end

    def unref
      RubDev::C.udev_enumerate_unref(@pointer)
      self
    end

    def context
      Context.allocate.tap {|i|
        i.instance_variable_set(:@pointer, RubDev::C.udev_enumerate_get_udev(@pointer))
      }
    end

    def initialize (context)
      raise ArgumentError, "argument is NOT a RubDev::Context" unless context.is_a?(Context)

      @pointer = RubDev::C.udev_enumerate_new(context.to_c)
    end

    def match_subsystem (subsystem)
      !RubDev::C.udev_enumerate_add_match_subsystem(@pointer, subsystem).zero?
    end

    def nomatch_subsystem (subsystem)
      !RubDev::C.udev_enumerate_add_nomatch_subsystem(@pointer, subsystem).zero?
    end

    def match_sysattr (sysattr, value)
      !RubDev::C.udev_enumerate_add_match_sysattr(@pointer, sysattr, value).zero?
    end

    def nomatch_sysattr (sysattr, value)
      !RubDev::C.udev_enumerate_add_nomatch_sysattr(@pointer, sysattr, value).zero?
    end

    def match_property (property, value)
      !RubDev::C.udev_enumerate_add_match_property(@pointer, property, value).zero?
    end

    def match_tag (tag)
      !RubDev::C.udev_enumerate_add_match_tag(@pointer, tag).zero?
    end

    if RubDev::C.respond_to?(:udev_enumerate_add_match_parent)
      def match_parent (parent)
        !RubDev::C.udev_enumerate_add_match_parent(@pointer, parent).zero?
      end
    end

    if RubDev::C.respond_to?(:udev_enumerate_add_match_is_initialized)
      def match_initialized
        !RubDev::C.udev_enumerate_add_match_is_initialized(@pointer).zero?
      end
    end

    def match_sysname (sysname)
      !RubDev::C.udev_enumerate_add_match_sysname(@pointer, sysname).zero?
    end

    def syspath= (syspath)
      !RubDev::C.udev_enumerate_add_syspath(syspath).zero?
    end

    def scan_devices
      !RubDev::C.udev_enumerate_scan_devices(@pointer).zero?
    end

    def scan_subsystems
      !RubDev::C.udev_enumerate_scan_subsystems(@pointer).zero?
    end

    def to_list
      List.new(RubDev::C.udev_enumerate_get_list_entry(@pointer))
    end
  end
end
