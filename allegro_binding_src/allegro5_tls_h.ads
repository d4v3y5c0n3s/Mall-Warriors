pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;

package allegro5_tls_h is

  --         ______   ___    ___
  -- *        /\  _  \ /\_ \  /\_  *        \ \ \L\ \\//\ \ \//\ \      __     __   _ __   ___
  --_
  -- *         \ \  __ \ \ \ \  \ \ \   /'__`\ /'_ `\/\`'__\/ __` *          \ \ \/\ \ \_\ \_ \_\ \_/\  __//\ \L\ \ \ \//\ \L\  *           \ \_\ \_\/\____\/\____\ \____\ \____ \ \_\\ \____/
  --__/
  -- *            \/_/\/_/\/____/\/____/\/____/\/___L\ \/_/ \/___/
  -- *                                           /\____/
  -- *                                           \_/__/
  -- *
  -- *      Thread local storage routines.
  -- *
  -- *      See readme.txt for copyright information.
  --  

  -- Enum: ALLEGRO_STATE_FLAGS
  --  

   subtype ALLEGRO_STATE_FLAGS is unsigned;
   ALLEGRO_STATE_NEW_DISPLAY_PARAMETERS : constant unsigned := 1;
   ALLEGRO_STATE_NEW_BITMAP_PARAMETERS : constant unsigned := 2;
   ALLEGRO_STATE_DISPLAY : constant unsigned := 4;
   ALLEGRO_STATE_TARGET_BITMAP : constant unsigned := 8;
   ALLEGRO_STATE_BLENDER : constant unsigned := 16;
   ALLEGRO_STATE_NEW_FILE_INTERFACE : constant unsigned := 32;
   ALLEGRO_STATE_TRANSFORM : constant unsigned := 64;
   ALLEGRO_STATE_PROJECTION_TRANSFORM : constant unsigned := 256;
   ALLEGRO_STATE_BITMAP : constant unsigned := 10;
   ALLEGRO_STATE_ALL : constant unsigned := 65535;  -- /usr/include/allegro5/tls.h:28

  -- Type: ALLEGRO_STATE
  --  

   type ALLEGRO_STATE;
  -- Internally, a thread_local_state structure is placed here.  
   subtype anon2461_array2464 is Interfaces.C.char_array (0 .. 1023);
   type ALLEGRO_STATE is record
      u_tls : aliased anon2461_array2464;  -- /usr/include/allegro5/tls.h:54
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/allegro5/tls.h:51

   procedure al_store_state (state : access ALLEGRO_STATE; flags : int)  -- /usr/include/allegro5/tls.h:58
   with Import => True, 
        Convention => C, 
        External_Name => "al_store_state";

   procedure al_restore_state (state : access constant ALLEGRO_STATE)  -- /usr/include/allegro5/tls.h:59
   with Import => True, 
        Convention => C, 
        External_Name => "al_restore_state";

end allegro5_tls_h;
