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
  class Context
    def initialize
      @pointer = RubDev::C.udev_new
    end

    def ref
      RubDev::C.udev_ref(@pointer)
      self
    end

    def unref
      RubDev::C.udev_unref(@pointer)
      self
    end

    def log_fn= (fn)
      return false unless fn.is_a?(Proc)
      RubDev::C.udev_set_log_fn(@pointer, fn)
    end

    def log_priority
      RubDev::C.udev_get_log_priority(@pointer)
    end

    def log_priority= (p)
      return false unless p.is_a?(Integer)
      RubDev::C.udev_set_log_priority(@pointer, p)
    end

    def sys_path
      RubDev::C.udev_get_sys_path(@pointer)
    end

    def dev_path
      RubDev::C.udev_get_dev_path(@pointer)
    end

    if RubDev::C.respond_to?(:udev_get_run_path)
      def run_path
        RubDev::C.udev_get_run_path(@pointer)
      end
    end

    def userdata
      RubDev::C.udev_get_userdata(@pointer)
    end

    def userdata= (data)
      RubDev::C.udev_get_userdata(@pointer, data)
    end

    def to_c
      @pointer
    end
  end
end
