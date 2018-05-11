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


	local function onMenu()
		-- body
		composer.hideOverlay()
		
	end
	local menu = display.newImageRect( composer.imgDir.. "menu.png", 110, 88 ); 
	menu.x = 0 + 20 ;
	menu.y =  0 + display.contentCenterY / 11
	menu.anchorY = 0.5
	menu.anchorX = 0
	--menu:scale(0.5,0.5)
	menu.xScale = (background2.height/6) / menu.height
	menu.yScale = (background2.height/6) / menu.height

	menu:addEventListener("tap", onMenu)


	local menu1 = display.newRect( 0, menu.y + menu.height* menu.yScale, display.contentWidth * 0.8, 50)
	menu1.anchorY = 0
	menu1.anchorX = 0
	if(composer.status_ceklis == 1)then
		menu1:setFillColor(1, 224/255, 104/255)
	else
		menu1:setFillColor(1)
	end
	menu1.alpha = 1

	local teks1 = display.newText( "Perlengkapan Haji Wanita", 10 , 0 + menu1.y + menu1.height/2, used_font_bold, 15  * (display.contentWidth / 320)  )
	teks1.anchorX = 0
	teks1.anchorY = 0.5
	teks1:setFillColor(0)

	local line = display.newLine( 0, menu1.y + menu1.height, menu1.width, menu1.y + menu1.height )
	line:setStrokeColor( 133/255,190/255,72/255)
	line.strokeWidth = 2
	scrollView:insert(line)


	local menu2 = display.newRect( 0, menu1.y + menu1.height, display.contentWidth * 0.8, 50)
	menu2.anchorY = 0
	menu2.anchorX = 0
	if(composer.status_ceklis == 2)then
		menu2:setFillColor(1, 224/255, 104/255)
	else
		menu2:setFillColor(1)
	end
	menu2.alpha = 1

	local line2 = display.newLine( 0, menu2.y + menu2.height, menu2.width, menu2.y + menu2.height )
	line2:setStrokeColor( 133/255,190/255,72/255)
	line2.strokeWidth = 2
	scrollView:insert(line2)

	local teks2 = display.newText( "Perlengkapan Haji Pria", 10 , 0 + menu2.y + menu2.height/2, used_font_bold, 15  * (display.contentWidth / 320)  )
	teks2.anchorX = 0
	teks2.anchorY = 0.5
	teks2:setFillColor(0)

	local menu3 = display.newRect( 0, menu2.y + menu2.height, display.contentWidth * 0.8, 50)
	menu3.anchorY = 0
	menu3.anchorX = 0
	if(composer.status_ceklis == 3)then
		menu3:setFillColor(1, 224/255, 104/255)
	else
		menu3:setFillColor(1)
	end
	menu3.alpha = 1

	local teks3 = display.newText( "Obat & Vitamin", 10 , 0 + menu3.y + menu3.height/2, used_font_bold, 15  * (display.contentWidth / 320)  )
	teks3.anchorX = 0
	teks3.anchorY = 0.5
	teks3:setFillColor(0)

	local line3 = display.newLine( 0, menu3.y + menu3.height, menu3.width, menu3.y + menu3.height )
	line3:setStrokeColor( 133/255,190/255,72/255)
	line3.strokeWidth = 2
	scrollView:insert(line3)

	local menu4 = display.newRect( 0, menu3.y + menu3.height,display.contentWidth * 0.8, 50)
	menu4.anchorY = 0
	menu4.anchorX = 0
	if(composer.status_ceklis == 4)then
		menu4:setFillColor(1, 224/255, 104/255)
	else
		menu4:setFillColor(1)
	end
	menu4.alpha = 1

	local teks4 = display.newText( "Lain-Lain", 10 , 0 + menu4.y + menu4.height/2, used_font_bold, 15  * (display.contentWidth / 320)  )
	teks4.anchorX = 0
	teks4.anchorY = 0.5
	teks4:setFillColor(0)

	local line4 = display.newLine( 0, menu4.y + menu4.height, menu4.width, menu4.y + menu4.height )
	line4:setStrokeColor( 133/255,190/255,72/255)
	line4.strokeWidth = 2
	scrollView:insert(line4)

	-- local menu5 = display.newRect( 0, menu4.y + menu4.height, display.contentWidth * 0.8, 50)
	-- menu5.anchorY = 0
	-- menu5.anchorX = 0
	-- menu5:setFillColor(1)
	-- menu5.alpha = 1

	-- local teks5 = display.newText( "Logout", 10 , 0 + menu5.y + menu5.height/2, used_font_bold, 15  * (display.contentWidth / 320)  )
	-- teks5.anchorX = 0
	-- teks5.anchorY = 0.5
	-- teks5:setFillColor(0)

	-- local line5 = display.newLine( 0, menu5.y + menu5.height, menu5.width, menu5.y + menu5.height )
	-- line5:setStrokeColor( 133/255,190/255,72/255)
	-- line5.strokeWidth = 2
	-- scrollView:insert(line5)

	-- local menu6 = display.newRect( 0, menu5.y + menu5.height, display.contentWidth * 0.8, 50)
	-- menu6.anchorY = 0
	-- menu6.anchorX = 0
	-- menu6:setFillColor(1)
	-- menu6.alpha = 1

	-- local teks6 = display.newText( "Busana Muslim", 10 , 0 + menu6.y + menu6.height/2, used_font_bold, 15  * (display.contentWidth / 320)  )
	-- teks6.anchorX = 0
	-- teks6.anchorY = 0.5
	-- teks6:setFillColor(0)

	-- local line6 = display.newLine( 0, menu6.y + menu6.height, menu6.width, menu6.y + menu6.height )
	-- line6:setStrokeColor( 133/255,190/255,72/255)
	-- line6.strokeWidth = 2
	-- scrollView:insert(line6)

	-- local menu7 = display.newRect( 0, menu6.y + menu6.height, display.contentWidth * 0.8, 50)
	-- menu7.anchorY = 0
	-- menu7.anchorX = 0
	-- menu7:setFillColor(1)
	-- menu7.alpha = 1

	-- local teks7 = display.newText( "Produk Diskon", 10 , 0 + menu7.y + menu7.height/2, used_font_bold, 15  * (display.contentWidth / 320)  )
	-- teks7.anchorX = 0
	-- teks7.anchorY = 0.5
	-- teks7:setFillColor(0)

	-- local line7 = display.newLine( 0, menu7.y + menu7.height, menu7.width, menu7.y + menu7.height )
	-- line7:setStrokeColor( 133/255,190/255,72/255)
	-- line7.strokeWidth = 2
	-- scrollView:insert(line7)


	-- local menu8 = display.newRect( 0, menu7.y + menu7.height, display.contentWidth * 0.8, 50)
	-- menu8.anchorY = 0
	-- menu8.anchorX = 0
	-- menu8:setFillColor(1)
	-- menu8.alpha = 1

	-- local teks8 = display.newText( "Halaman Konfirmasi", 10 , 0 + menu8.y + menu8.height/2, used_font_bold, 15  * (display.contentWidth / 320)  )
	-- teks8.anchorX = 0
	-- teks8.anchorY = 0.5
	-- teks8:setFillColor(0)


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
	      
	            if nil~= composer.getScene("ceklis1") then composer.removeScene("ceklis1", true) end  
	            if  self.type == "press" then 
	                self:setEnabled(false) 
	            else 
	                
	            end 

	            
	            composer.gotoScene( "ceklis1" ) 
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
	      
	            if nil~= composer.getScene("ceklis2") then composer.removeScene("ceklis2", true) end  
	            if  self.type == "press" then 
	                self:setEnabled(false) 
	            else 
	                
	            end 
	            composer.gotoScene( "ceklis2" ) 
	        
	   end 


	local function onmenu3(event) 
				self:removeEventListener( "tap", onmenu3 ) 
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
	            but_menu3(menu3)
	            composer.id_kategori = 139
	          return true 
	       end 
	       menu3:addEventListener("tap", onmenu3 ) 

	   function but_menu3(self) 
	      
	            if nil~= composer.getScene("ceklis3") then composer.removeScene("ceklis3", true) end  
	            if  self.type == "press" then 
	                self:setEnabled(false) 
	            else 
	                
	            end 
	            composer.gotoScene( "ceklis3" ) 
	        
	   end 

	local function onmenu4(event)
				self:removeEventListener( "tap", onmenu4 ) 
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
	            but_menu4(menu4)
	            composer.id_kategori = 61
	          return true 
	       end 
	       menu4:addEventListener("tap", onmenu4 ) 

	   function but_menu4(self) 
	      
	            if nil~= composer.getScene("ceklis4") then composer.removeScene("ceklis4", true) end  
	            if  self.type == "press" then 
	                self:setEnabled(false) 
	            else 
	                
	            end 
	            composer.gotoScene( "ceklis4" ) 
	        
	   end 


	-- local function onmenu5(event) 
	-- 			composer.halaman_page = 0
	-- 			self:removeEventListener( "tap", onmenu5 ) 
				
				
	--             but_menu5(menu5)
	--           return true 
	--        end 
	--        menu5:addEventListener("tap", onmenu5 ) 

	--    function but_menu5(self) 
	      
	--             composer.is_login = 0
	-- 	        local tablesetup = [[UPDATE is_login set status_login = '0';]]
	-- 			db:exec( tablesetup )
	-- 			local tablesetup = [[UPDATE is_login set id_user = '0';]]
	-- 			db:exec( tablesetup )

	-- 			if nil~= composer.getScene("home") then composer.removeScene("home", true) end  

	-- 	        composer.gotoScene( "home" )
    	 
	        
	--    end 

	-- local function onmenu6(event) 
	-- 			composer.halaman_page = 0
	-- 			self:removeEventListener( "tap", onmenu6 )
	-- 			for i = 1 , 75 do
	-- 	            local idevent = cancelall[i]
	-- 	            network.cancel( idevent)
	-- 	            --print("hesemelehe "..cancelall[i])
	-- 	          end
	-- 	          composer.cancelAllTimers();

	-- 			composer.status_kategori= 1 
	--             but_menu6(menu6)
	--             composer.id_kategori = 61
	--           return true 
	--        end 
	--        menu6:addEventListener("tap", onmenu6 ) 

	--    function but_menu6(self) 
	      
	--             if nil~= composer.getScene("menu6") then composer.removeScene("menu6", true) end  
	--             if  self.type == "press" then 
	--                 self:setEnabled(false) 
	--             else 
	                 
	--             end 
	--             composer.gotoScene( "menu6" ) 
	        
	--    end 



	-- local function onmenu7(event) 
	-- 			composer.halaman_page = 0
	-- 			self:removeEventListener( "tap", onmenu7 ) 
	-- 			for i = 1 , 75 do
	-- 	            local idevent = cancelall[i]
	-- 	            network.cancel( idevent)
	-- 	            --print("hesemelehe "..cancelall[i])
	-- 	          end
	-- 	          composer.cancelAllTimers();

	--             but_menu7(menu7)
	--             composer.id_kategori = 61
	--             composer.status_kategori = 1
	--           return true 
	--        end 
	--        menu7:addEventListener("tap", onmenu7 ) 

	--    function but_menu7(self) 
	      
	--             if nil~= composer.getScene("menu7") then composer.removeScene("menu7", true) end  
	--             if  self.type == "press" then 
	--                 self:setEnabled(false) 
	--             else 
	                
	--             end 
	--             composer.gotoScene( "menu7" ) 
	        
	--    end 


	-- local function onmenu8(event) 
	-- 			composer.halaman_page = 0
	-- 			self:removeEventListener( "tap", onmenu8 ) 
	-- 			for i = 1 , 75 do
	-- 	            local idevent = cancelall[i]
	-- 	            network.cancel( idevent)
	-- 	            --print("hesemelehe "..cancelall[i])
	-- 	          end
	-- 	          composer.cancelAllTimers();

	--             but_menu8(menu8)
	--             composer.id_kategori = 61
	--             composer.status_kategori = 1
	--           return true 
	--        end 
	--        menu8:addEventListener("tap", onmenu8 ) 

	--    function but_menu8(self) 
	      
	--             if nil~= composer.getScene("konfirmasi") then composer.removeScene("konfirmasi", true) end  
	--             if  self.type == "press" then 
	--                 self:setEnabled(false) 
	--             else 
	                
	--             end 
	--             composer.gotoScene( "konfirmasi" ) 
	        
	--    end 

	sceneGroup:insert(background)
	sceneGroup:insert(background2)
	sceneGroup:insert(menu)
	sceneGroup:insert(menu1)
	sceneGroup:insert(menu2)
	sceneGroup:insert(menu3)
	sceneGroup:insert(menu4)
	-- sceneGroup:insert(menu5)
	-- sceneGroup:insert(menu6)
	-- sceneGroup:insert(menu7)
	-- sceneGroup:insert(menu8)
	sceneGroup:insert(teks1)
	sceneGroup:insert(teks2)
	sceneGroup:insert(teks3)
	sceneGroup:insert(teks4)
	-- sceneGroup:insert(teks5)
	-- sceneGroup:insert(teks6)
	-- sceneGroup:insert(teks7)
	-- sceneGroup:insert(teks8)
	sceneGroup:insert(line)
	sceneGroup:insert(line2)
	sceneGroup:insert(line3)
	sceneGroup:insert(line4)
	-- sceneGroup:insert(line5)
	-- sceneGroup:insert(line6)
	-- sceneGroup:insert(line7)

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