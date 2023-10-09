pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with allegro5_fixed_h;

package allegro5_inline_fmaths_inl is

  --         ______   ___    ___
  -- *        /\  _  \ /\_ \  /\_  *        \ \ \L\ \\//\ \ \//\ \      __     __   _ __   ___
  --_
  -- *         \ \  __ \ \ \ \  \ \ \   /'__`\ /'_ `\/\`'__\/ __` *          \ \ \/\ \ \_\ \_ \_\ \_/\  __//\ \L\ \ \ \//\ \L\  *           \ \_\ \_\/\____\/\____\ \____\ \____ \ \_\\ \____/
  --__/
  -- *            \/_/\/_/\/____/\/____/\/____/\/___L\ \/_/ \/___/
  -- *                                           /\____/
  -- *                                           \_/__/
  -- *
  -- *      Fixed point math inline functions (generic C).
  -- *
  -- *      By Shawn Hargreaves.
  -- *
  -- *      See readme.txt for copyright information.
  --  

  -- al_ftofix and al_fixtof are used in generic C versions of al_fixmul and al_fixdiv  
   function al_ftofix (x : double) return allegro5_fixed_h.al_fixed  -- /usr/include/allegro5/inline/fmaths.inl:30
   with Import => True, 
        Convention => C, 
        External_Name => "al_ftofix";

   function al_fixtof (x : allegro5_fixed_h.al_fixed) return double  -- /usr/include/allegro5/inline/fmaths.inl:46
   with Import => True, 
        Convention => C, 
        External_Name => "al_fixtof";

   function al_fixadd (x : allegro5_fixed_h.al_fixed; y : allegro5_fixed_h.al_fixed) return allegro5_fixed_h.al_fixed  -- /usr/include/allegro5/inline/fmaths.inl:52
   with Import => True, 
        Convention => C, 
        External_Name => "al_fixadd";

   function al_fixsub (x : allegro5_fixed_h.al_fixed; y : allegro5_fixed_h.al_fixed) return allegro5_fixed_h.al_fixed  -- /usr/include/allegro5/inline/fmaths.inl:75
   with Import => True, 
        Convention => C, 
        External_Name => "al_fixsub";

  -- In benchmarks conducted circa May 2005 we found that, in the main:
  -- * - IA32 machines performed faster with one implementation;
  -- * - AMD64 and G4 machines performed faster with another implementation.
  -- *
  -- * Benchmarks were mainly done with differing versions of gcc.
  -- * Results varied with other compilers, optimisation levels, etc.
  -- * so this is not optimal, though a tenable compromise.
  -- *
  -- * Note that the following implementation are NOT what were benchmarked.
  -- * We had forgotten to put in overflow detection in those versions.
  -- * If you don't need overflow detection then previous versions in the
  -- * CVS tree might be worth looking at.
  -- *
  -- * PS. Don't move the #ifs inside the AL_INLINE; BCC doesn't like it.
  --  

   function al_fixmul (x : allegro5_fixed_h.al_fixed; y : allegro5_fixed_h.al_fixed) return allegro5_fixed_h.al_fixed  -- /usr/include/allegro5/inline/fmaths.inl:119
   with Import => True, 
        Convention => C, 
        External_Name => "al_fixmul";

   function al_fixdiv (x : allegro5_fixed_h.al_fixed; y : allegro5_fixed_h.al_fixed) return allegro5_fixed_h.al_fixed  -- /usr/include/allegro5/inline/fmaths.inl:163
   with Import => True, 
        Convention => C, 
        External_Name => "al_fixdiv";

   function al_fixfloor (x : allegro5_fixed_h.al_fixed) return int  -- /usr/include/allegro5/inline/fmaths.inl:175
   with Import => True, 
        Convention => C, 
        External_Name => "al_fixfloor";

  -- (x >> 16) is not portable  
   function al_fixceil (x : allegro5_fixed_h.al_fixed) return int  -- /usr/include/allegro5/inline/fmaths.inl:185
   with Import => True, 
        Convention => C, 
        External_Name => "al_fixceil";

   function al_itofix (x : int) return allegro5_fixed_h.al_fixed  -- /usr/include/allegro5/inline/fmaths.inl:196
   with Import => True, 
        Convention => C, 
        External_Name => "al_itofix";

   function al_fixtoi (x : allegro5_fixed_h.al_fixed) return int  -- /usr/include/allegro5/inline/fmaths.inl:202
   with Import => True, 
        Convention => C, 
        External_Name => "al_fixtoi";

   function al_fixcos (x : allegro5_fixed_h.al_fixed) return allegro5_fixed_h.al_fixed  -- /usr/include/allegro5/inline/fmaths.inl:208
   with Import => True, 
        Convention => C, 
        External_Name => "al_fixcos";

   function al_fixsin (x : allegro5_fixed_h.al_fixed) return allegro5_fixed_h.al_fixed  -- /usr/include/allegro5/inline/fmaths.inl:214
   with Import => True, 
        Convention => C, 
        External_Name => "al_fixsin";

   function al_fixtan (x : allegro5_fixed_h.al_fixed) return allegro5_fixed_h.al_fixed  -- /usr/include/allegro5/inline/fmaths.inl:220
   with Import => True, 
        Convention => C, 
        External_Name => "al_fixtan";

   function al_fixacos (x : allegro5_fixed_h.al_fixed) return allegro5_fixed_h.al_fixed  -- /usr/include/allegro5/inline/fmaths.inl:226
   with Import => True, 
        Convention => C, 
        External_Name => "al_fixacos";

   function al_fixasin (x : allegro5_fixed_h.al_fixed) return allegro5_fixed_h.al_fixed  -- /usr/include/allegro5/inline/fmaths.inl:237
   with Import => True, 
        Convention => C, 
        External_Name => "al_fixasin";

end allegro5_inline_fmaths_inl;
