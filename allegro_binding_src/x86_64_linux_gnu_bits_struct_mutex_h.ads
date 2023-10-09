pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with x86_64_linux_gnu_bits_thread_shared_types_h;

package x86_64_linux_gnu_bits_struct_mutex_h is

  -- x86 internal mutex struct definitions.
  --   Copyright (C) 2019-2020 Free Software Foundation, Inc.
  --   This file is part of the GNU C Library.
  --   The GNU C Library is free software; you can redistribute it and/or
  --   modify it under the terms of the GNU Lesser General Public
  --   License as published by the Free Software Foundation; either
  --   version 2.1 of the License, or (at your option) any later version.
  --   The GNU C Library is distributed in the hope that it will be useful,
  --   but WITHOUT ANY WARRANTY; without even the implied warranty of
  --   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  --   Lesser General Public License for more details.
  --   You should have received a copy of the GNU Lesser General Public
  --   License along with the GNU C Library; if not, see
  --   <http://www.gnu.org/licenses/>.   

   type uu_pthread_mutex_s is record
      uu_lock : aliased int;  -- /usr/include/x86_64-linux-gnu/bits/struct_mutex.h:24
      uu_count : aliased unsigned;  -- /usr/include/x86_64-linux-gnu/bits/struct_mutex.h:25
      uu_owner : aliased int;  -- /usr/include/x86_64-linux-gnu/bits/struct_mutex.h:26
      uu_nusers : aliased unsigned;  -- /usr/include/x86_64-linux-gnu/bits/struct_mutex.h:28
      uu_kind : aliased int;  -- /usr/include/x86_64-linux-gnu/bits/struct_mutex.h:32
      uu_spins : aliased short;  -- /usr/include/x86_64-linux-gnu/bits/struct_mutex.h:34
      uu_elision : aliased short;  -- /usr/include/x86_64-linux-gnu/bits/struct_mutex.h:35
      uu_list : aliased x86_64_linux_gnu_bits_thread_shared_types_h.uu_pthread_list_t;  -- /usr/include/x86_64-linux-gnu/bits/struct_mutex.h:36
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/x86_64-linux-gnu/bits/struct_mutex.h:22

  -- KIND must stay at this position in the structure to maintain
  --     binary compatibility with static initializers.   

end x86_64_linux_gnu_bits_struct_mutex_h;
