pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with x86_64_linux_gnu_bits_types_h;

package x86_64_linux_gnu_bits_types_struct_timespec_h is

  -- NB: Include guard matches what <linux/time.h> uses.   
  -- POSIX.1b structure for a time value.  This is like a `struct timeval' but
  --   has nanoseconds instead of microseconds.   

  -- Seconds.   
   type timespec is record
      tv_sec : aliased x86_64_linux_gnu_bits_types_h.uu_time_t;  -- /usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h:12
      tv_nsec : aliased x86_64_linux_gnu_bits_types_h.uu_syscall_slong_t;  -- /usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h:16
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h:10

  -- Nanoseconds.   
  -- Padding.   
  -- Nanoseconds.   
  -- Nanoseconds.   
  -- Padding.   
end x86_64_linux_gnu_bits_types_struct_timespec_h;
