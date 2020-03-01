local gameUI = require ("gameUI")

--[[ Comment to release / Uncomment to TEST
SIMULATION = true
SIMUL_USE_GA = true
DO_NOT_CHECK_LICENSE = true
--]]
PRINT = true

-- GLOBAL
-- images
global_font = "neuropol x free" --native.systemFont
global_txt_easy = "EASY"
global_txt_normal = "NORMAL"
global_txt_hard = "HARD"
global_playstore_url = "https://play.google.com/store/apps/details?id=com.brum.game.JetBomb"

-- START
-- images
start_bg = "resource/graphs/start_bg.png"
start_bg_obj_base = "resource/graphs/start_city.png"
start_bg_obj_base_width = gameUI.width() -- 1900
start_bg_obj_base_height = 550/(1900/start_bg_obj_base_width) -- 550

start_img_obj_back = "resource/graphs/start_meteor.png"
start_img_obj_back_width_scale = 250 / 1000 -- 1000
start_img_obj_back_height_scale = start_img_obj_back_width_scale -- 790
start_img_obj_back_options = {width = 1000, height = 790, sheetContentWidth = 1000, sheetContentHeight = 790, numFrames = 1}
start_img_obj_back_sprite = {name="meteor", start=1, count=1, time=1000}

start_logo_text_obj = "resource/graphs/logo_text.png"
start_logo_text_obj_width = 200 -- 1730
start_logo_text_obj_height = 394/(1730/start_logo_text_obj_width) -- 394

start_logo_jet_obj = "resource/graphs/logo_jet.png"
start_logo_jet_obj_width = 200 -- 865
start_logo_jet_obj_height = 204/(865/start_logo_jet_obj_width) -- 204

start_btn_start = "resource/graphs/start_button.png"
start_btn_start_width = 140 -- 500
start_btn_start_height = 170/(500/start_btn_start_width) -- 170
start_btn_start_text = "Start"
start_btn_start_font = "neuropol x free"
start_btn_start_font_size = 18
start_btn_options = "resource/graphs/options_button.png"
start_btn_options_width = 140 -- 500
start_btn_options_height = 170/(500/start_btn_options_width) -- 170
start_btn_options_text = "Options"
start_btn_options_font = "neuropol x free"
start_btn_options_font_size = 18

main_btn_exit_confirm_title = "Are You Sure?"
main_btn_exit_confirm_text = "Are you sure you want to exit JetBomb."
main_btn_exit_confirm_btn_yes = "Yes"
main_btn_exit_confirm_btn_cancel = "Cancel"

-- audios
start_bg_sound = {android="resource/audio/start.ogg", ios="resource/audio/start.m4a"}
start_bg_sound_options = {loops=-1}
start_btn_start_click = {android="resource/audio/play.wav", ios="resource/audio/play.wav"}
start_btn_options_click = {android="resource/audio/level.wav", ios="resource/audio/level.wav"}

-- OPTIONS
-- images
options_bg = "resource/graphs/options_bg.png"
options_title = "OPTIONS"
options_title_font = "neuropol x free"
options_title_font_size = 30

options_txt_music = "Music"
options_txt_music_font = "neuropol x free"
options_txt_music_font_size = 20
options_txt_effects = "Effects"
options_txt_effects_font = "neuropol x free"
options_txt_effects_font_size = 20
options_txt_vibrate = "Vibration"
options_txt_vibrate_font = "neuropol x free"
options_txt_vibrate_font_size = 20
options_txt_level = "Difficulty"
options_txt_level_font = "neuropol x free"
options_txt_level_font_size = 20

options_btn_music_on = "resource/graphs/on_button.png"
options_btn_music_on_text = "On"
options_btn_music_off = "resource/graphs/off_button.png"
options_btn_music_off_text = "Off"
options_btn_music_width = 55 -- 400
options_btn_music_height = 250/(400/options_btn_music_width)-- 250
options_btn_music_font = "neuropol x free"
options_btn_music_font_size = 18

options_btn_effects_on = options_btn_music_on
options_btn_effects_on_text = options_btn_music_on_text
options_btn_effects_off = options_btn_music_off
options_btn_effects_off_text = options_btn_music_off_text
options_btn_effects_width = options_btn_music_width
options_btn_effects_height = options_btn_music_height
options_btn_effects_font = options_btn_music_font
options_btn_effects_font_size = options_btn_music_font_size

options_btn_vibrate_on = options_btn_music_on
options_btn_vibrate_on_text = options_btn_music_on_text
options_btn_vibrate_off = options_btn_music_off
options_btn_vibrate_off_text = options_btn_music_off_text
options_btn_vibrate_width = options_btn_music_width
options_btn_vibrate_height = options_btn_music_height
options_btn_vibrate_font = options_btn_music_font
options_btn_vibrate_font_size = options_btn_music_font_size

options_btn_level_easy = "resource/graphs/easy_button.png"
options_btn_level_easy_text = "easy"
options_btn_level_easy_font = "neuropol x free"
options_btn_level_easy_font_size = 18
options_btn_level_normal = "resource/graphs/normal_button.png"
options_btn_level_normal_text = "normal"
options_btn_level_normal_font = options_btn_level_easy_font
options_btn_level_normal_font_size = 18
options_btn_level_hard = "resource/graphs/hard_button.png"
options_btn_level_hard_text = "hard"
options_btn_level_hard_font = options_btn_level_easy_font
options_btn_level_hard_font_size = 18
options_btn_level_width = 100 -- 500
options_btn_level_height = 170/(500/options_btn_level_width) -- 170

options_btn_back = "resource/graphs/back_button.png"
options_btn_back_width = 120 -- 500
options_btn_back_height = 170/(500/options_btn_back_width) -- 170
options_btn_back_text = "Back"
options_btn_back_font = "neuropol x free"
options_btn_back_font_size = 14
options_btn_start = "resource/graphs/start_button.png"
options_btn_start_width = 140 -- 500
options_btn_start_height = 170/(500/start_btn_start_width) -- 170
options_btn_start_text = "Start"
options_btn_start_font = "neuropol x free"
options_btn_start_font_size = 18
options_btn_best = "resource/graphs/best_button.png"
options_btn_best_width = 120 -- 500
options_btn_best_height = 170/(500/options_btn_best_width) -- 170
options_btn_best_text = "Top Scores"
options_btn_best_font = "neuropol x free"
options_btn_best_font_size = 12

-- audios
options_bg_sound = {android="resource/audio/start.ogg", ios="resource/audio/start.m4a"}
options_bg_sound_options = {loops=-1}
options_btn_level_click = {android="resource/audio/level.wav", ios="resource/audio/level.wav"}
options_btn_music_click = {android="resource/audio/level.wav", ios="resource/audio/level.wav"}
options_btn_effects_click = {android="resource/audio/level.wav", ios="resource/audio/level.wav"}
options_btn_back_click = {android="resource/audio/menu.wav", ios="resource/audio/menu.wav"}
options_btn_start_click = {android="resource/audio/play.wav", ios="resource/audio/play.wav"}
options_btn_best_click = {android="resource/audio/level.wav", ios="resource/audio/level.wav"}

-- BEST
-- images
best_bg = "resource/graphs/best_bg.png"
best_title = "TOP SCORES"
best_title_font = "neuropol x free"
best_title_font_size = 30

best_txt_easy = global_txt_easy
best_txt_easy_font = "neuropol x free"
best_txt_easy_font_size = 20
best_txt_normal = global_txt_normal
best_txt_normal_font = "neuropol x free"
best_txt_normal_font_size = 20
best_txt_hard = global_txt_hard
best_txt_hard_font = "neuropol x free"
best_txt_hard_font_size = 20

best_txt_val_easy_font = "neuropol x free"
best_txt_val_easy_font_size = 20
best_txt_val_normal_font = "neuropol x free"
best_txt_val_normal_font_size = 20
best_txt_val_hard_font = "neuropol x free"
best_txt_val_hard_font_size = 20

best_btn_share = "resource/graphs/share_button.png"
best_btn_share_width = 30 -- 460
best_btn_share_height = 460/(460/best_btn_share_width) -- 460

best_btn_back = "resource/graphs/back_button.png"
best_btn_back_width = 120 -- 500
best_btn_back_height = 170/(500/best_btn_back_width) -- 170
best_btn_back_text = "Back"
best_btn_back_font = "neuropol x free"
best_btn_back_font_size = 14
best_btn_start = "resource/graphs/start_button.png"
best_btn_start_width = 140 -- 500
best_btn_start_height = 170/(500/best_btn_start_width) -- 170
best_btn_start_text = "Start"
best_btn_start_font = "neuropol x free"
best_btn_start_font_size = 18
best_btn_clear = "resource/graphs/clear_button.png"
best_btn_clear_width = 120 -- 500
best_btn_clear_height = 170/(500/best_btn_clear_width) -- 170
best_btn_clear_text = "Clear Scores"
best_btn_clear_font = "neuropol x free"
best_btn_clear_font_size = 12

best_btn_clear_confirm_title = "Are You Sure?"
best_btn_clear_confirm_text = "All top scores will be cleared."
best_btn_clear_confirm_btn_yes = "Yes"
best_btn_clear_confirm_btn_cancel = "Cancel"

-- audios
best_bg_sound = {android="resource/audio/start.ogg", ios="resource/audio/start.m4a"}
best_bg_sound_options = {loops=-1}
best_btn_back_click = {android="resource/audio/level.wav", ios="resource/audio/level.wav"}
best_btn_start_click = {android="resource/audio/play.wav", ios="resource/audio/play.wav"}
best_btn_clear_click = {android="resource/audio/level.wav", ios="resource/audio/level.wav"}

-- GAME
-- images
game_bg = "resource/graphs/game_bg.png"
game_bg_obj1 = "resource/graphs/game_city1.png"
game_bg_obj1_width = gameUI.width() + 2 -- 580
game_bg_obj1_height = 228/(580/game_bg_obj1_width) -- 228
game_bg_obj2 = "resource/graphs/game_city2.png"
game_bg_obj2_width = gameUI.width() + 2 -- 580
game_bg_obj2_height = 102/(580/game_bg_obj2_width) -- 102
game_txt_score = "Score: "
game_txt_score_font = "neuropol x free"
game_txt_score_font_size = 25
game_img_pause = "resource/graphs/pause_button.png"
game_img_pause_width = 30 -- 460
game_img_pause_height = 460/(460/game_img_pause_width) -- 460

game_img_jet = "resource/graphs/game_jet.png"
game_img_jet_width = 50 -- 50
game_img_jet_height = 17/(50/game_img_jet_width) -- 17
game_img_jet_width_scale = game_img_jet_width / 50 -- 50
game_img_jet_height_scale = game_img_jet_height / 17 -- 17
game_img_jet_options = {width = 50, height = 17, sheetContentWidth = 200, sheetContentHeight = 17, numFrames = 4}
game_img_jet_sprite = {name="jet", start=1, count=4, time=1000}
game_img_jet_physics_shape = {-game_img_jet_width/5, -game_img_jet_height/2,
							   game_img_jet_width/2,  0,
							  -game_img_jet_width/6,  game_img_jet_height/2}
game_img_jet_physics = {density=0.15, bounce=0.1, friction=0.2, shape=game_img_jet_physics_shape}

game_img_mine = "resource/graphs/game_mine.png"
game_img_mine_scale = 35
game_img_mine_width_scale = 45 / 49 -- 49
game_img_mine_height_scale = 45 / 46 -- game_img_mine_width_scale -- 46
game_img_mine_options = {width = 49, height = 46, sheetContentWidth = 49, sheetContentHeight = 46, numFrames = 1}
game_img_mine_sprite = {name="mine", start=1, count=1, time=1000}
game_img_mine_physics_radius = 0.70
game_img_mine_physics = {density=0.1, bounce=0.1, friction=0.2, radius=game_img_mine_physics_radius}

game_img_explosion = "resource/graphs/game_explosion.png"
game_img_explosion_width_scale = 24 / 24 -- 24
game_img_explosion_height_scale = game_img_jet_width_scale -- 23
game_img_explosion_options = {width = 24, height = 23, sheetContentWidth = 192, sheetContentHeight = 23, numFrames = 8}
game_img_explosion_sprite = {name="explosion", start=1, count=8, time=2000, loopCount = 1}

game_txt_count_font = "neuropol x free"
game_txt_count_font_size = 100

-- audios
game_bg_sound_easy = {android="resource/audio/easy.ogg", ios="resource/audio/easy.m4a"}
game_bg_sound_easy_options = {loops=-1}
game_bg_sound_normal = {android="resource/audio/normal.ogg", ios="resource/audio/normal.m4a"}
game_bg_sound_normal_options = {loops=-1}
game_bg_sound_hard = {android="resource/audio/hard.ogg", ios="resource/audio/hard.m4a"}
game_bg_sound_hard_options = {loops=-1}
game_img_explosion_sound = {android="resource/audio/explosion.wav", ios="resource/audio/explosion.wav"}

game_btn_pause_click = {android="resource/audio/level.wav", ios="resource/audio/level.wav"}

-- PAUSE
-- images
pause_bg = "resource/graphs/pause_bg.png"
pause_bg_height = gameUI.height()-60 -- 1134
pause_bg_width = 300 -- 1100/(1134/pause_bg_height) -- 1100
pause_title = "Pause"
pause_title_font = "neuropol x free"
pause_title_font_size = 30
pause_btn_back = "resource/graphs/close_button.png"
pause_btn_back_width = 30 -- 300
pause_btn_back_height = 300/(300/pause_btn_back_width) -- 300

pause_txt_levelScore = "score"
pause_txt_levelScore_font = "neuropol x free"
pause_txt_levelScore_font_size = 18
pause_txt_music = "Music"
pause_txt_music_font = "neuropol x free"
pause_txt_music_font_size = 18
pause_txt_effects = "Effects"
pause_txt_effects_font = "neuropol x free"
pause_txt_effects_font_size = 18
pause_txt_vibrate = "Vibrate"
pause_txt_vibrate_font = "neuropol x free"
pause_txt_vibrate_font_size = 18

pause_btn_music_on = "resource/graphs/on_button.png"
pause_btn_music_on_text = "On"
pause_btn_music_off = "resource/graphs/off_button.png"
pause_btn_music_off_text = "Off"
pause_btn_music_width = 50 -- 400
pause_btn_music_height = 250/(400/pause_btn_music_width)-- 250
pause_btn_music_font = "neuropol x free"
pause_btn_music_font_size = 14

pause_btn_effects_on = pause_btn_music_on
pause_btn_effects_on_text = pause_btn_music_on_text
pause_btn_effects_off = pause_btn_music_off
pause_btn_effects_off_text = pause_btn_music_off_text
pause_btn_effects_width = pause_btn_music_width
pause_btn_effects_height = pause_btn_music_height
pause_btn_effects_font = pause_btn_music_font
pause_btn_effects_font_size = pause_btn_music_font_size

pause_btn_vibrate_on = pause_btn_music_on
pause_btn_vibrate_on_text = pause_btn_music_on_text
pause_btn_vibrate_off = pause_btn_music_off
pause_btn_vibrate_off_text = pause_btn_music_off_text
pause_btn_vibrate_width = pause_btn_music_width
pause_btn_vibrate_height = pause_btn_music_height
pause_btn_vibrate_font = pause_btn_music_font
pause_btn_vibrate_font_size = pause_btn_music_font_size

pause_btn_menu = "resource/graphs/menu_button_pause.png"
pause_btn_menu_width = 120 -- 500
pause_btn_menu_height = 170/(500/pause_btn_menu_width) -- 170
pause_btn_menu_text = "Menu"
pause_btn_menu_font = "neuropol x free"
pause_btn_menu_font_size = 18
pause_btn_menu_confirm_title = "Are You Sure?"
pause_btn_menu_confirm_text = "Your current game will end."
pause_btn_menu_confirm_btn_yes = "Yes"
pause_btn_menu_confirm_btn_cancel = "Cancel"

-- audios
pause_btn_music_click = {android="resource/audio/level.wav", ios="resource/audio/level.wav"}
pause_btn_effects_click = {android="resource/audio/level.wav", ios="resource/audio/level.wav"}
pause_btn_menu_click = {android="resource/audio/menu.wav", ios="resource/audio/menu.wav"}
pause_btn_back_click = {android="resource/audio/play.wav", ios="resource/audio/play.wav"}

-- GAMEOVER
-- images
gameover_bg = "resource/graphs/gameover_bg.png"
gameover_bg_obj = "resource/graphs/gameover_city.png"
gameover_bg_obj_width = gameUI.width() -- 1900
gameover_bg_obj_height = 550/(1900/gameover_bg_obj_width) -- 550

gameover_title = "GAME OVER"
gameover_title_font = "neuropol x free"
gameover_title_font_size = 30

gameover_txt_level_font = "neuropol x free"
gameover_txt_level_font_size = 20

gameover_txt_score = "score"
gameover_txt_score_font = "neuropol x free"
gameover_txt_score_font_size = 20
gameover_txt_val_score_font = "neuropol x free"
gameover_txt_val_score_font_size = 20
gameover_txt_best = "best score"
gameover_txt_best_font = "neuropol x free"
gameover_txt_best_font_size = 20
gameover_txt_val_best_font = "neuropol x free"
gameover_txt_val_best_font_size = 20

gameover_btn_menu = "resource/graphs/menu_button_gameover.png"
gameover_btn_menu_width = 140 -- 500
gameover_btn_menu_height = 170/(500/gameover_btn_menu_width) -- 170
gameover_btn_menu_text = "Menu"
gameover_btn_menu_font = "neuropol x free"
gameover_btn_menu_font_size = 18
gameover_btn_retry = "resource/graphs/retry_button.png"
gameover_btn_retry_width = 140 -- 500
gameover_btn_retry_height = 170/(500/gameover_btn_retry_width) -- 170
gameover_btn_retry_text = "Retry"
gameover_btn_retry_font = "neuropol x free"
gameover_btn_retry_font_size = 18

-- audios
gameover_bg_sound = {android="resource/audio/gameover.ogg", ios="resource/audio/gameover.m4a"}
gameover_bg_sound_options = {loops=-1}
gameover_btn_menu_click = {android="resource/audio/menu.wav", ios="resource/audio/menu.wav"}
gameover_btn_retry_click = {android="resource/audio/play.wav", ios="resource/audio/play.wav"}
