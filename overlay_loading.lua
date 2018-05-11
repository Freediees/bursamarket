-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------
local widget = require( "widget" )
local json = require ("json")
local composer = require( "composer" )
local scene = composer.newScene()
local used_font = "PT_Sans-Web-Regular.ttf"
local used_font_bold = "PT_Sans-Web-Bold.ttf"
composer.id_kategori = 0
composer.status_kategori= 1 
local cancelall = {}
local began = 1

composer.page = 1

function scene:create( event )

	local lfs = require( "lfs" )
 	
 	local sceneGroup = self.view

	local doc_path = system.pathForFile( "", system.TemporaryDirectory )
	 
	for file in lfs.dir( doc_path ) do
	    local destDir = system.TemporaryDirectory  -- Location where the file is stored
        os.remove( system.pathForFile( file , destDir ) )
	end

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.
	
	-- create a white background to fill screen
	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 1 )
	background.alpha = 0.4	-- white
	

	

	--[[local teks1 = display.newText( "Tunggu Sebentar...", display.contentCenterX , display.contentCenterY, used_font_bold, 15  * (display.contentWidth / 320)  )
	teks1.anchorX = 0.5
	teks1.anchorY = 0.5
	teks1:setFillColor(1)

	local back_text = display.newRoundedRect(display.contentCenterX, display.contentCenterY, teks1.width + display.contentWidth/10, teks1.height + display.contentHeight/20, 50)
	back_text:setFillColor( 133/255,190/255,72/255 )--]]
	


	local options = {
	    width = 128,
	    height = 128,
	    numFrames = 1,
	    sheetContentWidth = 128,
	    sheetContentHeight = 128
	}
	local spinnerSingleSheet = graphics.newImageSheet( composer.imgDir.."spinner.png", options )
	 
	-- Create the widget
	local spinner = widget.newSpinner(
	    {
	        width = 50,
	        height = 50,
	        sheet = spinnerSingleSheet,
	        startFrame = 1,
	        deltaAngle = 5,
	        x= display.contentCenterX,
	        y= display.contentCenterY,
	        incrementEvery = 20
	    }
	)
	--spinner:setFillColor(1)
	spinner:start()

	sceneGroup:insert(background)
	sceneGroup:insert(spinner)
	--[[sceneGroup:insert(back_text)
	sceneGroup:insert(teks1)--]]

end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then


	elseif phase == "did" then

     --composer.removeHidden()
  
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		
		
	elseif phase == "did" then
	
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene