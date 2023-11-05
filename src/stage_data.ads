with allegro_audio_h; use allegro_audio_h;
with allegro5_bitmap_io_h; use allegro5_bitmap_io_h;
with allegro5_bitmap_h; use allegro5_bitmap_h;

package Stage_Data is
  
  type Stage_Options is (Test1, Test2);
  
  type Stage_Assets is record
    background : access ALLEGRO_BITMAP := new ALLEGRO_BITMAP;
    music : access ALLEGRO_AUDIO_STREAM := new ALLEGRO_AUDIO_STREAM;
  end record;
  
  function Load_Stage (S : Stage_Options) return Stage_Assets;
  
end Stage_Data;
