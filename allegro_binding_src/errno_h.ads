pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;

package errno_h is

   --  unsupported macro: errno (*__errno_location ())
  -- Copyright (C) 1991-2020 Free Software Foundation, Inc.
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
  --   <https://www.gnu.org/licenses/>.   

  -- *	ISO C99 Standard: 7.5 Errors	<errno.h>
  --  

  -- The system-specific definitions of the E* constants, as macros.   
  -- When included from assembly language, this header only provides the
  --   E* constants.   

  -- The error code set by various library functions.   
   --  skipped func __errno_location

  -- The full and simple forms of the name with which the program was
  --   invoked.  These variables are set up automatically at startup based on
  --   the value of argv[0].   

end errno_h;
