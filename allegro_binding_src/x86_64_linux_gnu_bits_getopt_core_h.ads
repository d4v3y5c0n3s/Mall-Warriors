pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;
with System;

package x86_64_linux_gnu_bits_getopt_core_h is

  -- Declarations for getopt (basic, portable features only).
  --   Copyright (C) 1989-2020 Free Software Foundation, Inc.
  --   This file is part of the GNU C Library and is also part of gnulib.
  --   Patches to this file should be submitted to both projects.
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
  --   <https://www.gnu.org/licenses/>.   

  -- This header should not be used directly; include getopt.h or
  --   unistd.h instead.  Unlike most bits headers, it does not have
  --   a protective #error, because the guard macro for getopt.h in
  --   gnulib is not fixed.   

  -- For communication from 'getopt' to the caller.
  --   When 'getopt' finds an option that takes an argument,
  --   the argument value is returned here.
  --   Also, when 'ordering' is RETURN_IN_ORDER,
  --   each non-option ARGV-element is returned here.   

   optarg : Interfaces.C.Strings.chars_ptr  -- /usr/include/x86_64-linux-gnu/bits/getopt_core.h:36
   with Import => True, 
        Convention => C, 
        External_Name => "optarg";

  -- Index in ARGV of the next element to be scanned.
  --   This is used for communication to and from the caller
  --   and for communication between successive calls to 'getopt'.
  --   On entry to 'getopt', zero means this is the first call; initialize.
  --   When 'getopt' returns -1, this is the index of the first of the
  --   non-option elements that the caller should itself scan.
  --   Otherwise, 'optind' communicates from one call to the next
  --   how much of ARGV has been scanned so far.   

   optind : aliased int  -- /usr/include/x86_64-linux-gnu/bits/getopt_core.h:50
   with Import => True, 
        Convention => C, 
        External_Name => "optind";

  -- Callers store zero here to inhibit the error message 'getopt' prints
  --   for unrecognized options.   

   opterr : aliased int  -- /usr/include/x86_64-linux-gnu/bits/getopt_core.h:55
   with Import => True, 
        Convention => C, 
        External_Name => "opterr";

  -- Set to an option character which was unrecognized.   
   optopt : aliased int  -- /usr/include/x86_64-linux-gnu/bits/getopt_core.h:59
   with Import => True, 
        Convention => C, 
        External_Name => "optopt";

  -- Get definitions and prototypes for functions to process the
  --   arguments in ARGV (ARGC of them, minus the program name) for
  --   options given in OPTS.
  --   Return the option character from OPTS just read.  Return -1 when
  --   there are no more options.  For unrecognized options, or options
  --   missing arguments, 'optopt' is set to the option letter, and '?' is
  --   returned.
  --   The OPTS string is a list of characters which are recognized option
  --   letters, optionally followed by colons, specifying that that letter
  --   takes an argument, to be placed in 'optarg'.
  --   If a letter in OPTS is followed by two colons, its argument is
  --   optional.  This behavior is specific to the GNU 'getopt'.
  --   The argument '--' causes premature termination of argument
  --   scanning, explicitly telling 'getopt' that there are no more
  --   options.
  --   If OPTS begins with '-', then non-option arguments are treated as
  --   arguments to the option '\1'.  This behavior is specific to the GNU
  --   'getopt'.  If OPTS begins with '+', or POSIXLY_CORRECT is set in
  --   the environment, then do not permute arguments.
  --   For standards compliance, the 'argv' argument has the type
  --   char *const *, but this is inaccurate; if argument permutation is
  --   enabled, the argv array (not the strings it points to) must be
  --   writable.   

   function getopt
     (uuu_argc : int;
      uuu_argv : System.Address;
      uu_shortopts : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/x86_64-linux-gnu/bits/getopt_core.h:91
   with Import => True, 
        Convention => C, 
        External_Name => "getopt";

end x86_64_linux_gnu_bits_getopt_core_h;
