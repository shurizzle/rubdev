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

require 'ffi'

module RubDev
  module C
    extend FFI::Library

    ffi_lib 'udev'

    FFI.typedef(:ulong, :dev_t)

    callback :logger, [:pointer, :int, :string, :int, :string, :string, :pointer], :void

    # context {{{
    attach_function :udev_ref, [:pointer], :pointer
    attach_function :udev_unref, [:pointer], :void
    attach_function :udev_new, [], :pointer
    attach_function :udev_set_log_fn, [:pointer, :logger], :void
    attach_function :udev_get_log_priority, [:pointer], :int
    attach_function :udev_set_log_priority, [:pointer, :int], :void
    attach_function :udev_get_sys_path, [:pointer], :string
    attach_function :udev_get_dev_path, [:pointer], :string
    attach_function :udev_get_run_path, [:pointer], :string
    attach_function :udev_get_userdata, [:pointer], :pointer
    attach_function :udev_set_userdata, [:pointer, :pointer], :void
    # }}}

    # list {{{
    attach_function :udev_list_entry_get_next, [:pointer], :pointer
    attach_function :udev_list_entry_get_by_name, [:pointer, :string], :pointer
    attach_function :udev_list_entry_get_name, [:pointer], :string
    attach_function :udev_list_entry_get_value, [:pointer], :string
    # }}}

    # device {{{
    attach_function :udev_device_ref, [:pointer], :void
    attach_function :udev_device_unref, [:pointer], :void
    attach_function :udev_device_get_udev, [:pointer], :pointer
    attach_function :udev_device_new_from_syspath, [:pointer, :string], :pointer
    attach_function :udev_device_new_from_devnum, [:pointer, :char, :dev_t], :pointer
    attach_function :udev_device_new_from_subsystem_sysname, [:pointer, :string, :string], :pointer
    attach_function :udev_device_new_from_environment, [:pointer], :pointer
    attach_function :udev_device_get_parent, [:pointer], :pointer
    attach_function :udev_device_get_parent_with_subsystem_devtype, [:pointer, :string, :string], :pointer
    attach_function :udev_device_get_devpath, [:pointer], :string
    attach_function :udev_device_get_subsystem, [:pointer], :string
    attach_function :udev_device_get_devtype, [:pointer], :string
    attach_function :udev_device_get_syspath, [:pointer], :string
    attach_function :udev_device_get_sysname, [:pointer], :string
    attach_function :udev_device_get_sysnum, [:pointer], :string
    attach_function :udev_device_get_devnode, [:pointer], :string
    attach_function :udev_device_get_is_initialized, [:pointer], :int

    attach_function :udev_device_get_devlinks_list_entry, [:pointer], :pointer
    attach_function :udev_device_get_properties_list_entry, [:pointer], :pointer
    attach_function :udev_device_get_tags_list_entry, [:pointer], :pointer

    attach_function :udev_device_get_property_value, [:pointer, :string], :string
    attach_function :udev_device_get_driver, [:pointer], :string
    attach_function :udev_device_get_devnum, [:pointer], :dev_t
    attach_function :udev_device_get_action, [:pointer], :string
    attach_function :udev_device_get_sysattr_value, [:pointer, :string], :string
    attach_function :udev_device_get_sysattr_list_entry, [:pointer], :pointer
    attach_function :udev_device_get_seqnum, [:pointer], :long_long
    attach_function :udev_device_get_usec_since_initialized, [:pointer], :long_long
    attach_function :udev_device_has_tag, [:pointer, :string], :int
    # }}}

    # monitor {{{
    attach_function :udev_monitor_ref, [:pointer], :pointer
    attach_function :udev_monitor_unref, [:pointer], :void
    attach_function :udev_monitor_get_udev, [:pointer], :pointer
    attach_function :udev_monitor_new_from_netlink, [:pointer, :string], :pointer
    attach_function :udev_monitor_new_from_socket, [:pointer, :string], :pointer
    attach_function :udev_monitor_enable_receiving, [:pointer], :int
    attach_function :udev_monitor_set_receive_buffer_size, [:pointer, :int], :int
    attach_function :udev_monitor_get_fd, [:pointer], :int
    attach_function :udev_monitor_receive_device, [:pointer], :pointer
    attach_function :udev_monitor_filter_add_match_subsystem_devtype, [:pointer, :string, :string], :int
    attach_function :udev_monitor_filter_add_match_tag, [:pointer, :string], :int
    attach_function :udev_monitor_filter_update, [:pointer], :int
    attach_function :udev_monitor_filter_remove, [:pointer], :int
    # }}}

    # enumerate {{{
    attach_function :udev_enumerate_ref, [:pointer], :pointer
    attach_function :udev_enumerate_unref, [:pointer], :void
    attach_function :udev_enumerate_get_udev, [:pointer], :pointer
    attach_function :udev_enumerate_new, [:pointer], :pointer
    attach_function :udev_enumerate_add_match_subsystem, [:pointer, :string], :int
    attach_function :udev_enumerate_add_nomatch_subsystem, [:pointer, :string], :int
    attach_function :udev_enumerate_add_match_sysattr, [:pointer, :string, :string], :int
    attach_function :udev_enumerate_add_nomatch_sysattr, [:pointer, :string, :string], :int
    attach_function :udev_enumerate_add_match_property, [:pointer, :string, :string], :int
    attach_function :udev_enumerate_add_match_tag, [:pointer, :string], :int
    attach_function :udev_enumerate_add_match_parent, [:pointer, :pointer], :int
    attach_function :udev_enumerate_add_match_is_initialized, [:pointer], :int
    attach_function :udev_enumerate_add_match_sysname, [:pointer, :string], :int
    attach_function :udev_enumerate_add_syspath, [:pointer, :string], :int
    attach_function :udev_enumerate_scan_devices, [:pointer], :int
    attach_function :udev_enumerate_scan_subsystems, [:pointer], :int
    attach_function :udev_enumerate_get_list_entry, [:pointer], :pointer
    # }}}

    # queue {{{
    attach_function :udev_queue_ref, [:pointer], :pointer
    attach_function :udev_queue_unref, [:pointer], :void
    attach_function :udev_queue_get_udev, [:pointer], :pointer
    attach_function :udev_queue_new, [:pointer], :pointer
    attach_function :udev_queue_get_udev_is_active, [:pointer], :int
    attach_function :udev_queue_get_queue_is_empty, [:pointer], :int
    attach_function :udev_queue_get_seqnum_is_finished, [:pointer, :ulong_long], :int
    attach_function :udev_queue_get_seqnum_sequence_is_finished, [:pointer, :ulong_long, :ulong_long], :int
    attach_function :udev_queue_get_queued_list_entry, [:pointer], :pointer
    attach_function :udev_queue_get_failed_list_entry, [:pointer], :pointer
    attach_function :udev_queue_get_kernel_seqnum, [:pointer], :ulong_long
    attach_function :udev_queue_get_udev_seqnum, [:pointer], :ulong_long
    # }}}
  end
end
