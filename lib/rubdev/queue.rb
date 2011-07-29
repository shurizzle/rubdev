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
  class Queue
    def ref
      RubDev::C.udev_queue_ref(@pointer)
      self
    end

    def unref
      RubDev::C.udev_queue_unref(@pointer)
      self
    end

    def context
      Context.allocate.tap {|i|
        i.instance_variable_set(:@pointer, RubDev::C.udev_queue_get_udev(@pointer))
      }
    end

    def initialize (context)
      raise ArgumentError, "argument is NOT a RubDev::Context" unless context.is_a?(Context)

      @pointer = RubDev::C.udev_queue_new(context.to_c)
    end

    def active?
      !RubDev::C.udev_queue_get_udev_is_active(@pointer).zero?
    end

    def empty?
      !RubDev::C.udev_queue_get_queue_is_empty(@pointer).zero?
    end

    def seqnum_finished? (seqnum)
      !RubDev::C.udev_queue_get_seqnum_is_finished(@pointer, seqnum).zero?
    end

    def seqnum_sequence_finished? (start, stop)
      !RubDev::C.udev_queue_get_seqnum_sequence_is_finished(@pointer, start, stop).zero?
    end

    def queued
      List.new(RubDev::C.udev_queue_get_queued_list_entry(@pointer))
    end

    def failed
      List.new(RubDev::C.udev_queue_get_failed_list_entry(@pointer))
    end

    def kernel_seqnum
      RubDev::C.udev_queue_get_kernel_seqnum(@pointer)
    end

    def udev_seqnum
      RubDev::C.udev_queue_get_udev_seqnum(@pointer)
    end
  end
end
