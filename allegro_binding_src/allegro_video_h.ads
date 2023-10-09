pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;
limited with allegro5_allegro_audio_h;
limited with allegro5_events_h;
with Interfaces.C.Extensions;
limited with allegro5_bitmap_h;
with x86_64_linux_gnu_bits_stdint_uintn_h;

package allegro_video_h is

   --  unsupported macro: ALLEGRO_VIDEO_FUNC AL_FUNC
  -- Enum: ALLEGRO_VIDEO_EVENT_TYPE
  --  

   subtype ALLEGRO_VIDEO_EVENT_TYPE is unsigned;
   ALLEGRO_EVENT_VIDEO_FRAME_SHOW : constant unsigned := 550;
   ALLEGRO_EVENT_VIDEO_FINISHED : constant unsigned := 551;
   u_ALLEGRO_EVENT_VIDEO_SEEK : constant unsigned := 552;  -- addons/video/allegro5/allegro_video.h:35

  -- internal  
   type ALLEGRO_VIDEO_POSITION_TYPE is 
     (ALLEGRO_VIDEO_POSITION_ACTUAL,
      ALLEGRO_VIDEO_POSITION_VIDEO_DECODE,
      ALLEGRO_VIDEO_POSITION_AUDIO_DECODE)
   with Convention => C;  -- addons/video/allegro5/allegro_video.h:42

  -- Enum: ALLEGRO_VIDEO_POSITION_TYPE
  --  

   type ALLEGRO_VIDEO is null record;   -- incomplete struct

   function al_open_video (filename : Interfaces.C.Strings.chars_ptr) return access ALLEGRO_VIDEO  -- addons/video/allegro5/allegro_video.h:55
   with Import => True, 
        Convention => C, 
        External_Name => "al_open_video";

   procedure al_close_video (video : access ALLEGRO_VIDEO)  -- addons/video/allegro5/allegro_video.h:56
   with Import => True, 
        Convention => C, 
        External_Name => "al_close_video";

   procedure al_start_video (video : access ALLEGRO_VIDEO; mixer : access allegro5_allegro_audio_h.ALLEGRO_MIXER)  -- addons/video/allegro5/allegro_video.h:57
   with Import => True, 
        Convention => C, 
        External_Name => "al_start_video";

   procedure al_start_video_with_voice (video : access ALLEGRO_VIDEO; voice : access allegro5_allegro_audio_h.ALLEGRO_VOICE)  -- addons/video/allegro5/allegro_video.h:58
   with Import => True, 
        Convention => C, 
        External_Name => "al_start_video_with_voice";

   function al_get_video_event_source (video : access ALLEGRO_VIDEO) return access allegro5_events_h.ALLEGRO_EVENT_SOURCE  -- addons/video/allegro5/allegro_video.h:59
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_video_event_source";

   procedure al_set_video_playing (video : access ALLEGRO_VIDEO; playing : Extensions.bool)  -- addons/video/allegro5/allegro_video.h:60
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_video_playing";

   function al_is_video_playing (video : access ALLEGRO_VIDEO) return Extensions.bool  -- addons/video/allegro5/allegro_video.h:61
   with Import => True, 
        Convention => C, 
        External_Name => "al_is_video_playing";

   function al_get_video_audio_rate (video : access ALLEGRO_VIDEO) return double  -- addons/video/allegro5/allegro_video.h:62
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_video_audio_rate";

   function al_get_video_fps (video : access ALLEGRO_VIDEO) return double  -- addons/video/allegro5/allegro_video.h:63
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_video_fps";

   function al_get_video_scaled_width (video : access ALLEGRO_VIDEO) return float  -- addons/video/allegro5/allegro_video.h:64
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_video_scaled_width";

   function al_get_video_scaled_height (video : access ALLEGRO_VIDEO) return float  -- addons/video/allegro5/allegro_video.h:65
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_video_scaled_height";

   function al_get_video_frame (video : access ALLEGRO_VIDEO) return access allegro5_bitmap_h.ALLEGRO_BITMAP  -- addons/video/allegro5/allegro_video.h:66
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_video_frame";

   function al_get_video_position (video : access ALLEGRO_VIDEO; which : ALLEGRO_VIDEO_POSITION_TYPE) return double  -- addons/video/allegro5/allegro_video.h:67
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_video_position";

   function al_seek_video (video : access ALLEGRO_VIDEO; pos_in_seconds : double) return Extensions.bool  -- addons/video/allegro5/allegro_video.h:68
   with Import => True, 
        Convention => C, 
        External_Name => "al_seek_video";

   function al_init_video_addon return Extensions.bool  -- addons/video/allegro5/allegro_video.h:69
   with Import => True, 
        Convention => C, 
        External_Name => "al_init_video_addon";

   function al_is_video_addon_initialized return Extensions.bool  -- addons/video/allegro5/allegro_video.h:70
   with Import => True, 
        Convention => C, 
        External_Name => "al_is_video_addon_initialized";

   procedure al_shutdown_video_addon  -- addons/video/allegro5/allegro_video.h:71
   with Import => True, 
        Convention => C, 
        External_Name => "al_shutdown_video_addon";

   function al_get_allegro_video_version return x86_64_linux_gnu_bits_stdint_uintn_h.uint32_t  -- addons/video/allegro5/allegro_video.h:72
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_allegro_video_version";

end allegro_video_h;
