module(..., package.seeall)

local gameNetwork = require( "gameNetwork" )
local gameUI = require ("gameUI")
local score = require ("score")

playerData = nil

--for GameCenter, default to the leaderboard name from iTunes Connect
local categoryEasy = "com.yourname.yourgame.highscores"
local categoryNormal = "com.yourname.yourgame.highscores"
local categoryHard = "com.yourname.yourgame.highscores"

if ( gameUI.isAndroid() ) then
	categoryEasy = "CgkI-4GmmYQfEAIQAA"
	categoryNormal = "CgkI-4GmmYQfEAIQAQ"
	categoryHard = "CgkI-4GmmYQfEAIQAg"
end

local function loadLocalPlayerCallback( event )
	playerData = event.data

	print("Connected to game network")

	gameNet.loadScores()
end

local function gameNetworkLoginCallback( event )
	gameNetwork.request( "loadLocalPlayer", { listener=loadLocalPlayerCallback } )
	return true
end

local function gpgsInitCallback( event )
	gameNetwork.request( "login", { userInitiated=true, listener=gameNetworkLoginCallback } )
end

function gameNetworkSetup()
	if ( gameUI.isAndroid() ) then
		gameNetwork.init( "google", gpgsInitCallback )
	else
		gameNetwork.init( "gamecenter", gameNetworkLoginCallback )
	end
end

function showLeaderboards( event )
	if not playerData then
		gameNetworkSetup()
	end
	
	local isConnected = true
	if not playerData or gameUI.isSimulator() then
		isConnected = false
	end

	if not isConnected then
		print("GameCenter isn't available")
		native.showAlert(
			"Cannot open GameCenter",
			"Please setup your account or check your network connection.",
			{ "OK" } )
		return false
	end

	if ( gameUI.isAndroid() ) then
		gameNetwork.show( "leaderboards" )
	else
		gameNetwork.show( "leaderboards", { leaderboard = {timeScope="AllTime"} } )
	end

	return true
end

function showAchievements( event )
-- REMOVE AFTER ACHIEVEMENTS WERE IMPLEMENTED
	native.showAlert(
		"Sorry",
		"Achievements will be available soon.",
		{ "OK" } )
	return false
--[[
	if not playerData then
		gameNetworkSetup()
	end
	
	local isConnected = true
	if not playerData or gameUI.isSimulator() then
		isConnected = false
	end

	if not isConnected then
		print("GameCenter isn't available")
		native.showAlert(
			"Cannot open GameCenter",
			"Please setup your account or check your network connection.",
			{ "OK" } )
		return false
	end

	gameNetwork.show( "achievements" )

	return true
--]]
end

local function postScoreSubmit( event )
	print("Score " .. 0 .. " level " .. 0 .. " submited!")
	return true
end

function postScore( score, level )
	if not playerData then
		gameNetworkSetup()
	end
	
	local isConnected = true
	if not playerData or gameUI.isSimulator() then
		isConnected = false
	end

	if not isConnected then
		print("GameCenter isn't available")
		return false
	end

	local myCategory = categoryNormal
	if level == 1 then
		myCategory = categoryEasy
	elseif level == 3 then
		myCategory = categoryHard
	end

	gameNetwork.request( "setHighScore",
	{
		localPlayerScore = { category=myCategory, value=tonumber(score) },
		listener = postScoreSubmit
	} )
end

local loadedScores = {0, 0, 0}

local function loadScoreReceived( event )
	if (event.data[1].category == categoryEasy) then
		loadedScores[1] = event.data[1].value
	elseif (event.data[1].category == categoryNormal) then
		loadedScores[2] = event.data[1].value
	elseif (event.data[1].category == categoryHard) then
		loadedScores[3] = event.data[1].value
	end

	score.setHighScores(loadedScores)
end

function loadScores()
	if not playerData then
		gameNetworkSetup()
	end
	
	local isConnected = true
	if not playerData or gameUI.isSimulator() then
		isConnected = false
	end

	if not isConnected then
		print("GameCenter isn't available")
		return false
	end

	gameNetwork.request( "loadScores",
		{
			leaderboard =
			{
				category = categoryEasy,
				playerScope = "Global",   -- Global, FriendsOnly
				timeScope = "AllTime",    -- AllTime, Week, Today
				range = { 1,1 },
				playerCentered = true     -- Just for current player
			},
			listener = loadScoreReceived
		}
	)

	gameNetwork.request( "loadScores",
		{
			leaderboard =
			{
				category = categoryNormal,
				playerScope = "Global",   -- Global, FriendsOnly
				timeScope = "AllTime",    -- AllTime, Week, Today
				range = { 1,1 },
				playerCentered = true     -- Just for current player
			},
			listener = loadScoreReceived
		}
	)

	gameNetwork.request( "loadScores",
		{
			leaderboard =
			{
				category = categoryHard,
				playerScope = "Global",   -- Global, FriendsOnly
				timeScope = "AllTime",    -- AllTime, Week, Today
				range = { 1,1 },
				playerCentered = true     -- Just for current player
			},
			listener = loadScoreReceived
		}
	)

	return nil
end
