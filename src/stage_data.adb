with Interfaces.C.Strings; use Interfaces.C.Strings;

package body Stage_Data is
  
  function Load_Stage (S : Stage_Options) return Stage_Assets is
    bitmap_path : access String;
    music_path : access String;
    stage : Stage_Assets;
    playmode_success : Boolean;
    mixer_attach_success : Boolean;
  begin
    case S is
      when Test1 =>
        bitmap_path := new String'("assets/colorful_stage.png");
        music_path := new String'("assets/test_music.ogg");
      when Test2 =>
        bitmap_path := new String'("");
        music_path := new String'("");
    end case;
    
    stage.background := al_load_bitmap(New_String(bitmap_path.all));
    stage.music := al_load_audio_stream(New_String(music_path.all), 2, 2048);
    playmode_success := Boolean(al_set_audio_stream_playmode(stage.music, ALLEGRO_PLAYMODE_LOOP));
    mixer_attach_success := Boolean(al_attach_audio_stream_to_mixer(stage.music, al_get_default_mixer));
    
    return stage;
  end Load_Stage;
  
  function Stage_Name (S : Stage_Options) return String is
  begin
    return S'Image;
  end Stage_Name;
  
  function Stage_Icon (S : Stage_Options) return access ALLEGRO_BITMAP is
  begin
    return al_load_bitmap(New_String("assets/temp_stage_char_icon.png"));
  end Stage_Icon;
end Stage_Data;
