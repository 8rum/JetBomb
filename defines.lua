local gameUI = require ("gameUI")

BUILD_NUMBER = "1.1.7"
--[[ Comment to release / Uncomment to TEST
SIMULATION = true
--SIMUL_USE_GA = true
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
global_my_mail = "rbcamolez@gmail.com"

main_color = {0.4, 0.4, 0.4, 1}
main_options_color = nil
main_on_color = {0, 1, 0}
main_off_color = {1, 0, 0}

-- START
-- images
start_bg = "resource/graphs/background.jpg"
start_bg_obj_base = "resource/graphs/mountain2.png"
start_bg_obj_speed = 8
start_bg_obj_base_invert = true
start_bg_obj_base_width = gameUI.width() -- 1961
start_bg_obj_base_height = 415/(1961/start_bg_obj_base_width) -- 415

start_img_obj_back = "resource/graphs/bomb.png"
start_img_obj_back_width = 100 -- 178
start_img_obj_back_height = 171/(178/start_img_obj_back_width) -- 171
start_img_obj_back1 = "resource/graphs/spark.png"
start_img_obj_back1_X = start_img_obj_back_width*0.5
start_img_obj_back1_Y = -start_img_obj_back_height*0.48
start_img_obj_back1_width_scale = 100 / 262.22 -- 262.22
start_img_obj_back1_height_scale = start_img_obj_back1_width_scale -- 262.5
start_img_obj_back1_options = {width = 262.22, height = 262.5, sheetContentWidth = 2360, sheetContentHeight = 525, numFrames = 18}
start_img_obj_back1_sprite = {name="spark", start=1, count=18, time=500}

start_logo_text_obj = "resource/graphs/logo.png"
start_logo_text_obj_width = 450 -- 1438
start_logo_text_obj_height = 216/(1438/start_logo_text_obj_width) -- 216

start_logo_jet_obj = "resource/graphs/jet.png"
start_logo_jet_obj_width = 250 -- 785
start_logo_jet_obj_height = 383/(785/start_logo_jet_obj_width) -- 383
start_logo_jet_obj1 = "resource/graphs/flame.png"
start_logo_jet_obj1_X = -start_logo_jet_obj_width*0.64
start_logo_jet_obj1_Y = start_logo_jet_obj_height*0.27
start_logo_jet_obj1_width_scale = (0.16 * start_logo_jet_obj_width) / 164.33 -- 164.33
start_logo_jet_obj1_height_scale = start_logo_jet_obj1_width_scale -- 643
start_logo_jet_obj1_options = {width = 164.33, height = 643, sheetContentWidth = 1479, sheetContentHeight = 1286, numFrames = 18}
start_logo_jet_obj1_sprite = {name="flame", start=1, count=18, time=1000, loopDirection="bounce"}
--start_logo_jet_obj1_sprite = {name="flame", start=6, count=8, time=500, loopDirection="bounce"}

start_btn_start = "resource/graphs/button_wide.png"
start_btn_start_color = main_color
start_btn_start_width = 140 -- 500
start_btn_start_height = 170/(500/start_btn_start_width) -- 170
start_btn_start_text = "Start"
start_btn_start_font = "neuropol x free"
start_btn_start_font_size = 18

start_btn_options = "resource/graphs/config.png"
start_btn_options_color = main_options_color
start_btn_options_width = 30 -- 485
start_btn_options_height = 485/(485/start_btn_options_width) -- 485

start_btn_achievements = "resource/graphs/achievements.png"
start_btn_achievements_color = main_options_color
start_btn_achievements_width = 30 -- 479
start_btn_achievements_height = 479/(479/start_btn_achievements_width) -- 479

start_btn_leaderboard = "resource/graphs/leaderboard.png"
start_btn_leaderboard_color = main_options_color
start_btn_leaderboard_width = 30 -- 496
start_btn_leaderboard_height = 496/(496/start_btn_leaderboard_width) -- 496

start_btn_share = "resource/graphs/share.png"
start_btn_share_color = main_options_color
start_btn_share_width = 30 -- 353
start_btn_share_height = 353/(353/start_btn_share_width) -- 353

start_btn_info = "resource/graphs/info.png"
start_btn_info_color = main_options_color
start_btn_info_width = 30 -- 457
start_btn_info_height = 457/(457/start_btn_info_width) -- 457

start_btn_help = "resource/graphs/help.png"
start_btn_help_color = main_options_color
start_btn_help_width = 30 -- 460
start_btn_help_height = 460/(460/start_btn_help_width) -- 460

main_btn_exit_confirm_title = "Are You Sure?"
main_btn_exit_confirm_text = "Are you sure you want to exit JetBomb."
main_btn_exit_confirm_btn_yes = "Yes"
main_btn_exit_confirm_btn_cancel = "Cancel"

-- audios
start_bg_sound = {android="resource/audio/start.ogg", ios="resource/audio/start.m4a"}
start_bg_sound_options = {loops=-1}
start_btn_start_click = {android="resource/audio/play.wav", ios="resource/audio/play.wav"}
start_btn_options_click = {android="resource/audio/level.wav", ios="resource/audio/level.wav"}
start_btn_leaderboard_click = {android="resource/audio/level.wav", ios="resource/audio/level.wav"}
start_btn_achievement_click = {android="resource/audio/level.wav", ios="resource/audio/level.wav"}
start_btn_share_click = {android="resource/audio/level.wav", ios="resource/audio/level.wav"}
start_btn_info_click = {android="resource/audio/level.wav", ios="resource/audio/level.wav"}
start_btn_help_click = {android="resource/audio/level.wav", ios="resource/audio/level.wav"}


-- HELP
-- images
help_img_help = "resource/graphs/help.jpg"
help_img_help_width = gameUI.width() -- 1512
help_img_help_height = 756/(1512/help_img_help_width) -- 756
if (help_img_help_height > gameUI.height()) then
	help_img_help_height = gameUI.height() -- 756
	help_img_help_width = 1512/(756/help_img_help_height) -- 1512
end
help_img_help_width = help_img_help_width * 0.9
help_img_help_height = help_img_help_height * 0.9
help_img_help_color = {0.9, 0.9}

help_img_ckb_text = "I got it! Don't\nshow me again."
help_img_ckb_font = "neuropol x free"
help_img_ckb_font_size = 12
help_img_ckb_on = "resource/graphs/ckbOn.png"
help_img_ckb_on_color = {0, 1, 0}
help_img_ckb_off = "resource/graphs/ckbOff.png"
help_img_ckb_off_color = {1, 0, 0}
help_img_ckb_width = 30 -- 257
help_img_ckb_height = 257/(257/help_img_ckb_width)-- 257


-- OPTIONS
-- images
options_bg = nil
options_bg_width = gameUI.width()*0.8 -- 1100/(1134/pause_bg_height) -- 1100
options_bg_height = gameUI.height()*0.85 -- 1134

options_title = "OPTIONS"
options_title_font = "neuropol x free"
options_title_font_size = 30

options_btn_back = "resource/graphs/button_.png"
options_btn_back_color = main_off_color
options_btn_back_width = 30 -- 266
options_btn_back_height = 266/(266/options_btn_back_width) -- 266

options_txt_music = "Music"
options_txt_music_font = "neuropol x free"
options_txt_music_font_size = 20
options_txt_effects = "Effects"
options_txt_effects_font = "neuropol x free"
options_txt_effects_font_size = 20
options_txt_vibrate = "Vibrate"
options_txt_vibrate_font = "neuropol x free"
options_txt_vibrate_font_size = 20
options_txt_level = "Difficulty"
options_txt_level_font = "neuropol x free"
options_txt_level_font_size = 20

options_btn_music_on = "resource/graphs/button_small.png"
options_btn_music_on_color = main_on_color
options_btn_music_on_text = "On"
options_btn_music_off = "resource/graphs/button_small.png"
options_btn_music_off_color = main_off_color
options_btn_music_off_text = "Off"
options_btn_music_width = 55 -- 400
options_btn_music_height = 250/(400/options_btn_music_width)-- 250
options_btn_music_font = "neuropol x free"
options_btn_music_font_size = 18

options_btn_effects_on = options_btn_music_on
options_btn_effects_on_color = options_btn_music_on_color
options_btn_effects_on_text = options_btn_music_on_text
options_btn_effects_off = options_btn_music_off
options_btn_effects_off_color = options_btn_music_off_color
options_btn_effects_off_text = options_btn_music_off_text
options_btn_effects_width = options_btn_music_width
options_btn_effects_height = options_btn_music_height
options_btn_effects_font = options_btn_music_font
options_btn_effects_font_size = options_btn_music_font_size

options_btn_vibrate_on = options_btn_music_on
options_btn_vibrate_on_color = options_btn_music_on_color
options_btn_vibrate_on_text = options_btn_music_on_text
options_btn_vibrate_off = options_btn_music_off
options_btn_vibrate_off_color = options_btn_music_off_color
options_btn_vibrate_off_text = options_btn_music_off_text
options_btn_vibrate_width = options_btn_music_width
options_btn_vibrate_height = options_btn_music_height
options_btn_vibrate_font = options_btn_music_font
options_btn_vibrate_font_size = options_btn_music_font_size

options_btn_level_easy = "resource/graphs/button_wide.png"
options_btn_level_easy_color = {0, 1, 0}
options_btn_level_easy_text = "easy"
options_btn_level_easy_font = "neuropol x free"
options_btn_level_easy_font_size = 18
options_btn_level_normal = "resource/graphs/button_wide.png"
options_btn_level_normal_color = {1, 1, 0}
options_btn_level_normal_text = "normal"
options_btn_level_normal_font = options_btn_level_easy_font
options_btn_level_normal_font_size = 18
options_btn_level_hard = "resource/graphs/button_wide.png"
options_btn_level_hard_color = {1, 0, 0}
options_btn_level_hard_text = "hard"
options_btn_level_hard_font = options_btn_level_easy_font
options_btn_level_hard_font_size = 18
options_btn_level_width = 100 -- 500
options_btn_level_height = 170/(500/options_btn_level_width) -- 170

-- audios
options_bg_sound = {android="resource/audio/start.ogg", ios="resource/audio/start.m4a"}
options_bg_sound_options = {loops=-1}
options_btn_level_click = {android="resource/audio/level.wav", ios="resource/audio/level.wav"}
options_btn_music_click = {android="resource/audio/level.wav", ios="resource/audio/level.wav"}
options_btn_effects_click = {android="resource/audio/level.wav", ios="resource/audio/level.wav"}
options_btn_vibrate_click = {android="resource/audio/level.wav", ios="resource/audio/level.wav"}
options_btn_back_click = {android="resource/audio/menu.wav", ios="resource/audio/menu.wav"}
options_btn_start_click = {android="resource/audio/play.wav", ios="resource/audio/play.wav"}
options_btn_best_click = {android="resource/audio/level.wav", ios="resource/audio/level.wav"}

-- BEST
-- images
best_bg = "resource/graphs/background.jpg"
best_bg_width = gameUI.width()
best_bg_height = gameUI.height()

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

-- GAME
-- images
game_bg = "resource/graphs/background.jpg"
game_bg_obj1 = "resource/graphs/mountain1.png"
game_bg_obj1_invert = false
game_bg_obj1_speed = 1
game_bg_obj1_width = gameUI.width() -- 1961
game_bg_obj1_height = 678/(1961/game_bg_obj1_width) -- 678
game_bg_obj2 = "resource/graphs/mountain2.png"
game_bg_obj2_speed = 2
game_bg_obj2_invert = true
game_bg_obj2_width = gameUI.width() -- 1961
game_bg_obj2_height = 415/(1961/game_bg_obj2_width) -- 415

game_txt_score = "Score: "
game_txt_score_font = "neuropol x free"
game_txt_score_font_size = 25

game_img_pause = "resource/graphs/button_.png"
game_img_pause_color = main_off_color
game_img_pause_width = 30 -- 266
game_img_pause_height = 266/(266/game_img_pause_width) -- 266

game_img_boost = "resource/graphs/button0.png"
game_img_boost_color = {1, 0, 0, 0.8}
game_img_boost_width = 45 -- 266
game_img_boost_height = 265/(266/game_img_boost_width) -- 265

game_img_boost_icon = "resource/graphs/fire.png"
game_img_boost_icon_color = {1, 0.8}
game_img_boost_icon_width = 30 -- 502
game_img_boost_icon_height = 503/(502/game_img_boost_icon_width) -- 503

game_img_celling = "resource/graphs/cloud.png"
game_img_celling_width = gameUI.width() -- 1892
game_img_celling_height = 41/(1892/game_bg_obj1_width) -- 41

game_img_floor = "resource/graphs/bush.png"
game_img_floor_width = gameUI.width() -- 2444
game_img_floor_height = 70/(2444/game_bg_obj1_width) -- 70

game_img_jet = "resource/graphs/jet.png"
game_img_jet_width = 50 -- 785
game_img_jet_height = 383/(785/game_img_jet_width) -- 383
game_img_jet1 = "resource/graphs/flame.png"
game_img_jet1_X = -game_img_jet_width*0.64
game_img_jet1_Y = game_img_jet_height*0.27
game_img_jet1_width_scale = (0.16 * game_img_jet_width) / 164.33 -- 164.33
game_img_jet1_height_scale = game_img_jet1_width_scale -- 643
game_img_jet1_options = {width = 164.33, height = 643, sheetContentWidth = 1479, sheetContentHeight = 1286, numFrames = 18}
game_img_jet1_sprite = {name="flame", start=1, count=18, time=1000, loopDirection="bounce"}
game_img_jet_physics_shape = {-game_img_jet_width*0.45, -game_img_jet_height*0.5,
							   game_img_jet_width*0.05, -game_img_jet_height*0.35,
							   game_img_jet_width*0.43,  game_img_jet_height*0.08,
							  -game_img_jet_width*0.3 ,  game_img_jet_height*0.5}
game_img_jet_physics = {density=0.1, bounce=0, friction=1, shape=game_img_jet_physics_shape}
game_img_jet_force = -2.3--1.7
game_img_jet_force_limit = -220
game_img_jet_force_break = 0.5

game_img_mine = "resource/graphs/bomb.png"
game_img_mine_scale = 35
game_img_mine_width = 80 -- 178
game_img_mine_height = 171/(178/game_img_mine_width) -- 171
game_img_mine_width_scale = game_img_mine_width / 178 -- 178
game_img_mine_height_scale = game_img_mine_width_scale -- 171
game_img_mine1 = "resource/graphs/spark.png"
game_img_mine1_X = game_img_mine_width*0.5
game_img_mine1_Y = -game_img_mine_height*0.48
game_img_mine1_width_scale = 100 / 262.22 -- 262.22
game_img_mine1_height_scale = game_img_mine1_width_scale -- 262.5
game_img_mine1_options = {width = 262.22, height = 262.5, sheetContentWidth = 2360, sheetContentHeight = 525, numFrames = 18}
game_img_mine1_sprite = {name="spark", start=1, count=18, time=500, loopDirection="bounce"}
game_img_mine_physics_radius = 0.4
game_img_mine_physics = {density=0.1, bounce=0.1, friction=0.2, radius=game_img_mine_physics_radius}

game_img_explosion = "resource/graphs/explosion.png"
game_img_explosion_width_scale = 60 / 185.25 -- 185.25
game_img_explosion_height_scale = game_img_explosion_width_scale -- 185.17
game_img_explosion_options = {width = 185.25, height = 185.17, sheetContentWidth = 1482, sheetContentHeight = 1111, numFrames = 48}
game_img_explosion_sprite = {name="explosion", start=1, count=48, time=2000, loopCount = 1}

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
pause_bg = nil
pause_bg_width = gameUI.width()*0.6 -- 1100/(1134/pause_bg_height) -- 1100
pause_bg_height = gameUI.height()*0.8 -- 1134

pause_title = "Pause"
pause_title_font = "neuropol x free"
pause_title_font_size = 30

pause_btn_back = "resource/graphs/button_.png"
pause_btn_back_color = main_off_color
pause_btn_back_width = 30 -- 266
pause_btn_back_height = 266/(266/pause_btn_back_width) -- 266

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

pause_btn_music_on = "resource/graphs/button_small.png"
pause_btn_music_on_color = main_on_color
pause_btn_music_on_text = "On"
pause_btn_music_off = "resource/graphs/button_small.png"
pause_btn_music_off_color = main_off_color
pause_btn_music_off_text = "Off"
pause_btn_music_width = 50 -- 400
pause_btn_music_height = 250/(400/pause_btn_music_width)-- 250
pause_btn_music_font = "neuropol x free"
pause_btn_music_font_size = 14

pause_btn_effects_on = pause_btn_music_on
pause_btn_effects_on_color = pause_btn_music_on_color
pause_btn_effects_on_text = pause_btn_music_on_text
pause_btn_effects_off = pause_btn_music_off
pause_btn_effects_off_color = pause_btn_music_off_color
pause_btn_effects_off_text = pause_btn_music_off_text
pause_btn_effects_width = pause_btn_music_width
pause_btn_effects_height = pause_btn_music_height
pause_btn_effects_font = pause_btn_music_font
pause_btn_effects_font_size = pause_btn_music_font_size

pause_btn_vibrate_on = pause_btn_music_on
pause_btn_vibrate_on_color = pause_btn_music_on_color
pause_btn_vibrate_on_text = pause_btn_music_on_text
pause_btn_vibrate_off = pause_btn_music_off
pause_btn_vibrate_off_color = pause_btn_music_off_color
pause_btn_vibrate_off_text = pause_btn_music_off_text
pause_btn_vibrate_width = pause_btn_music_width
pause_btn_vibrate_height = pause_btn_music_height
pause_btn_vibrate_font = pause_btn_music_font
pause_btn_vibrate_font_size = pause_btn_music_font_size

pause_btn_menu = "resource/graphs/button_wide.png"
pause_btn_menu_color = main_color
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
pause_btn_vibrate_click = {android="resource/audio/level.wav", ios="resource/audio/level.wav"}
pause_btn_menu_click = {android="resource/audio/menu.wav", ios="resource/audio/menu.wav"}
pause_btn_back_click = {android="resource/audio/play.wav", ios="resource/audio/play.wav"}

-- GAMEOVER
-- images
gameover_bg = nil
gameover_bg_width = gameUI.width()*0.6 -- 1100/(1134/pause_bg_height) -- 1100
gameover_bg_height = gameUI.height()*0.8 -- 1134

gameover_title = "GAME OVER"
gameover_title_font = "neuropol x free"
gameover_title_font_size = 30

gameover_txt_level_font = "neuropol x free"
gameover_txt_level_font_size = 26

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

gameover_btn_menu = "resource/graphs/menu.png"
gameover_btn_menu_color = main_options_color
gameover_btn_menu_height = 50 -- 460
gameover_btn_menu_width = 487/(460/gameover_btn_menu_height) -- 487

gameover_btn_retry = "resource/graphs/retry.png"
gameover_btn_retry_color = main_options_color
gameover_btn_retry_height = 50 -- 488
gameover_btn_retry_width = 487/(488/gameover_btn_retry_height) -- 487

-- audios
gameover_bg_sound = {android="resource/audio/gameover.ogg", ios="resource/audio/gameover.m4a"}
gameover_bg_sound_options = {loops=-1}
gameover_btn_menu_click = {android="resource/audio/menu.wav", ios="resource/audio/menu.wav"}
gameover_btn_retry_click = {android="resource/audio/play.wav", ios="resource/audio/play.wav"}
