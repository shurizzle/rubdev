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
  class List
    include Enumerable

    def initialize (list)
      @top = list
      rewind
    end

    def rewind
      @pointer = @top
      self
    end

    def next
      @pointer = RubDev::C.udev_list_entry_get_next(@pointer)
      self
    end

    def by_name (name)
      RubDev::C.udev_list_entry_get_by_name(@pointer, name)
      self
    end

    def name
      RubDev::C.udev_list_entry_get_name(@pointer)
    end

    def value
      RubDev::C.udev_list_entry_get_value(@pointer)
    end

    def [] (name)
      by_name(name).value
    end

    def each(&blk)
      array = []
      pointer = @pointer
      rewind
      unless @pointer.null?
        blk.call(name, value) if blk
        array << [name, value]
        self.next
      end
      @pointer = pointer
      blk ? array : Enumerator.new(array)
    end
  end
end
