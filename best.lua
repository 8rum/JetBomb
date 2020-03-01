module(..., package.seeall)

-- requires 

local gameUI = require ("gameUI")
local defines = require( "defines" )
local score = require( "score" )

function getBestPic()
	local pictureBest = display.newGroup()

	local bg = gameUI.addButton(best_bg, nil, nil, best_bg_width, best_bg_height)
	pictureBest:insert(bg)

	local collumnEq = gameUI.width()/2
	local collumn = {collumnEq - 20, collumnEq + 20}
	local lineNum = 6
	local lineEq = gameUI.height()/(lineNum+1)
	local shift = 40
	local line = {lineEq*1+shift, lineEq*2+shift, lineEq*3+shift, lineEq*4+shift, lineEq*5+shift}

	local logoText = gameUI.addButton(start_logo_text_obj, collumnEq, line[1]-shift*0.5, start_logo_text_obj_width, start_logo_text_obj_height)
	pictureBest:insert(logoText)

	local objBack = gameUI.addBomb(start_img_obj_back, start_img_obj_back_width, start_img_obj_back_height,
		start_img_obj_back1, start_img_obj_back1_options, start_img_obj_back1_sprite,
		{start_img_obj_back1_width_scale, start_img_obj_back1_height_scale}, {start_img_obj_back1_X, start_img_obj_back1_Y})
	objBack.x = logoText.x+(logoText.width*0.077)
	objBack.y = logoText.y
	pictureBest:insert(objBack)

	local easyText = display.newText(best_txt_easy, collumn[1], line[2], best_txt_easy_font, best_txt_easy_font_size)
	easyText.anchorX = 1
	easyText:setFillColor(1)
	pictureBest:insert(easyText)

	local normalText = display.newText(best_txt_normal, collumn[1], line[3], best_txt_normal_font, best_txt_normal_font_size)
	normalText.anchorX = 1
	normalText:setFillColor(1)
	pictureBest:insert(normalText)

	local hardText = display.newText(best_txt_hard, collumn[1], line[4], best_txt_hard_font, best_txt_hard_font_size)
	hardText.anchorX = 1
	hardText:setFillColor(1)
	pictureBest:insert(hardText)

	easyTextVal = display.newText(score.getBest(1), collumn[2], line[2], best_txt_val_easy_font, best_txt_val_easy_font_size)
	easyTextVal.anchorX = 0
	easyTextVal:setFillColor(1)
	pictureBest:insert(easyTextVal)

	normalTextVal = display.newText(score.getBest(2), collumn[2], line[3], best_txt_val_normal_font, best_txt_val_normal_font_size)
	normalTextVal.anchorX = 0
	normalTextVal:setFillColor(1)
	pictureBest:insert(normalTextVal)

	hardTextVal = display.newText(score.getBest(3), collumn[2], line[4], best_txt_val_hard_font, best_txt_val_hard_font_size)
	hardTextVal.anchorX = 0
	hardTextVal:setFillColor(1)
	pictureBest:insert(hardTextVal)

	local bestTitle = display.newText(best_title, collumnEq, line[5], best_title_font, best_title_font_size)
	bestTitle:setFillColor(1)
	pictureBest:insert(bestTitle)

	return pictureBest
end
