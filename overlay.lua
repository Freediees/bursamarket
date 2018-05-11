-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------
local widget = require( "widget" )
local json = require ("json")
local composer = require( "composer" )
local scene = composer.newScene()
composer.used_font = "Raleway-Regular.ttf"
composer.used_font_bold = "Raleway-Bold.ttf"
composer.id_kategori = 0
composer.status_kategori= 1 
local cancelall = {}
local began = 1
local pindah = "login_fix"
composer.page = 1

require "sqlite3"

local datab = "data.db"
local path = system.pathForFile(datab, system.DocumentsDirectory)
db = sqlite3.open( path )


local loop = 0
local loop2 = 0
composer.is_login = 0
composer.data_max_slider = 0
local pindah = ""
composer.masuk = 0



for row in db:nrows("SELECT * FROM is_login") do
  loop = loop + 1
end

if(loop == 0)then
	local tablesetup = [[INSERT INTO is_login VALUES(NULL, '0', '0');]]
	db:exec(tablesetup)
else
	for row in db:nrows("SELECT * FROM is_login where status_login = '1'") do
	  loop2 = loop2 + 1
	end


	print("loop = "..loop2.." composer login = "..composer.is_login)

	if(loop2 == 0)then
		composer.masuk = 0
		composer.is_login = 0
		pindah = "login_fix"
		--pindah = "informasi_akun"
	else

		composer.masuk = 1
		composer.is_login = 1
		pindah = "view1"
		--pindah = "informasi_akun"

	end
end


local function pindah_halaman()

	local options = {
	    effect = "slideLeft",
	    time = 500
	}
	composer.gotoScene( "view1", options )
end
timer.performWithDelay(3000, pindah_halaman)

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
	background:setFillColor( 1 )	-- white

	local background2 = display.newImageRect( composer.imgDir.. "background_overlay.png", 1080, 1080); 
	background2.x = display.contentCenterX;
	background2.y =  display.contentCenterY
	background2.anchorY = 0.5
	background2.anchorX = 0.5
	--background2:scale(0.5,0.5)
	background2.xScale = (display.contentHeight) / background2.height
	background2.yScale = (display.contentHeight) / background2.height
	
	local logo = display.newImageRect( composer.imgDir.. "logo_overlay.png", 900, 560 ); 
	logo.x = display.contentCenterX;
	logo.y =  display.contentCenterY
	logo.anchorY = 0.5
	logo.anchorX = 0.5
	--logo:scale(0.5,0.5)
	logo.xScale = (display.contentWidth* 0.7) / logo.width 
	logo.yScale = (display.contentWidth * 0.7) / logo.width 

	sceneGroup:insert(background)
	sceneGroup:insert(background2)
	sceneGroup:insert(logo)

end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	-- local options =
 --      {
 --         appPermission = "Storage"
 --      }
 --      native.showPopup( "requestAppPermission", options )

 --      local options =
 --      {
 --         appPermission = "Internet"
 --      }
 --      native.showPopup( "requestAppPermission", options )
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