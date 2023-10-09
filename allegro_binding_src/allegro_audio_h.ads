pragma Ada_2012;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with System;
with Interfaces.C.Extensions;
with stddef_h;
with x86_64_linux_gnu_bits_stdint_uintn_h;
limited with allegro5_events_h;
with Interfaces.C.Strings;
limited with allegro5_file_h;

package allegro_audio_h is

   --  unsupported macro: ALLEGRO_KCM_AUDIO_FUNC AL_FUNC
   ALLEGRO_MAX_CHANNELS : constant := 8;  --  addons/audio/allegro5/allegro_audio.h:112

   ALLEGRO_AUDIO_PAN_NONE : constant := (-1000.0);  --  addons/audio/allegro5/allegro_audio.h:140

  -- * Updated for 4.9 api inclusion by Ryan Dickie
  -- * Originally done by KC/Milan
  --  

  -- Title: Audio types
  --  

  -- Enum: ALLEGRO_AUDIO_EVENT_TYPE
  --  

   subtype ALLEGRO_AUDIO_EVENT_TYPE is unsigned;
   u_KCM_STREAM_FEEDER_QUIT_EVENT_TYPE : constant unsigned := 512;
   ALLEGRO_EVENT_AUDIO_STREAM_FRAGMENT : constant unsigned := 513;
   ALLEGRO_EVENT_AUDIO_STREAM_FINISHED : constant unsigned := 514;  -- addons/audio/allegro5/allegro_audio.h:43

  -- Internal, used to communicate with acodec.  
  -- Must be in 512 <= n < 1024  
  -- Type: ALLEGRO_AUDIO_RECORDER_EVENT
  --  

  -- Enum: ALLEGRO_AUDIO_DEPTH
  --  

   subtype ALLEGRO_AUDIO_DEPTH is unsigned;
   ALLEGRO_AUDIO_DEPTH_INT8 : constant unsigned := 0;
   ALLEGRO_AUDIO_DEPTH_INT16 : constant unsigned := 1;
   ALLEGRO_AUDIO_DEPTH_INT24 : constant unsigned := 2;
   ALLEGRO_AUDIO_DEPTH_FLOAT32 : constant unsigned := 3;
   ALLEGRO_AUDIO_DEPTH_UNSIGNED : constant unsigned := 8;
   ALLEGRO_AUDIO_DEPTH_UINT8 : constant unsigned := 8;
   ALLEGRO_AUDIO_DEPTH_UINT16 : constant unsigned := 9;
   ALLEGRO_AUDIO_DEPTH_UINT24 : constant unsigned := 10;  -- addons/audio/allegro5/allegro_audio.h:71

  -- Sample depth and type, and signedness. Mixers only use 32-bit signed
  --    * float (-1..+1). The unsigned value is a bit-flag applied to the depth
  --    * value.
  --     

  -- For convenience  
  -- Enum: ALLEGRO_CHANNEL_CONF
  --  

   subtype ALLEGRO_CHANNEL_CONF is unsigned;
   ALLEGRO_CHANNEL_CONF_1 : constant unsigned := 16;
   ALLEGRO_CHANNEL_CONF_2 : constant unsigned := 32;
   ALLEGRO_CHANNEL_CONF_3 : constant unsigned := 48;
   ALLEGRO_CHANNEL_CONF_4 : constant unsigned := 64;
   ALLEGRO_CHANNEL_CONF_5_1 : constant unsigned := 81;
   ALLEGRO_CHANNEL_CONF_6_1 : constant unsigned := 97;
   ALLEGRO_CHANNEL_CONF_7_1 : constant unsigned := 113;  -- addons/audio/allegro5/allegro_audio.h:96

  -- Speaker configuration (mono, stereo, 2.1, 3, etc). With regards to
  --    * behavior, most of this code makes no distinction between, say, 4.1 and
  --    * 5 speaker setups.. they both have 5 "channels". However, users would
  --    * like the distinction, and later when the higher-level stuff is added,
  --    * the differences will become more important. (v>>4)+(v&0xF) should yield
  --    * the total channel count.
  --     

  -- Enum: ALLEGRO_PLAYMODE
  --  

   subtype ALLEGRO_PLAYMODE is unsigned;
   ALLEGRO_PLAYMODE_ONCE : constant unsigned := 256;
   ALLEGRO_PLAYMODE_LOOP : constant unsigned := 257;
   ALLEGRO_PLAYMODE_BIDIR : constant unsigned := 258;
   u_ALLEGRO_PLAYMODE_STREAM_ONCE : constant unsigned := 259;
   u_ALLEGRO_PLAYMODE_STREAM_ONEDIR : constant unsigned := 260;  -- addons/audio/allegro5/allegro_audio.h:118

  -- internal  
  -- internal  
  -- Enum: ALLEGRO_MIXER_QUALITY
  --  

   subtype ALLEGRO_MIXER_QUALITY is unsigned;
   ALLEGRO_MIXER_QUALITY_POINT : constant unsigned := 272;
   ALLEGRO_MIXER_QUALITY_LINEAR : constant unsigned := 273;
   ALLEGRO_MIXER_QUALITY_CUBIC : constant unsigned := 274;  -- addons/audio/allegro5/allegro_audio.h:130

  -- Enum: ALLEGRO_AUDIO_PAN_NONE
  --  

  -- Type: ALLEGRO_SAMPLE
  --  

   type ALLEGRO_SAMPLE is null record;   -- incomplete struct

  -- Type: ALLEGRO_SAMPLE_ID
  --  

   type ALLEGRO_SAMPLE_ID;
   type ALLEGRO_SAMPLE_ID is record
      u_index : aliased int;  -- addons/audio/allegro5/allegro_audio.h:152
      u_id : aliased int;  -- addons/audio/allegro5/allegro_audio.h:153
   end record
   with Convention => C_Pass_By_Copy;  -- addons/audio/allegro5/allegro_audio.h:151

  -- Type: ALLEGRO_SAMPLE_INSTANCE
  --  

   type ALLEGRO_SAMPLE_INSTANCE is null record;   -- incomplete struct

  -- Type: ALLEGRO_AUDIO_STREAM
  --  

   type ALLEGRO_AUDIO_STREAM is null record;   -- incomplete struct

  -- Type: ALLEGRO_MIXER
  --  

   type ALLEGRO_MIXER is null record;   -- incomplete struct

  -- Type: ALLEGRO_VOICE
  --  

   type ALLEGRO_VOICE is null record;   -- incomplete struct

  -- Type: ALLEGRO_AUDIO_RECORDER
  --  

  -- Sample functions  
   function al_create_sample
     (buf : System.Address;
      samples : unsigned;
      freq : unsigned;
      depth : ALLEGRO_AUDIO_DEPTH;
      chan_conf : ALLEGRO_CHANNEL_CONF;
      free_buf : Extensions.bool) return access ALLEGRO_SAMPLE  -- addons/audio/allegro5/allegro_audio.h:194
   with Import => True, 
        Convention => C, 
        External_Name => "al_create_sample";

   procedure al_destroy_sample (spl : access ALLEGRO_SAMPLE)  -- addons/audio/allegro5/allegro_audio.h:197
   with Import => True, 
        Convention => C, 
        External_Name => "al_destroy_sample";

  -- Sample instance functions  
   function al_create_sample_instance (data : access ALLEGRO_SAMPLE) return access ALLEGRO_SAMPLE_INSTANCE  -- addons/audio/allegro5/allegro_audio.h:201
   with Import => True, 
        Convention => C, 
        External_Name => "al_create_sample_instance";

   procedure al_destroy_sample_instance (spl : access ALLEGRO_SAMPLE_INSTANCE)  -- addons/audio/allegro5/allegro_audio.h:203
   with Import => True, 
        Convention => C, 
        External_Name => "al_destroy_sample_instance";

   function al_get_sample_frequency (spl : access constant ALLEGRO_SAMPLE) return unsigned  -- addons/audio/allegro5/allegro_audio.h:206
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_sample_frequency";

   function al_get_sample_length (spl : access constant ALLEGRO_SAMPLE) return unsigned  -- addons/audio/allegro5/allegro_audio.h:207
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_sample_length";

   function al_get_sample_depth (spl : access constant ALLEGRO_SAMPLE) return ALLEGRO_AUDIO_DEPTH  -- addons/audio/allegro5/allegro_audio.h:208
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_sample_depth";

   function al_get_sample_channels (spl : access constant ALLEGRO_SAMPLE) return ALLEGRO_CHANNEL_CONF  -- addons/audio/allegro5/allegro_audio.h:209
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_sample_channels";

   function al_get_sample_data (spl : access constant ALLEGRO_SAMPLE) return System.Address  -- addons/audio/allegro5/allegro_audio.h:210
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_sample_data";

   function al_get_sample_instance_frequency (spl : access constant ALLEGRO_SAMPLE_INSTANCE) return unsigned  -- addons/audio/allegro5/allegro_audio.h:212
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_sample_instance_frequency";

   function al_get_sample_instance_length (spl : access constant ALLEGRO_SAMPLE_INSTANCE) return unsigned  -- addons/audio/allegro5/allegro_audio.h:213
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_sample_instance_length";

   function al_get_sample_instance_position (spl : access constant ALLEGRO_SAMPLE_INSTANCE) return unsigned  -- addons/audio/allegro5/allegro_audio.h:214
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_sample_instance_position";

   function al_get_sample_instance_speed (spl : access constant ALLEGRO_SAMPLE_INSTANCE) return float  -- addons/audio/allegro5/allegro_audio.h:216
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_sample_instance_speed";

   function al_get_sample_instance_gain (spl : access constant ALLEGRO_SAMPLE_INSTANCE) return float  -- addons/audio/allegro5/allegro_audio.h:217
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_sample_instance_gain";

   function al_get_sample_instance_pan (spl : access constant ALLEGRO_SAMPLE_INSTANCE) return float  -- addons/audio/allegro5/allegro_audio.h:218
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_sample_instance_pan";

   function al_get_sample_instance_time (spl : access constant ALLEGRO_SAMPLE_INSTANCE) return float  -- addons/audio/allegro5/allegro_audio.h:219
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_sample_instance_time";

   function al_get_sample_instance_depth (spl : access constant ALLEGRO_SAMPLE_INSTANCE) return ALLEGRO_AUDIO_DEPTH  -- addons/audio/allegro5/allegro_audio.h:221
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_sample_instance_depth";

   function al_get_sample_instance_channels (spl : access constant ALLEGRO_SAMPLE_INSTANCE) return ALLEGRO_CHANNEL_CONF  -- addons/audio/allegro5/allegro_audio.h:222
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_sample_instance_channels";

   function al_get_sample_instance_playmode (spl : access constant ALLEGRO_SAMPLE_INSTANCE) return ALLEGRO_PLAYMODE  -- addons/audio/allegro5/allegro_audio.h:223
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_sample_instance_playmode";

   function al_get_sample_instance_playing (spl : access constant ALLEGRO_SAMPLE_INSTANCE) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:225
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_sample_instance_playing";

   function al_get_sample_instance_attached (spl : access constant ALLEGRO_SAMPLE_INSTANCE) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:226
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_sample_instance_attached";

   function al_set_sample_instance_position (spl : access ALLEGRO_SAMPLE_INSTANCE; val : unsigned) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:228
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_sample_instance_position";

   function al_set_sample_instance_length (spl : access ALLEGRO_SAMPLE_INSTANCE; val : unsigned) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:229
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_sample_instance_length";

   function al_set_sample_instance_speed (spl : access ALLEGRO_SAMPLE_INSTANCE; val : float) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:231
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_sample_instance_speed";

   function al_set_sample_instance_gain (spl : access ALLEGRO_SAMPLE_INSTANCE; val : float) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:232
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_sample_instance_gain";

   function al_set_sample_instance_pan (spl : access ALLEGRO_SAMPLE_INSTANCE; val : float) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:233
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_sample_instance_pan";

   function al_set_sample_instance_playmode (spl : access ALLEGRO_SAMPLE_INSTANCE; val : ALLEGRO_PLAYMODE) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:235
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_sample_instance_playmode";

   function al_set_sample_instance_playing (spl : access ALLEGRO_SAMPLE_INSTANCE; val : Extensions.bool) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:237
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_sample_instance_playing";

   function al_detach_sample_instance (spl : access ALLEGRO_SAMPLE_INSTANCE) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:238
   with Import => True, 
        Convention => C, 
        External_Name => "al_detach_sample_instance";

   function al_set_sample (spl : access ALLEGRO_SAMPLE_INSTANCE; data : access ALLEGRO_SAMPLE) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:240
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_sample";

   function al_get_sample (spl : access ALLEGRO_SAMPLE_INSTANCE) return access ALLEGRO_SAMPLE  -- addons/audio/allegro5/allegro_audio.h:241
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_sample";

   function al_play_sample_instance (spl : access ALLEGRO_SAMPLE_INSTANCE) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:242
   with Import => True, 
        Convention => C, 
        External_Name => "al_play_sample_instance";

   function al_stop_sample_instance (spl : access ALLEGRO_SAMPLE_INSTANCE) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:243
   with Import => True, 
        Convention => C, 
        External_Name => "al_stop_sample_instance";

  -- Stream functions  
   function al_create_audio_stream
     (buffer_count : stddef_h.size_t;
      samples : unsigned;
      freq : unsigned;
      depth : ALLEGRO_AUDIO_DEPTH;
      chan_conf : ALLEGRO_CHANNEL_CONF) return access ALLEGRO_AUDIO_STREAM  -- addons/audio/allegro5/allegro_audio.h:250
   with Import => True, 
        Convention => C, 
        External_Name => "al_create_audio_stream";

   procedure al_destroy_audio_stream (stream : access ALLEGRO_AUDIO_STREAM)  -- addons/audio/allegro5/allegro_audio.h:253
   with Import => True, 
        Convention => C, 
        External_Name => "al_destroy_audio_stream";

   procedure al_drain_audio_stream (stream : access ALLEGRO_AUDIO_STREAM)  -- addons/audio/allegro5/allegro_audio.h:254
   with Import => True, 
        Convention => C, 
        External_Name => "al_drain_audio_stream";

   function al_get_audio_stream_frequency (stream : access constant ALLEGRO_AUDIO_STREAM) return unsigned  -- addons/audio/allegro5/allegro_audio.h:256
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_audio_stream_frequency";

   function al_get_audio_stream_length (stream : access constant ALLEGRO_AUDIO_STREAM) return unsigned  -- addons/audio/allegro5/allegro_audio.h:257
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_audio_stream_length";

   function al_get_audio_stream_fragments (stream : access constant ALLEGRO_AUDIO_STREAM) return unsigned  -- addons/audio/allegro5/allegro_audio.h:258
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_audio_stream_fragments";

   function al_get_available_audio_stream_fragments (stream : access constant ALLEGRO_AUDIO_STREAM) return unsigned  -- addons/audio/allegro5/allegro_audio.h:259
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_available_audio_stream_fragments";

   function al_get_audio_stream_speed (stream : access constant ALLEGRO_AUDIO_STREAM) return float  -- addons/audio/allegro5/allegro_audio.h:261
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_audio_stream_speed";

   function al_get_audio_stream_gain (stream : access constant ALLEGRO_AUDIO_STREAM) return float  -- addons/audio/allegro5/allegro_audio.h:262
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_audio_stream_gain";

   function al_get_audio_stream_pan (stream : access constant ALLEGRO_AUDIO_STREAM) return float  -- addons/audio/allegro5/allegro_audio.h:263
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_audio_stream_pan";

   function al_get_audio_stream_channels (stream : access constant ALLEGRO_AUDIO_STREAM) return ALLEGRO_CHANNEL_CONF  -- addons/audio/allegro5/allegro_audio.h:265
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_audio_stream_channels";

   function al_get_audio_stream_depth (stream : access constant ALLEGRO_AUDIO_STREAM) return ALLEGRO_AUDIO_DEPTH  -- addons/audio/allegro5/allegro_audio.h:266
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_audio_stream_depth";

   function al_get_audio_stream_playmode (stream : access constant ALLEGRO_AUDIO_STREAM) return ALLEGRO_PLAYMODE  -- addons/audio/allegro5/allegro_audio.h:267
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_audio_stream_playmode";

   function al_get_audio_stream_playing (spl : access constant ALLEGRO_AUDIO_STREAM) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:269
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_audio_stream_playing";

   function al_get_audio_stream_attached (spl : access constant ALLEGRO_AUDIO_STREAM) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:270
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_audio_stream_attached";

   function al_get_audio_stream_played_samples (stream : access constant ALLEGRO_AUDIO_STREAM) return x86_64_linux_gnu_bits_stdint_uintn_h.uint64_t  -- addons/audio/allegro5/allegro_audio.h:271
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_audio_stream_played_samples";

   function al_get_audio_stream_fragment (stream : access constant ALLEGRO_AUDIO_STREAM) return System.Address  -- addons/audio/allegro5/allegro_audio.h:273
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_audio_stream_fragment";

   function al_set_audio_stream_speed (stream : access ALLEGRO_AUDIO_STREAM; val : float) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:275
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_audio_stream_speed";

   function al_set_audio_stream_gain (stream : access ALLEGRO_AUDIO_STREAM; val : float) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:276
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_audio_stream_gain";

   function al_set_audio_stream_pan (stream : access ALLEGRO_AUDIO_STREAM; val : float) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:277
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_audio_stream_pan";

   function al_set_audio_stream_playmode (stream : access ALLEGRO_AUDIO_STREAM; val : ALLEGRO_PLAYMODE) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:279
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_audio_stream_playmode";

   function al_set_audio_stream_playing (stream : access ALLEGRO_AUDIO_STREAM; val : Extensions.bool) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:281
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_audio_stream_playing";

   function al_detach_audio_stream (stream : access ALLEGRO_AUDIO_STREAM) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:282
   with Import => True, 
        Convention => C, 
        External_Name => "al_detach_audio_stream";

   function al_set_audio_stream_fragment (stream : access ALLEGRO_AUDIO_STREAM; val : System.Address) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:283
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_audio_stream_fragment";

   function al_rewind_audio_stream (stream : access ALLEGRO_AUDIO_STREAM) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:285
   with Import => True, 
        Convention => C, 
        External_Name => "al_rewind_audio_stream";

   function al_seek_audio_stream_secs (stream : access ALLEGRO_AUDIO_STREAM; time : double) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:286
   with Import => True, 
        Convention => C, 
        External_Name => "al_seek_audio_stream_secs";

   function al_get_audio_stream_position_secs (stream : access ALLEGRO_AUDIO_STREAM) return double  -- addons/audio/allegro5/allegro_audio.h:287
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_audio_stream_position_secs";

   function al_get_audio_stream_length_secs (stream : access ALLEGRO_AUDIO_STREAM) return double  -- addons/audio/allegro5/allegro_audio.h:288
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_audio_stream_length_secs";

   function al_set_audio_stream_loop_secs
     (stream : access ALLEGRO_AUDIO_STREAM;
      start : double;
      c_end : double) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:289
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_audio_stream_loop_secs";

   function al_get_audio_stream_event_source (stream : access ALLEGRO_AUDIO_STREAM) return access allegro5_events_h.ALLEGRO_EVENT_SOURCE  -- addons/audio/allegro5/allegro_audio.h:291
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_audio_stream_event_source";

  -- Mixer functions  
   function al_create_mixer
     (freq : unsigned;
      depth : ALLEGRO_AUDIO_DEPTH;
      chan_conf : ALLEGRO_CHANNEL_CONF) return access ALLEGRO_MIXER  -- addons/audio/allegro5/allegro_audio.h:298
   with Import => True, 
        Convention => C, 
        External_Name => "al_create_mixer";

   procedure al_destroy_mixer (mixer : access ALLEGRO_MIXER)  -- addons/audio/allegro5/allegro_audio.h:300
   with Import => True, 
        Convention => C, 
        External_Name => "al_destroy_mixer";

   function al_attach_sample_instance_to_mixer (stream : access ALLEGRO_SAMPLE_INSTANCE; mixer : access ALLEGRO_MIXER) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:301
   with Import => True, 
        Convention => C, 
        External_Name => "al_attach_sample_instance_to_mixer";

   function al_attach_audio_stream_to_mixer (stream : access ALLEGRO_AUDIO_STREAM; mixer : access ALLEGRO_MIXER) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:303
   with Import => True, 
        Convention => C, 
        External_Name => "al_attach_audio_stream_to_mixer";

   function al_attach_mixer_to_mixer (stream : access ALLEGRO_MIXER; mixer : access ALLEGRO_MIXER) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:305
   with Import => True, 
        Convention => C, 
        External_Name => "al_attach_mixer_to_mixer";

   function al_set_mixer_postprocess_callback
     (mixer : access ALLEGRO_MIXER;
      cb : access procedure
        (arg1 : System.Address;
         arg2 : unsigned;
         arg3 : System.Address);
      data : System.Address) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:307
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_mixer_postprocess_callback";

   function al_get_mixer_frequency (mixer : access constant ALLEGRO_MIXER) return unsigned  -- addons/audio/allegro5/allegro_audio.h:312
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_mixer_frequency";

   function al_get_mixer_channels (mixer : access constant ALLEGRO_MIXER) return ALLEGRO_CHANNEL_CONF  -- addons/audio/allegro5/allegro_audio.h:313
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_mixer_channels";

   function al_get_mixer_depth (mixer : access constant ALLEGRO_MIXER) return ALLEGRO_AUDIO_DEPTH  -- addons/audio/allegro5/allegro_audio.h:314
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_mixer_depth";

   function al_get_mixer_quality (mixer : access constant ALLEGRO_MIXER) return ALLEGRO_MIXER_QUALITY  -- addons/audio/allegro5/allegro_audio.h:315
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_mixer_quality";

   function al_get_mixer_gain (mixer : access constant ALLEGRO_MIXER) return float  -- addons/audio/allegro5/allegro_audio.h:316
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_mixer_gain";

   function al_get_mixer_playing (mixer : access constant ALLEGRO_MIXER) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:317
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_mixer_playing";

   function al_get_mixer_attached (mixer : access constant ALLEGRO_MIXER) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:318
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_mixer_attached";

   function al_set_mixer_frequency (mixer : access ALLEGRO_MIXER; val : unsigned) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:319
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_mixer_frequency";

   function al_set_mixer_quality (mixer : access ALLEGRO_MIXER; val : ALLEGRO_MIXER_QUALITY) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:320
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_mixer_quality";

   function al_set_mixer_gain (mixer : access ALLEGRO_MIXER; gain : float) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:321
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_mixer_gain";

   function al_set_mixer_playing (mixer : access ALLEGRO_MIXER; val : Extensions.bool) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:322
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_mixer_playing";

   function al_detach_mixer (mixer : access ALLEGRO_MIXER) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:323
   with Import => True, 
        Convention => C, 
        External_Name => "al_detach_mixer";

  -- Voice functions  
   function al_create_voice
     (freq : unsigned;
      depth : ALLEGRO_AUDIO_DEPTH;
      chan_conf : ALLEGRO_CHANNEL_CONF) return access ALLEGRO_VOICE  -- addons/audio/allegro5/allegro_audio.h:326
   with Import => True, 
        Convention => C, 
        External_Name => "al_create_voice";

   procedure al_destroy_voice (voice : access ALLEGRO_VOICE)  -- addons/audio/allegro5/allegro_audio.h:329
   with Import => True, 
        Convention => C, 
        External_Name => "al_destroy_voice";

   function al_attach_sample_instance_to_voice (stream : access ALLEGRO_SAMPLE_INSTANCE; voice : access ALLEGRO_VOICE) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:330
   with Import => True, 
        Convention => C, 
        External_Name => "al_attach_sample_instance_to_voice";

   function al_attach_audio_stream_to_voice (stream : access ALLEGRO_AUDIO_STREAM; voice : access ALLEGRO_VOICE) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:332
   with Import => True, 
        Convention => C, 
        External_Name => "al_attach_audio_stream_to_voice";

   function al_attach_mixer_to_voice (mixer : access ALLEGRO_MIXER; voice : access ALLEGRO_VOICE) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:334
   with Import => True, 
        Convention => C, 
        External_Name => "al_attach_mixer_to_voice";

   procedure al_detach_voice (voice : access ALLEGRO_VOICE)  -- addons/audio/allegro5/allegro_audio.h:336
   with Import => True, 
        Convention => C, 
        External_Name => "al_detach_voice";

   function al_get_voice_frequency (voice : access constant ALLEGRO_VOICE) return unsigned  -- addons/audio/allegro5/allegro_audio.h:338
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_voice_frequency";

   function al_get_voice_position (voice : access constant ALLEGRO_VOICE) return unsigned  -- addons/audio/allegro5/allegro_audio.h:339
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_voice_position";

   function al_get_voice_channels (voice : access constant ALLEGRO_VOICE) return ALLEGRO_CHANNEL_CONF  -- addons/audio/allegro5/allegro_audio.h:340
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_voice_channels";

   function al_get_voice_depth (voice : access constant ALLEGRO_VOICE) return ALLEGRO_AUDIO_DEPTH  -- addons/audio/allegro5/allegro_audio.h:341
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_voice_depth";

   function al_get_voice_playing (voice : access constant ALLEGRO_VOICE) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:342
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_voice_playing";

   function al_set_voice_position (voice : access ALLEGRO_VOICE; val : unsigned) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:343
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_voice_position";

   function al_set_voice_playing (voice : access ALLEGRO_VOICE; val : Extensions.bool) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:344
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_voice_playing";

  -- Misc. audio functions  
   function al_install_audio return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:347
   with Import => True, 
        Convention => C, 
        External_Name => "al_install_audio";

   procedure al_uninstall_audio  -- addons/audio/allegro5/allegro_audio.h:348
   with Import => True, 
        Convention => C, 
        External_Name => "al_uninstall_audio";

   function al_is_audio_installed return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:349
   with Import => True, 
        Convention => C, 
        External_Name => "al_is_audio_installed";

   function al_get_allegro_audio_version return x86_64_linux_gnu_bits_stdint_uintn_h.uint32_t  -- addons/audio/allegro5/allegro_audio.h:350
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_allegro_audio_version";

   function al_get_channel_count (conf : ALLEGRO_CHANNEL_CONF) return stddef_h.size_t  -- addons/audio/allegro5/allegro_audio.h:352
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_channel_count";

   function al_get_audio_depth_size (conf : ALLEGRO_AUDIO_DEPTH) return stddef_h.size_t  -- addons/audio/allegro5/allegro_audio.h:353
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_audio_depth_size";

   procedure al_fill_silence
     (buf : System.Address;
      samples : unsigned;
      depth : ALLEGRO_AUDIO_DEPTH;
      chan_conf : ALLEGRO_CHANNEL_CONF)  -- addons/audio/allegro5/allegro_audio.h:355
   with Import => True, 
        Convention => C, 
        External_Name => "al_fill_silence";

  -- Simple audio layer  
   function al_reserve_samples (reserve_samples : int) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:359
   with Import => True, 
        Convention => C, 
        External_Name => "al_reserve_samples";

   function al_get_default_mixer return access ALLEGRO_MIXER  -- addons/audio/allegro5/allegro_audio.h:360
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_default_mixer";

   function al_set_default_mixer (mixer : access ALLEGRO_MIXER) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:361
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_default_mixer";

   function al_restore_default_mixer return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:362
   with Import => True, 
        Convention => C, 
        External_Name => "al_restore_default_mixer";

   function al_play_sample
     (data : access ALLEGRO_SAMPLE;
      gain : float;
      pan : float;
      speed : float;
      c_loop : ALLEGRO_PLAYMODE;
      ret_id : access ALLEGRO_SAMPLE_ID) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:363
   with Import => True, 
        Convention => C, 
        External_Name => "al_play_sample";

   procedure al_stop_sample (spl_id : access ALLEGRO_SAMPLE_ID)  -- addons/audio/allegro5/allegro_audio.h:365
   with Import => True, 
        Convention => C, 
        External_Name => "al_stop_sample";

   procedure al_stop_samples  -- addons/audio/allegro5/allegro_audio.h:366
   with Import => True, 
        Convention => C, 
        External_Name => "al_stop_samples";

   function al_get_default_voice return access ALLEGRO_VOICE  -- addons/audio/allegro5/allegro_audio.h:367
   with Import => True, 
        Convention => C, 
        External_Name => "al_get_default_voice";

   procedure al_set_default_voice (voice : access ALLEGRO_VOICE)  -- addons/audio/allegro5/allegro_audio.h:368
   with Import => True, 
        Convention => C, 
        External_Name => "al_set_default_voice";

  -- File type handlers  
   function al_register_sample_loader (ext : Interfaces.C.Strings.chars_ptr; loader : access function (arg1 : Interfaces.C.Strings.chars_ptr) return access ALLEGRO_SAMPLE) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:376
   with Import => True, 
        Convention => C, 
        External_Name => "al_register_sample_loader";

   function al_register_sample_saver (ext : Interfaces.C.Strings.chars_ptr; saver : access function (arg1 : Interfaces.C.Strings.chars_ptr; arg2 : access ALLEGRO_SAMPLE) return Extensions.bool) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:378
   with Import => True, 
        Convention => C, 
        External_Name => "al_register_sample_saver";

   function al_register_audio_stream_loader (ext : Interfaces.C.Strings.chars_ptr; stream_loader : access function
        (arg1 : Interfaces.C.Strings.chars_ptr;
         arg2 : stddef_h.size_t;
         arg3 : unsigned) return access ALLEGRO_AUDIO_STREAM) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:380
   with Import => True, 
        Convention => C, 
        External_Name => "al_register_audio_stream_loader";

   function al_register_sample_loader_f (ext : Interfaces.C.Strings.chars_ptr; loader : access function (arg1 : access allegro5_file_h.ALLEGRO_FILE) return access ALLEGRO_SAMPLE) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:384
   with Import => True, 
        Convention => C, 
        External_Name => "al_register_sample_loader_f";

   function al_register_sample_saver_f (ext : Interfaces.C.Strings.chars_ptr; saver : access function (arg1 : access allegro5_file_h.ALLEGRO_FILE; arg2 : access ALLEGRO_SAMPLE) return Extensions.bool) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:386
   with Import => True, 
        Convention => C, 
        External_Name => "al_register_sample_saver_f";

   function al_register_audio_stream_loader_f (ext : Interfaces.C.Strings.chars_ptr; stream_loader : access function
        (arg1 : access allegro5_file_h.ALLEGRO_FILE;
         arg2 : stddef_h.size_t;
         arg3 : unsigned) return access ALLEGRO_AUDIO_STREAM) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:388
   with Import => True, 
        Convention => C, 
        External_Name => "al_register_audio_stream_loader_f";

   function al_load_sample (filename : Interfaces.C.Strings.chars_ptr) return access ALLEGRO_SAMPLE  -- addons/audio/allegro5/allegro_audio.h:392
   with Import => True, 
        Convention => C, 
        External_Name => "al_load_sample";

   function al_save_sample (filename : Interfaces.C.Strings.chars_ptr; spl : access ALLEGRO_SAMPLE) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:393
   with Import => True, 
        Convention => C, 
        External_Name => "al_save_sample";

   function al_load_audio_stream
     (filename : Interfaces.C.Strings.chars_ptr;
      buffer_count : stddef_h.size_t;
      samples : unsigned) return access ALLEGRO_AUDIO_STREAM  -- addons/audio/allegro5/allegro_audio.h:395
   with Import => True, 
        Convention => C, 
        External_Name => "al_load_audio_stream";

   function al_load_sample_f (fp : access allegro5_file_h.ALLEGRO_FILE; ident : Interfaces.C.Strings.chars_ptr) return access ALLEGRO_SAMPLE  -- addons/audio/allegro5/allegro_audio.h:398
   with Import => True, 
        Convention => C, 
        External_Name => "al_load_sample_f";

   function al_save_sample_f
     (fp : access allegro5_file_h.ALLEGRO_FILE;
      ident : Interfaces.C.Strings.chars_ptr;
      spl : access ALLEGRO_SAMPLE) return Extensions.bool  -- addons/audio/allegro5/allegro_audio.h:399
   with Import => True, 
        Convention => C, 
        External_Name => "al_save_sample_f";

   function al_load_audio_stream_f
     (fp : access allegro5_file_h.ALLEGRO_FILE;
      ident : Interfaces.C.Strings.chars_ptr;
      buffer_count : stddef_h.size_t;
      samples : unsigned) return access ALLEGRO_AUDIO_STREAM  -- addons/audio/allegro5/allegro_audio.h:401
   with Import => True, 
        Convention => C, 
        External_Name => "al_load_audio_stream_f";

  -- Recording functions  
  -- End extern "C"  
  -- vim: set sts=3 sw=3 et:  
end allegro_audio_h;
