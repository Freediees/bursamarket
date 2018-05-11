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
composer.halaman_page = 0
composer.halaman_berita = 0
composer.version = "15.0"

local cancelall = {}
local began = 1
local loadall = 0
composer.page = 1
local looptimer = 0
local teksfield
cur_page = "home"

require "sqlite3"

local datab = "data.db"
local path = system.pathForFile(datab, system.DocumentsDirectory)
db = sqlite3.open( path )
 


function scene:create( event )

	--local sceneGroup = nil
	local sceneGroup = self.view

	local function dataResponseSlider( event )

          if ( event.isError ) then
            -- TODO Show error here
              --print( "Network error!" )
              --loadIconListener()

          else
            ----print( "App data loaded" )
            listData = json.decode( event.response )
            -- yang ini nerima data json dari server, gampangna mah data dari server d masukin ke array.
            local listData = listData.result
            local data = listData[1]
            print("hehehehe")
            print(event.response)
            data_max = table.getn(listData);
           

           if(tostring(composer.version) ~= tostring(data.version))then
           		local alert = native.showAlert( "Update", "Update terbaru untuk aplikasi bursasajadah sudah dapat didownload pada playstore", { "OK"})
           end

           end
    end

	network.request( "http://api.bursasajadah.com/api/Member/version", "GET", dataResponseSlider )
	
	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.
	
	-- create a white background to fill screen
	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 1 )
	sceneGroup:insert(background)

	local background2 = display.newImageRect( composer.imgDir.. "background_overlay.png", 1080, 1080); 
	background2.x = display.contentCenterX;
	background2.y =  display.contentCenterY - display.contentHeight/10
	background2.anchorY = 0.5
	background2.anchorX = 0.5
	--background2:scale(0.5,0.5)
	background2.xScale = (display.contentHeight) / background2.height
	background2.yScale = (display.contentHeight) / background2.height
	

	local title = display.newImageRect( composer.imgDir.. "title_hitam.png", 1920, 1920); 
	title.x = display.contentCenterX;
	title.y =  display.contentCenterY - display.contentHeight/30
	title.anchorY = 1
	title.anchorX = 0.5
	--title:scale(0.5,0.5)
	title.xScale = (display.contentWidth * 0.8) / title.width
	title.yScale = (display.contentWidth * 0.8) / title.width


	local block1 = display.newImageRect( composer.imgDir.. "haji_umroh.jpg", 1920, 1920); 
	block1.x = display.contentCenterX - display.contentWidth/30;
	block1.y =  title.y + display.contentHeight/10
	block1.anchorY = 1
	block1.anchorX = 1
	--block1:scale(0.5,0.5)
	block1.xScale = (display.contentWidth/3.5) / block1.width
	block1.yScale = (display.contentWidth/3.5) / block1.width


	local block2 = display.newImageRect( composer.imgDir.. "bookmark.jpg", 1920, 1920); 
	block2.x = display.contentCenterX + display.contentWidth/30;
	block2.y =  title.y + display.contentHeight/10
	block2.anchorY = 1
	block2.anchorX = 0
	--block2:scale(0.5,0.5)
	block2.xScale = (display.contentWidth/3.5) / block2.width
	block2.yScale = (display.contentWidth/3.5) / block2.width


	local block3 = display.newImageRect( composer.imgDir.. "info_souvenir.jpg", 1920, 1920); 
	block3.x = display.contentCenterX - display.contentWidth/30;
	block3.y =  block1.y + block1.height*block1.xScale + display.contentHeight/30
	block3.anchorY = 1
	block3.anchorX = 1
	--block3:scale(0.5,0.5)
	block3.xScale = (display.contentWidth/3.5) / block3.width
	block3.yScale = (display.contentWidth/3.5) / block3.width


	local block4 = display.newImageRect( composer.imgDir.. "info_haji.jpg", 1920, 1920); 
	block4.x = display.contentCenterX + display.contentWidth/30;
	block4.y =  block1.y + block1.height*block1.xScale + display.contentHeight/30
	block4.anchorY = 1
	block4.anchorX = 0
	--block4:scale(0.5,0.5)
	block4.xScale = (display.contentWidth/3.5) / block4.width
	block4.yScale = (display.contentWidth/3.5) / block4.width

	-- local teks_1 = display.newText( "PANDUAN IBADAH", display.contentCenterX , display.contentCenterY - display.contentHeight/3, used_font_bold, 20  * (display.contentWidth / 320)  )
	-- teks_1.anchorX = 0.5
	-- teks_1.anchorY = 0
	-- teks_1:setFillColor(0)
	-- teks_1.alpha = 1

	-- local teks_2 = display.newText( "HAJI & UMROH", display.contentCenterX , teks_1.y + teks_1.height + 10, used_font_bold, 35  * (display.contentWidth / 320)  )
	-- teks_2.anchorX = 0.5
	-- teks_2.anchorY = 0
	-- teks_2:setFillColor(0)
	-- teks_2.alpha = 1

	-- local teks_3 = display.newText( "AUDIO & VIDEO", display.contentCenterX , teks_2.y + teks_2.height + 10, used_font_bold, 15  * (display.contentWidth / 320)  )
	-- teks_3.anchorX = 0.5
	-- teks_3.anchorY = 0
	-- teks_3:setFillColor(0)
	-- teks_3.alpha = 1


	-- local block1 = display.newRect( display.contentCenterX - display.contentWidth/30, 200 + display.contentHeight/10, display.contentWidth/3.5, display.contentWidth/3.5)
	-- block1.anchorY = 0
	-- block1.anchorX = 1
	-- block1:setFillColor( 205/255,176/255,48/255)

	-- local block2 = display.newRect( display.contentCenterX + display.contentWidth/30, 200 + display.contentHeight/10, display.contentWidth/3.5, display.contentWidth/3.5)
	-- block2.anchorY = 0
	-- block2.anchorX = 0
	-- block2:setFillColor( 205/255,176/255,48/255)

	-- local block3 = display.newRect( display.contentCenterX - display.contentWidth/30, block1.y + block1.height + display.contentHeight/30, display.contentWidth/3.5, display.contentWidth/3.5)
	-- block3.anchorY = 0
	-- block3.anchorX = 1
	-- block3:setFillColor( 205/255,176/255,48/255)

	-- local block4 = display.newRect( display.contentCenterX + display.contentWidth/30, block1.y + block1.height + display.contentHeight/30, display.contentWidth/3.5, display.contentWidth/3.5)
	-- block4.anchorY = 0
	-- block4.anchorX = 0
	-- block4:setFillColor( 205/255,176/255,48/255)


	function onblock3(self) 
            if nil~= composer.getScene("test_home") then composer.removeScene("test_home", true) end  
            if  self.type == "press" then 
                self:setEnabled(false) 
            else 
                
            end    
            composer.loadScene( "test_home" )
            local function goLoad(event)
            	composer.gotoScene( "test_home" )
        	end
        	timer.performWithDelay(1000, goLoad) 
    end
    block3:addEventListener("tap", onblock3) 


    function onblock1(self) 
            if nil~= composer.getScene("daftar_isi_umroh") then composer.removeScene("daftar_isi_umroh", true) end  
            if  self.type == "press" then 
                self:setEnabled(false) 
            else 
                
            end    
            composer.loadScene( "daftar_isi_haji" )
            local function goLoad(event)
            	composer.gotoScene( "daftar_isi_haji" )
        	end
        	timer.performWithDelay(1000, goLoad) 
    end
    block1:addEventListener("tap", onblock1) 


    function onblock2(self) 
            if nil~= composer.getScene("ceklis1") then composer.removeScene("ceklis1", true) end  
            if  self.type == "press" then 
                self:setEnabled(false) 
            else 
                
            end    
            --composer.loadScene( "ceklis1" ) 

            local function goLoad(event)
            	composer.gotoScene( "ceklis1" )
        	end
        	timer.performWithDelay(1000, goLoad)
    end
    block2:addEventListener("tap", onblock2) 

    function onblock4(self) 
    		composer.halaman_berita = 0
            if nil~= composer.getScene("daftar_berita") then composer.removeScene("daftar_berita", true) end  
            if  self.type == "press" then 
                self:setEnabled(false) 
            else 
                
            end    

            composer.loadScene("daftar_berita")

            local function goLoad(event)
            	composer.gotoScene( "daftar_berita" )
        	end
        	timer.performWithDelay(1000, goLoad)
      --local alert = native.showAlert( "Coming Soon", "Maintenance", { "OK"}) 
    end
    block4:addEventListener("tap", onblock4) 

    local teks_5 = display.newImageRect( composer.imgDir.. "bursasajadah.png", 1920, 252); 
    teks_5.fill.effect = "filter.invert"
	teks_5.x = display.contentCenterX
	teks_5.y =  block4.y + block4.height*block4.xScale
	teks_5.anchorY = 0
	teks_5.anchorX = 0.5
	--teks_5:scale(0.5,0.5)
	teks_5.xScale = (display.contentWidth*0.7) / teks_5.width
	teks_5.yScale = (display.contentWidth*0.7) / teks_5.width


	-- local teks_5 = display.newText( "WWW.BURSASAJADAH.COM", display.contentCenterX , block4.y + block4.height + display.contentHeight/10, used_font_bold, 15  * (display.contentWidth / 320)  )
	-- teks_5.anchorX = 0.5
	-- teks_5.anchorY = 0
	-- teks_5:setFillColor(0)
	-- teks_5.alpha = 1
	-- local logo = display.newImageRect( composer.imgDir.. "logo_overlay.png", 900, 560 ); 
	-- logo.x = display.contentCenterX;
	-- logo.y =  display.contentCenterY - display.contentHeight/10
	-- logo.anchorY = 0.5
	-- logo.anchorX = 0.5
	-- --logo:scale(0.5,0.5)
	-- logo.xScale = (display.contentWidth* 0.7) / logo.width 
	-- logo.yScale = (display.contentWidth * 0.7) / logo.width 

	sceneGroup:insert(background)
	sceneGroup:insert(background2)
	sceneGroup:insert(title)
	-- sceneGroup:insert(teks_2)
	-- sceneGroup:insert(teks_3)
	sceneGroup:insert(teks_5)
	sceneGroup:insert(block1)
	sceneGroup:insert(block2)
	sceneGroup:insert(block3)
	sceneGroup:insert(block4)
	--sceneGroup:insert(logo)


end

function scene:show( event )
	
	composer.removeHidden()
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then

	
	
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then


   
               
    end


end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		

	

          
  --       display.remove(scrollView_banner)  
	
		-- display.remove(scrollView)
		-- display.remove(scrollView2)

		--sceneGroup:removeSelf()

		-- network.cancel( dl_id ) 
  --         local i
  --         for i = 1 , composer.data_max do
  --           local idevent = cancelall[i]
  --           network.cancel( idevent)
  --           print(cancelall[i])
  --         end
  --         composer.cancelAllTimers(); 

		--scrollView2.removeSelf()
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		
		if(sceneGroup ~= nil )then
		sceneGroup:removeSelf()
		sceneGroup = nil
		end
		--display.remove(scrollView)
		--sceneGroup:removeSelf()

		-- network.cancel( dl_id ) 
  --         local i
  --         for i = 1 , composer.data_max do
  --           local idevent = cancelall[i]
  --           network.cancel( idevent)
  --           print(cancelall[i])
  --         end
  --         composer.cancelAllTimers(); 
  -- 		if(teksfield ~= nil)then
		-- 	teksfield:removeSelf()
		-- 	teksfield = nil
		-- end
  		
			
		
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