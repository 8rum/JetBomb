-- Score Module

module(..., package.seeall)

local gameUI = require ("gameUI")
local gameNet = require ("gameNet")

local json = require ( "json" )
local GA = require ( "plugin.gameanalytics" )

local filename = "localCache.json"
local directory = system.DocumentsDirectory

local bestDefault = {0, 0, 0}

if (not gameUI.isSimulator()) then
	local openssl = require( "plugin.openssl" )

	local cipher = openssl.get_cipher ( "aes-256-cbc" )
	local mime = require ( "mime" )

	local key = "32810774DF953E61"

	function encript(data)
		local encryptedData = mime.b64 ( cipher:encrypt ( data, key ) )
		--print ( "Encrypted Text: ", encryptedData )
		return encryptedData
	end

	function decrypt(data)
		local decryptedData = ""
		if (data) then
			decryptedData = cipher:decrypt ( mime.unb64 ( data ), key )
		end
		--print ( "Decrypted Text: ", decryptedData )
		return decryptedData
	end

	key = encript("3987AB6332CB58F5")
	--print("KEY: ", key)

end

local function saveTable()
	local path = system.pathForFile(filename, directory)
	--print(path)
	local file = io.open(path, "w")
	if file then
		local contents = json.encode(highScores)
		--print(contents, " >> ", filename)
		if (not gameUI.isSimulator()) then
			contents = encript(contents)
		end

		file:write( contents )
		io.close( file )
		return true
	else
		return false
	end
end

local function loadTable()
	local path = system.pathForFile(filename, directory)
	--print(path)
	local contents = ""
	local myTable = {}
	local file = io.open( path, "r" )
	if file then
		-- read all contents of file into a string
		local contents = file:read( "*a" )
		--print(contents, " << ", filename)
		if (not gameUI.isSimulator()) then
			contents = decrypt(contents)
		end

		myTable = json.decode(contents);
		io.close( file )
		return myTable or bestDefault
	end
	return bestDefault
end

local myScore = 0
function getBest(level)
	if highScores == nil then
		highScores = loadTable()
	end

	level = level or gameUI.getConfig(gameUI._LEVEL)
	return highScores[level] or bestDefault[level]
end

function setBest(level)
	if highScores == nil then
		highScores = loadTable()
	end

	level = level or gameUI.getConfig(gameUI._LEVEL)
	highScores[level] = myScore

	gameNet.postScore(myScore, level)

	GA.newEvent ( "design", { area="score", event_id="Best:Level:"..level, value=myScore } )
	if(myScore > 999) then
		GA.newEvent ( "error", { area="score", severity="warning", message="Crazy best score ["..myScore.."] for level ["..level.."]" } )
	end

	return saveTable()
end

function setHighScores(scores)
	if highScores == nil then
		highScores = loadTable()
	end

	if(scores[1] > highScores[1]) then
		highScores[1] = scores[1]
	end

	if(scores[2] > highScores[2]) then
		highScores[2] = scores[2]
	end

	if(scores[3] > highScores[3]) then
		highScores[3] = scores[3]
	end

	saveTable()
end

function getScore()
	return myScore
end

function setScore(newScore)
	myScore = newScore
	if myScore > getBest() then
		setBest()
	end
	GA.newEvent ( "design", { area="score", event_id="Score:Level:"..gameUI.getConfig(gameUI._LEVEL), value=myScore } )
end
