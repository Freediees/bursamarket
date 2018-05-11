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
	background:setFillColor( 0 )	-- white
	background.alpha = 0.7

	local background2 = display.newRect( display.contentCenterX, 0, display.contentWidth, display.contentHeight/5)
	background2.anchorY = 0
	background2:setFillColor( 133/255,190/255,72/255)
	background2.alpha = 0

	local background3 = display.newRect( display.contentCenterX, 0, display.contentWidth / 2, display.contentHeight)
	background3.anchorY = 0
	background3.anchorX = 0
	background3:setFillColor( 127/255,171/255,74/255)
	background3.alpha = 1


	local function onMenu()
		-- body
		composer.hideOverlay("fromLeft", 100)
		
	end
	background:addEventListener("tap", onMenu)
	local xt = display.contentCenterX

	local menu = display.newImageRect( composer.imgDir.. "menu.png", 110, 88 ); 
	menu.x = 0 + 20 + xt;
	menu.y =  0 + display.contentCenterY / 11
	menu.anchorY = 0.5
	menu.anchorX = 0
	--menu:scale(0.5,0.5)
	menu.xScale = (background2.height/6) / menu.height
	menu.yScale = (background2.height/6) / menu.height

	menu:addEventListener("tap", onMenu)


	local menu1 = display.newRect( xt, menu.y + menu.height* menu.yScale + 10, display.contentWidth * 0.5, 50)
	menu1.anchorY = 0
	menu1.anchorX = 0
	menu1:setFillColor(127/255,171/255,74/255)
	menu1.alpha = 1

	local teks1 = display.newText( "Pembelian Saya", 10 + xt, 0 + menu1.y + menu1.height/2, used_font, 12  * (display.contentWidth / 320)  )
	teks1.anchorX = 0
	teks1.anchorY = 0.5
	teks1:setFillColor(1)

	


	local menu2 = display.newRect( xt, menu1.y + menu1.height + 5, display.contentWidth * 0.5, 50)
	menu2.anchorY = 0
	menu2.anchorX = 0
	menu2:setFillColor(127/255,171/255,74/255)
	menu2.alpha = 1

	

	local teks2 = display.newText( "Informasi Akun", 10 + xt, 0 + menu2.y + menu2.height/2, used_font, 12  * (display.contentWidth / 320)  )
	teks2.anchorX = 0
	teks2.anchorY = 0.5
	teks2:setFillColor(1)

	local menu3 = display.newRect( xt, menu2.y + menu2.height + 5, display.contentWidth * 0.5, 50)
	menu3.anchorY = 0
	menu3.anchorX = 0
	menu3:setFillColor(127/255,171/255,74/255)
	menu3.alpha = 1

	local teks3 = display.newText( "Logout", 10 + xt, 0 + menu3.y + menu3.height/2, used_font, 12  * (display.contentWidth / 320)  )
	teks3.anchorX = 0
	teks3.anchorY = 0.5
	teks3:setFillColor(1)

	

	


	local function onMenu1(event) 

				self:removeEventListener( "tap", onMenu1 ) 
				composer.halaman_page = 0
	            composer.status_kategori = 1

	            network.cancel( dl_id ) 
		          local i
		          for i = 1 , 75 do
		            local idevent = cancelall[i]
		            network.cancel( idevent)
		            --print("hesemelehe "..cancelall[i])
		          end
		          composer.cancelAllTimers(); 

	            but_menu1(menu1)

	          return true 
	       end 
	       menu1:addEventListener("tap", onMenu1 ) 

	   function but_menu1(self) 
	      
	            if nil~= composer.getScene("test_cart") then composer.removeScene("test_cart", true) end  
	            if  self.type == "press" then 
	                self:setEnabled(false) 
	            else 
	                
	            end 

	            
	            composer.gotoScene( "test_cart" ) 
	   end 



	local function onmenu2(event) 

				self:removeEventListener( "tap", onmenu2 ) 
				composer.halaman_page = 0

				network.cancel( dl_id ) 
		          local i
		          for i = 1 , 75 do
		            local idevent = cancelall[i]
		            network.cancel( idevent)
		            --print("hesemelehe "..cancelall[i])
		          end
		          composer.cancelAllTimers(); 


				composer.status_kategori= 1
	            but_menu2(menu2)
	          return true 
	       end 
	       menu2:addEventListener("tap", onmenu2 ) 

	   function but_menu2(self) 
	      
	            if nil~= composer.getScene("test_informasi") then composer.removeScene("test_informasi", true) end  
	            if  self.type == "press" then 
	                self:setEnabled(false) 
	            else 
	                
	            end 
	            composer.gotoScene( "test_informasi" ) 
	        
	   end 


		local function onmenu3(event) 
				composer.is_login = '0'
		        local tablesetup = [[UPDATE is_login set status_login = '0';]]
				db:exec( tablesetup )
				local tablesetup = [[UPDATE is_login set id_user = '0';]]
				db:exec( tablesetup )

				if nil~= composer.getScene("login_fix") then composer.removeScene("login_fix", true) end  

		        composer.gotoScene( "login_fix" )
       end 
       menu3:addEventListener("tap", onmenu3 ) 

	  

	

	sceneGroup:insert(background)
	sceneGroup:insert(background2)
	sceneGroup:insert(background3)
	sceneGroup:insert(menu)
	sceneGroup:insert(menu1)
	sceneGroup:insert(menu2)
	sceneGroup:insert(menu3)
	
	--[[sceneGroup:insert(menu6)
	sceneGroup:insert(menu7)
	sceneGroup:insert(menu8)--]]
	sceneGroup:insert(teks1)
	sceneGroup:insert(teks2)
	sceneGroup:insert(teks3)
	
	--[[sceneGroup:insert(teks6)
	sceneGroup:insert(teks7)
	sceneGroup:insert(teks8)--]]
	--[[sceneGroup:insert(line)
	sceneGroup:insert(line2)
	sceneGroup:insert(line3)
	sceneGroup:insert(line4)
	sceneGroup:insert(line5)
	sceneGroup:insert(line6)
	sceneGroup:insert(line7)--]]

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