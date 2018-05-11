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
composer.halaman_page = 0
local cancelall = {}
local began = 1
local loadall = 0
composer.page = 1
local looptimer = 0
local teksfield
cur_page = "daftar_isi"

composer.status_ceklis = 2

require "sqlite3"

local datab = "data.db"
local path = system.pathForFile(datab, system.DocumentsDirectory)
db = sqlite3.open( path )
 


function scene:create( event )

	--local sceneGroup = nil
	local sceneGroup = self.view


	
	
	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.
	
	-- create a white background to fill screen
	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 1 )	-- white
	

	local background2 = display.newRect( display.contentCenterX, 0, display.contentWidth, display.contentHeight/5)
	background2.anchorY = 0
	background2:setFillColor( 203/255,176/255,45/255)
	
	-- local under = display.newRect( display.contentWidth, background2.y + background2.height, display.contentWidth/2, 5)
	-- under.anchorY = 1
	-- under.anchorX = 1
	-- under:setFillColor(1)


	local function onMenu()
		
		local options_overlay =
		{
		    isModal = true,
		    effect = "fade",
		    time = 400,
		    params = {
		        sampleVar1 = "my sample variable",
		        sampleVar2 = "another sample variable"
		    }
		}

		composer.showOverlay("overlay_menu3", options_overlay)
	end


	local menu = display.newImageRect( composer.imgDir.. "menu.png", 110, 88 ); 
	menu.x = 0 + 20 ;
	menu.y =  background2.y + background2.height/2
	menu.anchorY = 0.5
	menu.anchorX = 0
	--menu:scale(0.5,0.5)
	menu.xScale = (background2.height/6) / menu.height
	menu.yScale = (background2.height/6) / menu.height

	menu:addEventListener("tap", onMenu)

	local teks_daftar_isi = display.newText( "Perlengkapan Haji Pria", menu.x + display.contentWidth/8 , menu.y , used_font_bold, 20  * (display.contentWidth / 320)  )
	teks_daftar_isi.anchorX = 0
	teks_daftar_isi.anchorY = 0.5
	teks_daftar_isi.alpha = 1

	-- local teks_umroh = display.newText( "Umroh", menu.x + display.contentWidth/8 , menu.y , used_font_bold, 15  * (display.contentWidth / 320)  )
	-- teks_umroh.x = 0.25 * display.contentWidth
	-- teks_umroh.anchorX = 0.5
	-- teks_umroh.y = background2.y + background2.height - 5
	-- teks_umroh.anchorY = 1
	-- teks_umroh.alpha = 1


	-- function onteks_umroh(self) 
 --            if nil~= composer.getScene("daftar_isi_umroh") then composer.removeScene("daftar_isi_umroh", true) end  
 --            if  self.type == "press" then 
 --                self:setEnabled(false) 
 --            else 
                
 --            end    
 --            composer.gotoScene( "daftar_isi_umroh" ) 
 --    end
 --    teks_umroh:addEventListener("tap", onteks_umroh) 

	-- local teks_haji = display.newText( "Haji", menu.x + display.contentWidth/8 , menu.y , used_font_bold, 15  * (display.contentWidth / 320)  )
	-- teks_haji.x = 0.75 * display.contentWidth
	-- teks_haji.anchorX = 0.5
	-- teks_haji.y = background2.y + background2.height - 5
	-- teks_haji.anchorY = 1
	-- teks_haji.alpha = 1

	-- local logo = display.newImageRect( composer.imgDir.. "logo.png", 125, 39 ); 
	-- logo.x = display.contentCenterX;
	-- logo.y =  0 + display.contentCenterY / 11
	-- logo.anchorY = 0.5
	-- --logo:scale(0.5,0.5)
	-- logo.xScale = (display.contentWidth/4) / logo.width 
	-- logo.yScale = (display.contentWidth/4) / logo.width 


	composer.tinggi_header = background2.height
	
	scrollView = widget.newScrollView(
	    {
	        top = 0 + composer.tinggi_header,
	        left = 0,
	        width = display.contentWidth,
	        height = display.contentHeight - composer.tinggi_header,
	        horizontalScrollDisabled = true,
	        isBounceEnabled = false,
	        --backgroundColor = {0,0.4, 0.1, 1}
	        --scrollWidth = 600,
	        --scrollHeight = 2000,
	        --listener = scrollListener

	    }
	)


	
	
    
	local tinggi_option = 20
	
	for row in db:nrows("SELECT * FROM t_ceklis2") do
	  
		--print(row.value)
		--print(row.status)

		local option1 = display.newText( row.value, display.contentWidth/15 , tinggi_option , used_font_bold, 12  * (display.contentWidth / 320)  )
		option1.anchorX = 0
		option1.anchorY = 0
		option1:setFillColor(0)

		local option1_back = display.newRect( 0, option1.y + 10, display.contentWidth, display.contentHeight/20)
		option1_back.anchorX = 0
		option1_back.anchorY = 0.5
		option1_back:setFillColor( 1)
		
		scrollView:insert(option1_back)
		scrollView:insert(option1)

		local cek = display.newImageRect( composer.imgDir.. "cek1.png", 200, 200 ); 
		cek.x = display.contentWidth - 20 ;
		cek.y =  option1.y
		cek.anchorY = 0.5
		cek.anchorX = 1
		cek.alpha = 0
		cek.xScale = (option1_back.height - option1_back.height*0.1) / cek.height
		cek.yScale = (option1_back.height - option1_back.height*0.1) / cek.height
		scrollView:insert(cek)


		local garis3 = display.newLine( 0, option1_back.y + option1_back.height/2 - 2, display.contentWidth, option1_back.y + option1_back.height/2 - 2)
		garis3:setStrokeColor( 0)
		garis3.strokeWidth = 1
		scrollView:insert(garis3)

		local status_cek = 0
		if(row.status == '1')then

			cek.alpha = 1
			status_cek = 1

		end

		print("sattus skrg "..status_cek)

		function on_option1(self) 
				--print("jadi nol")
				
			if(status_cek == 1)then
				print("sattus skrg "..status_cek)

				local tablesetup = [[UPDATE t_ceklis2 SET status = '0' where value = ']]..row.value..[[';]]
				db:exec(tablesetup)

			    cek.alpha = 0
			    status_cek = 0
			else
				print("sattus skrg "..status_cek)

				local tablesetup = [[UPDATE t_ceklis2 SET status = '1' where value = ']]..row.value..[[';]]
				db:exec(tablesetup)

			    cek.alpha = 1
			    status_cek = 1

			end
			
	    end
	    option1_back:addEventListener("tap", on_option1)

	    

	    tinggi_option = option1.y + option1.height + display.contentHeight/25

	end


	local background_checkout = display.newRect( display.contentCenterX, tinggi_option + display.contentHeight/20, display.contentWidth * 0.9, 50)
	background_checkout.anchorY = 0.5
	background_checkout.anchorX = 0.5
	background_checkout:setFillColor( 133/255,190/255,72/255)
	scrollView:insert(background_checkout)

	local teks_email = display.newText( "Tambah Perlengkapan", background_checkout.x, background_checkout.y , used_font_bold, 12  * (display.contentWidth / 320))
	teks_email.anchorX = 0.5
	teks_email:setFillColor(1)
	scrollView:insert(teks_email)

	local under2 = display.newRect( display.contentWidth, background_checkout.y + background_checkout.height + 50, display.contentWidth/2, 5)
	under2.anchorY = 1
	under2.anchorX = 1
	under2:setFillColor(1)
	scrollView:insert(under2)

	local function tambah_perlengkapan()
		local options_overlay =
		{
		    isModal = true,
		    effect = "fade",
		    time = 400,
		    params = {
		        sampleVar1 = "my sample variable",
		        sampleVar2 = "another sample variable"
		    }
		}

		composer.showOverlay("overlay_popup2", options_overlay)
	end
	background_checkout:addEventListener("tap", tambah_perlengkapan)


	-- all objects must be added to group (e.g. self.view)
	sceneGroup:insert( background )
	sceneGroup:insert( background2 )
	sceneGroup:insert(menu)
	sceneGroup:insert(teks_daftar_isi)
	-- sceneGroup:insert(teks_umroh)
	-- sceneGroup:insert(teks_haji)
	--sceneGroup:insert(under)
	sceneGroup:insert(scrollView)


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
		

	

          
        display.remove(scrollView_banner)  
	
		display.remove(scrollView)
		display.remove(scrollView2)

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
  		if(teksfield ~= nil)then
			teksfield:removeSelf()
			teksfield = nil
		end
  		
			
		
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