module(..., package.seeall)

local best = require( "best" )

local popupName = "social"
local imageBestScore = "bestScore.png"

local function doesFileExist( fname, path )

    local results = false

    -- Path for the file
    local filePath = system.pathForFile( fname, path )

    if ( filePath ) then
        local file, errorString = io.open( filePath, "r" )

        if not file then
            -- Error occurred; output the cause
            print( "File error: " .. errorString )
        else
            -- File exists!
            print( "File found: " .. filePath )
            results = true
            -- Close the file handle
            file:close()
        end
    end

    return results
end

-- serviceName: Supported values are "twitter", "facebook", or "sinaWeibo"
function socialShare(serviceName)
	serviceName = serviceName or "share"
	print("Share best score (", serviceName, ")")

	local isAvailable = native.canShowPopup( popupName, serviceName )

	if isAvailable then
		print("Social share is available")

		local groupToShare = best.getBestPic()

		os.remove( system.pathForFile( imageBestScore, system.TemporaryDirectory ) )
		--doesFileExist(imageBestScore, system.TemporaryDirectory)

		display.save( groupToShare, { filename=imageBestScore, baseDir=system.TemporaryDirectory } )
		--doesFileExist(imageBestScore, system.TemporaryDirectory)
		groupToShare:removeSelf()
		groupToShare = nil

		local socialListener = {}

		function socialListener:popup( event )
			print( "name(" .. event.name .. ") type(" .. event.type .. ") action(" .. tostring(event.action) .. ") limitReached(" .. tostring(event.limitReached) .. ")" )
		end

		local options = {}
		options.service = serviceName
		options.listener = socialListener

		options.message = "These are my JetBomb top scores. Try to beat me!"
		options.url = { global_playstore_url }

		if(doesFileExist(imageBestScore, system.TemporaryDirectory)) then
			options.image = {
				{ filename = imageBestScore, baseDir = system.TemporaryDirectory },
			}
		end

		print("Show pop-up in 100 ms")
		timer.performWithDelay( 100, function() native.showPopup( popupName, options ) end )
	else
		print("Social share isn't available")

		native.showAlert(
			"Cannot share",
			"Please setup your " .. serviceName .. " account or check your network connection.",
			{ "OK" } )
	end
end
