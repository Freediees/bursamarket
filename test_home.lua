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
local cancelall = {}
local cancelprodukterbaru = {}
local cancelsajadah = {}
local cancelbanner = {}
local cancelmakanan = {}
local cancelolehhaji = {}
local cancelperlengkapanmuslim = {}
local cancelbusanamuslim = {}
local cancelperlengkapanhaji = {}
local began = 1
local loadall = 0
composer.page = 1
local teks_diskon
local teks_diskonnya = {"Oleh - Oleh Paket Hemat","Sajadah & Karpet", "Oleh - Oleh Kacang Arab", "Oleh - Oleh Buah Tin & Kismis","Oleh - Oleh Souvenir", "Perlengkapan Muslim","Perlengkapan Haji"}
local looptimer = 0
local teksfield
local status_back = 0
local total_load = 70
cur_page = "view1"
local teks_search
local grup_menu = display.newGroup()

local status_header = 1

local grup1 = display.newGroup()
local grup2 = display.newGroup()
local grup3 = display.newGroup()
local grup4 = display.newGroup()
local grup5 = display.newGroup()
local grup6 = display.newGroup()
local grup7 = display.newGroup()

composer.posisi_x1 = display.contentCenterX - display.contentWidth/30
	composer.posisi_x2 = display.contentCenterX + display.contentWidth/30
	composer.posisi_y = 0

require "sqlite3"

local datab = "data.db"
local path = system.pathForFile(datab, system.DocumentsDirectory)
db = sqlite3.open( path )



function scene:create( event )

	local lfs = require( "lfs" )
 
	local doc_path = system.pathForFile( "", system.TemporaryDirectory )
	 
	for file in lfs.dir( doc_path ) do
	    local destDir = system.TemporaryDirectory  -- Location where the file is stored
        os.remove( system.pathForFile( file , destDir ) )
	end

	--local sceneGroup = nil
	local sceneGroup = self.view
	composer.temp_x = 0 + display.contentWidth/20
	composer.gambar_iklan = 1
	composer.temp_x1 = 0 + display.contentWidth/20
	composer.gambar_iklan_sajadah = 1
	composer.temp_x2 = 0 + display.contentWidth/20
	composer.gambar_iklan_makanan = 1
	composer.temp_x3 = 0 + display.contentWidth/20
	composer.gambar_iklan_olehhaji = 1
	composer.temp_x4 = 0 + display.contentWidth/20
	composer.gambar_iklan_busanamuslim = 1
	composer.temp_x5 = 0 + display.contentWidth/20
	composer.gambar_iklan_perlengkapanmuslim = 1
	composer.temp_x6 = 0 + display.contentWidth/20
	composer.gambar_iklan_perlengkapanhaji = 1
	
	composer.halaman_menu1 = 1
	composer.halaman_menu2 = 1
	composer.halaman_menu3 = 1
	composer.halaman_menu4 = 1
	composer.halaman_menu5 = 1
	composer.halaman_menu6 = 1
	composer.halaman_menu7 = 1


	
	
	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', alinedd touch listeners, etc.
	
	-- create a white background to fill screen
	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor(230/255, 230/255, 230/255 )	-- white
	

	--[[local background2 = display.newRect( display.contentCenterX, 0, display.contentWidth, display.contentHeight/5)
	background2.anchorY = 0
	background2:setFillColor( 133/255,190/255,72/255)--]]

	local background2 = display.newRect( display.contentCenterX, 0, display.contentWidth, display.contentHeight/8)
	background2.anchorY = 0
	background2:setFillColor( 1)
	

	local logo = display.newImageRect( composer.imgDir.. "logo_home.png", 125, 45 ); 
	logo.x = display.contentCenterX;
	logo.y =  0 + background2.height/2
	logo.anchorY = 0.5
	--logo:scale(0.5,0.5)
	logo.xScale = (display.contentWidth/4) / logo.width 
	logo.yScale = (display.contentWidth/4) / logo.width 


	local function onMenu()
		if(teksfield ~= nil)then
			teksfield:removeSelf()
			teksfield = nil
		end

		local options_overlay =
		{
		    isModal = true,
		    effect = "fromLeft",
		    time = 400,
		    params = {
		        sampleVar1 = "my sample variable",
		        sampleVar2 = "another sample variable"
		    }
		}

		composer.showOverlay("overlay_menu", options_overlay)
	end
	local menu = display.newImageRect( composer.imgDir.. "menu_hijau.png", 110,88 ); 
	menu.x = 0 + 20 ;
	menu.y =  0 + background2.height/2
	menu.anchorY = 0.5
	menu.anchorX = 0
	--menu:scale(0.5,0.5)
	menu.xScale = (background2.height/4) / menu.height
	menu.yScale = (background2.height/4) / menu.height



	local lingkaran_profile = display.newImage(composer.imgDir.."man.png", display.contentWidth - 20 , background2.height/2)
	
	lingkaran_profile.anchorX = 1
	lingkaran_profile.xScale = (background2.height/4) / menu.height
	lingkaran_profile.yScale = (background2.height/4) / menu.height
	menu:addEventListener("tap", onMenu)
	
	

	

	function onLogoView( event )

		composer.gotoScene( "test_home" )
	end
	--logo:addEventListener("tap", onLogoView )
	
	-- create some text



 --    function onSecondView( event )
	-- 	composer.gotoScene( "test_detail" )
	-- end
 --    title:addEventListener("tap", onSecondView ) 



   

 	

	local function showMenu()
		

		print(composer.is_login)
		if(composer.is_login == '0')then
			if nil~= composer.getScene("login_fix") then composer.removeScene("login_fix", true) end
			composer.gotoScene("login_fix")
			composer.masuk = 0
		else


			local options_overlay =
			{
			    isModal = true,
			    effect = "fromRight",
			    time = 400,
			    params = {
			        sampleVar1 = "my sample variable",
			        sampleVar2 = "another sample variable"
			    }
			}

		
		composer.showOverlay("overlay_login", options_overlay)

			--[[if(grup_menu.alpha == 1)then
			grup_menu.alpha = 0
			else
			grup_menu.alpha = 1
			end--]]

		end
	end
	
	lingkaran_profile:addEventListener("tap", showMenu)

	

	function onLogoutView( event )


		logout:removeEventListener("tap", onLogoutView )

		composer.is_login = '0'
        local tablesetup = [[UPDATE is_login set status_login = '0';]]
		db:exec( tablesetup )
		local tablesetup = [[UPDATE is_login set id_user = '0';]]
		db:exec( tablesetup )

		if nil~= composer.getScene("login_fix") then composer.removeScene("login_fix", true) end  

        composer.gotoScene( "login_fix" )
    	
   
	end

	

	
	composer.tinggi_teksfield = background2.height + display.contentHeight/30

	local function createteksfield()

    	
		teks_search.text = ""

    	teksfield = native.newTextField(  display.contentCenterX , composer.tinggi_teksfield , 0.85 * display.contentWidth, 30 )
		teksfield.anchorX = 0.5
		teksfield.alpha = 1
		teksfield.font = native.newFont( used_font, 12  * (display.contentWidth / 320) )
		teksfield.hasBackground = false
		teksfield.size = 12  * (display.contentWidth / 320)
		teksfield:resizeHeightToFitFont()
		sceneGroup:insert( teksfield )

		native.setKeyboardFocus( teksfield )


		local function fieldHandler_t(event) 
               if ("began" == event.phase) then 
                  if name ~= nil then
                    --name:removeSelf()
                    --name = nil
                  end
               elseif ("ended" == event.phase) then 
                  
                  if(teksfield ~= nil)then
                  composer.search = teksfield.text
                  teks_search.text = teksfield.text
                  teksfield:removeSelf()
                  teksfield = nil
              	  end
              	  native.setKeyboardFocus(nil) 

               elseif ("submitted" == event.phase) then  
                  composer.search = teksfield.text
                  teks_search.text = teksfield.text

                  onLoginView()

                  native.setKeyboardFocus(nil)
                elseif ( event.phase == "editing" ) then
                  
                  composer.search = teksfield.text

                end  
         end 

        teksfield:addEventListener( "userInput", fieldHandler_t )

    end


		local myRectangle1 = display.newRoundedRect( display.contentCenterX, composer.tinggi_teksfield , 0.9 * display.contentWidth, 30, 5)
		myRectangle1.strokeWidth = 0
		myRectangle1.anchorX = 0.5
		myRectangle1.anchorY = 0.5
		myRectangle1:setFillColor( 1 )
		myRectangle1:setStrokeColor(1 )
		

		myRectangle1:addEventListener("tap", createteksfield)


		teks_search = display.newText( "Cari Produk Disini", myRectangle1.x - myRectangle1.width/2 + 20, myRectangle1.y , used_font, 10  * (display.contentWidth / 320))
		teks_search.anchorX = 0
		teks_search:setFillColor(0)
		


        --[[local myRectangle = display.newRect( display.contentWidth, composer.tinggi_teksfield, 0.1 * display.contentWidth, 30 )
		myRectangle.strokeWidth = 0
		myRectangle.anchorX = 1
		myRectangle:setFillColor( 244/255,209/255,66/255 )
		myRectangle:setStrokeColor( 1, 0, 0 )
		

		local search = display.newImageRect( composer.imgDir.. "search.png", 1260, 916 ); 
		search.x = myRectangle.x - myRectangle.width / 2;
		search.y = myRectangle.y
		search.anchorY = 0.5
		--search:scale(0.5,0.5)
		search.xScale = (0.9 * myRectangle.height) / search.width 
		search.yScale = (0.9 * myRectangle.height) / search.width --]]
		

		function onLoginView( event )
		
		  --search:removeEventListener("tap", onLoginView )
		--title:setFillColor( 1 )	-- black
		  if(teksfield ~= nil)then
	      teksfield:removeSelf()
	      teksfield = nil
	  	  end


			if(composer.search ~= nil)then
			if nil~= composer.getScene("test_search") then composer.removeScene("test_search", true) end  
	        if  self.type == "press" then 
	            self:setEnabled(false) 
	        else 
	            --self:removeEventListener( "tap", onMenu1 ) 
	        end 
	        composer.gotoScene( "test_search" ) 
	   		end
		end
	


	


	
	composer.tinggi_teksfield = background2.height + display.contentHeight/30

	composer.tinggi_header = composer.tinggi_teksfield + display.contentHeight/30


	local function scrollListener2( event )
 
	    local phase = event.phase
	    if ( phase == "began" ) then
 	  	 scrollView:takeFocus(event)
	    elseif ( phase == "moved" ) then
	    elseif ( phase == "ended" ) then
	    end
	 
	    -- In the event a scroll limit is reached...
	    if ( event.limitReached ) then
	        if ( event.direction == "up" ) then 
	        elseif ( event.direction == "down" ) then print( "Reached top limit" )
	        elseif ( event.direction == "left" ) then print( "Reached right limit" )
	        elseif ( event.direction == "right" ) then print( "Reached left limit" )
	        end
	    end
 
    return true
		end

	local function scrollListener( event )
 		
	   local phase = event.phase
	    if ( phase == "began" ) then
	    elseif ( phase == "moved" ) then
 	   --scrollView:takeFocus(event)
	    elseif ( phase == "ended" ) then
	    end
	 
	    -- In the event a scroll limit is reached...
	    if ( event.limitReached ) then
	        if ( event.direction == "up" ) then print( "Reached bottom limit" )
	        elseif ( event.direction == "down" ) then print( "Reached top limit" )
	        elseif ( event.direction == "left" ) then print( "Reached right limit" )
	        elseif ( event.direction == "right" ) then print( "Reached left limit" )
	        end
	    end
 
    return true
	end


	local function scrollListenerBanner( event )
 		
	   local phase = event.phase
	    if ( phase == "began" ) then
	    elseif ( phase == "moved" ) then

		        -- If the touch on the button has moved more than 10 pixels,
		        -- pass focus back to the scroll view so it can continue scrolling
		        

 	   --scrollView:takeFocus(event)
	    elseif ( phase == "ended" ) then
	    	local dy = ( event.x - event.xStart ) 
	    	if ( dy > 50 ) then
		            --scrollView:takeFocus( event )
		            print(dy)
		            swipeRight()
		        elseif ( dy < -50 ) then
		        	swipeLeft()
		        	print(dy)
		        end
	    end
	 
	    -- In the event a scroll limit is reached...
	    if ( event.limitReached ) then
	        if ( event.direction == "up" ) then print( "Reached bottom limit" )
	        elseif ( event.direction == "down" ) then print( "Reached top limit" )
	        elseif ( event.direction == "left" ) then print( "Reached right limit" )
	        elseif ( event.direction == "right" ) then print( "Reached left limit" )
	        end
	    end
 
    return true
	end


	scrollView = widget.newScrollView(
	    {
	        top = 0 + composer.tinggi_header,
	        left = 0,
	        width = display.contentWidth,
	        height = display.contentHeight - composer.tinggi_header,
	        horizontalScrollDisabled = true,
	        isBounceEnabled = false,
	        backgroundColor = {240/255,240/255,240/255},
	        --backgroundColor = {230/255, 230/255, 230/255},
	        --scrollWidth = 600,
	        --scrollHeight = 2000,
	        listener = scrollListener

	    }
	)

	

	--composer.tinggi_teksfield = logo.y + logo.height + display.contentHeight / 100 
	

	

	




	  -- myImage.width = 808
   --    myImage.height = 400
   --    myImage.xScale = (display.contentWidth) / 808
   --    myImage.yScale = (display.contentWidth) / 808


	scrollView_banner = widget.newScrollView(
	    {
	        top = 0,
	        left = 0,
	        width = display.contentWidth,
	        height = 400 * (display.contentWidth) / 808,
	        horizontalScrollDisabled = false,
	        verticalScrollDisabled = false,
	        --backgroundColor = {133/255,190/255,72/255},
	        isBounceEnabled = false,
	        --scrollWidth = 600,
	        scrollHeight = 1,

	        listener = scrollListenerBanner

	    }
	)
	scrollView_banner:setIsLocked(true)
	


	function swipeLeft()

		if(looptimer < composer.data_max_slider)then
		scrollView_banner:scrollToPosition
		{
			x = display.contentWidth * (-looptimer)
		}
		end

		----print("looping : "..display.contentWidth * looptimer)

			if(looptimer == composer.data_max_slider)then
				looptimer = 0
			else
				looptimer = looptimer + 1
			end
	end

	function swipeRight()
		print("Looptimer : "..looptimer)
		if(looptimer > 0)then
		scrollView_banner:scrollToPosition
		{
			x = display.contentWidth * (-1*(looptimer-2))
		}
		end

		----print("looping : "..display.contentWidth * looptimer)

			if(looptimer == composer.data_max_slider)then
				--looptimer = 0
			elseif(looptimer == 0)then
				looptimer = composer.data_max_slider
			else
				looptimer = looptimer - 1
			end
	end

	function timerslider()

		if(looptimer < composer.data_max_slider)then
		scrollView_banner:scrollToPosition
		{
			x = display.contentWidth * (-looptimer)
		}
		end

		----print("looping : "..display.contentWidth * looptimer)

			if(looptimer == composer.data_max_slider)then
				looptimer = 0
			else
				looptimer = looptimer + 1
			end
	end
	id_timer = timer.performWithDelay(5000, timerslider, -1)


	scrolltest_detail = widget.newScrollView(
	    {
	        top = scrollView_banner.height,
	        left = 0,
	        width = display.contentWidth,
	        height = display.contentHeight / 10,
	        horizontalScrollDisabled = false,
	        verticalScrollDisabled = true,
	        backgroundColor = {220/255,220/255,220/255},
	        --backgroundColor = {120/255,190/255,72/255},
	        isBounceEnabled = false,
	        --scrollWidth = 600,
	        --scrollHeight = 2000,
	        --listener = scrollListener

	    }
	)

	scrollView:insert(scrolltest_detail)

	local kotak={}
	local gambar={}
	local i
	local x = 0
	for i=1,7 do

	kotak[i] = display.newRect(x, scrolltest_detail.height/2, display.contentWidth/3, scrolltest_detail.height)
	if(i == 1)then
	kotak[i]:setFillColor(248/255,248/255,248/255)
	else
	kotak[i]:setFillColor(230/255,230/255,230/255)
	end
	kotak[i].anchorX = 0
	scrolltest_detail:insert(kotak[i])

	gambar[i] = display.newImageRect( composer.imgDir.. "tab"..i..".png", 215,89 ); 
	gambar[i].x = kotak[i].x + kotak[i].width/2
	gambar[i].y = kotak[i].y
	gambar[i].xScale = (kotak[i].width) / 215
    gambar[i].yScale = (kotak[i].width) / 215
	scrolltest_detail:insert(gambar[i])
	gambar[i].anchorX = 0.5


	local function onklik()
			--print(i)
			-- scrollView_menu1.x = scrollView_menu1.x - scrollView_menu1.width
			-- scrollView_menu2.x = scrollView_menu2.x - scrollView_menu2.width

			--[[grup1.x = grup1.x - display.contentWidth*1
			grup2.x = grup2.x - display.contentWidth*1--]]

			local count = 0
			local function count_move()

				transition.moveTo( grup1, {x= grup1.x - display.contentWidth*count, time=200})
				transition.moveTo( grup2, {x= grup2.x - display.contentWidth*count, time=200})
				transition.moveTo( grup3, {x= grup3.x - display.contentWidth*count, time=200})
				transition.moveTo( grup4, {x= grup4.x - display.contentWidth*count, time=200})
				transition.moveTo( grup5, {x= grup5.x - display.contentWidth*count, time=200})
				transition.moveTo( grup6, {x= grup6.x - display.contentWidth*count, time=200})
				transition.moveTo( grup7, {x= grup7.x - display.contentWidth*count, time=200})

			end

			--print(table.concat(teks_diskonnya,"",i,i))
			teks_diskon.text = table.concat(teks_diskonnya,"",i,i)
			--print(teks_diskon[0])
			
			count = i - status_header
			count_move()


			local j = 0
			for j=1, 7 do
				--print(j)

				if(j==i)then
						kotak[j]:setFillColor(248/255, 248/255, 248/255)
				else
						kotak[j]:setFillColor(230/255,230/255,230/255)
				end
				--kotak[j]:setFillColor(0)
			end

			status_header = i

	end
	kotak[i]:addEventListener("tap",onklik)

	x= x + kotak[i].width + 2

	end

	


	scrollView:insert(scrollView_banner)
	teks_diskon = display.newText( "Oleh - Oleh Paket Hemat", display.contentCenterX, scrollView_banner.y + scrollView_banner.height/2 +  scrolltest_detail.height + 20, used_font, 15  * (display.contentWidth / 320))
	teks_diskon.anchorX = 0.5
	teks_diskon.anchorY = 0
	teks_diskon:setFillColor(0)
	scrollView:insert(teks_diskon)
	composer.tinggi_line2 = teks_diskon.y

	local line2 = display.newLine( 0 + 0.05 * display.contentWidth, teks_diskon.y + display.contentHeight/40 + 3, display.contentWidth - display.contentWidth*0.05, teks_diskon.y + display.contentHeight/40 + 3 )
	line2:setStrokeColor( 133/255,190/255,72/255)
	line2.strokeWidth = 2
	scrollView:insert(line2)
	composer.tinggi_line2 = line2.y + display.contentHeight/30


	grup1.y = composer.tinggi_line2
	grup1.x = 0
	grup1.width = display.contentWidth
	
	grup2.y = composer.tinggi_line2
	grup2.x = display.contentWidth*1
	grup2.width = display.contentWidth

	grup3.y = composer.tinggi_line2
	grup3.x = display.contentWidth*2
	grup3.width = display.contentWidth

	grup4.y = composer.tinggi_line2
	grup4.x = display.contentWidth*3
	grup4.width = display.contentWidth

	grup5.y = composer.tinggi_line2
	grup5.x = display.contentWidth*4
	grup5.width = display.contentWidth

	grup6.y = composer.tinggi_line2
	grup6.x = display.contentWidth*5
	grup6.width = display.contentWidth

	grup7.y = composer.tinggi_line2
	grup7.x = display.contentWidth*6
	grup7.width = display.contentWidth
	


	--[[
	scrollView_menu2 = widget.newScrollView(
	    {
	      	top = teks_diskon.y + teks_diskon.height ,
	        left = display.contentWidth,
	        width = display.contentWidth,
	        --height = 2000,
	        horizontalScrollDisabled = true,
	        --verticalScrollDisabled = true,
	        isBounceEnabled = true,
	      --  backgroundColor = {0},
	        listener = scrollListener

	    }
	)
	
	scrollView:insert(scrollView_menu2)--]]


	--[[local teks_sajadah_karpet = display.newText( "Sajadah & Karpet", display.contentCenterX, teks_diskon.y + scrollView_menu1.height  , used_font, 15  * (display.contentWidth / 320))
	teks_sajadah_karpet.anchorX = 0.5
	teks_sajadah_karpet:setFillColor(0)
	scrollView:insert(teks_sajadah_karpet)
	--composer.tinggi_line2 = teks_sajadah_karpet.y

	local line2 = display.newLine( 0 + 0.05 * display.contentWidth, teks_sajadah_karpet.y + display.contentHeight/40, display.contentWidth - display.contentWidth*0.05, teks_sajadah_karpet.y + display.contentHeight/40 )
	line2:setStrokeColor( 133/255,190/255,72/255)
	line2.strokeWidth = 2
	scrollView:insert(line2)
	composer.tinggi_line2 = line2.y

	scrollView_menu2 = widget.newScrollView(
	    {
	        top = teks_sajadah_karpet.y + display.contentHeight/30,
	        left = 0,
	        width = display.contentWidth,
	        height = 900 * ((0.45 * display.contentHeight) / 900),
	        horizontalScrollDisabled = false,
	        verticalScrollDisabled = true,
	        --backgroundColor = {133/255,190/255,72/255},
	        isBounceEnabled = false,
	        --scrollWidth = 600,
	        --scrollHeight = 2000,
	        listener = scrollListener

	    }
	)
	scrollView:insert(scrollView_menu2)



	local teks_makanan = display.newText( "Oleh - Oleh Kacang Arab", display.contentCenterX, teks_sajadah_karpet.y + scrollView_menu2.height  , used_font, 15  * (display.contentWidth / 320))
	teks_makanan.anchorX = 0.5
	teks_makanan:setFillColor(0)
	scrollView:insert(teks_makanan)
	--composer.tinggi_line2 = teks_makanan.y


	local line2 = display.newLine( 0 + 0.05 * display.contentWidth, teks_makanan.y + display.contentHeight/40, display.contentWidth - display.contentWidth*0.05, teks_makanan.y + display.contentHeight/40 )
	line2:setStrokeColor( 133/255,190/255,72/255)
	line2.strokeWidth = 2
	scrollView:insert(line2)
	composer.tinggi_line2 = line2.y

	scrollView_menu3 = widget.newScrollView(
	    {
	        top = teks_makanan.y + display.contentHeight/30,
	        left = 0,
	        width = display.contentWidth,
	        height = 900 * ((0.45 * display.contentHeight) / 900),
	        horizontalScrollDisabled = false,
	        verticalScrollDisabled = true,
	        --backgroundColor = {133/255,190/255,72/255},
	        isBounceEnabled = false,
	        --scrollWidth = 600,
	        --scrollHeight = 2000,
	        listener = scrollListener

	    }
	)
	scrollView:insert(scrollView_menu3)







	local teks_olehhaji = display.newText( "Oleh - Oleh Buah Tin & Kismis", display.contentCenterX, teks_makanan.y + scrollView_menu2.height , used_font, 15  * (display.contentWidth / 320))
	teks_olehhaji.anchorX = 0.5
	teks_olehhaji:setFillColor(0)
	scrollView:insert(teks_olehhaji)
	--composer.tinggi_line2 = teks_olehhaji.y

	local line2 = display.newLine( 0 + 0.05 * display.contentWidth, teks_olehhaji.y + display.contentHeight/40, display.contentWidth - display.contentWidth*0.05, teks_olehhaji.y + display.contentHeight/40 )
	line2:setStrokeColor( 133/255,190/255,72/255)
	line2.strokeWidth = 2
	scrollView:insert(line2)
	composer.tinggi_line2 = line2.y

	scrollView_menu4 = widget.newScrollView(
	    {
	        top = teks_olehhaji.y + display.contentHeight/30,
	        left = 0,
	        width = display.contentWidth,
	        height = 900 * ((0.45 * display.contentHeight) / 900),
	        horizontalScrollDisabled = false,
	        verticalScrollDisabled = true,
	        --backgroundColor = {133/255,190/255,72/255},
	        isBounceEnabled = false,
	        --scrollWidth = 600,
	        --scrollHeight = 2000,
	        listener = scrollListener

	    }
	)
	scrollView:insert(scrollView_menu4)


	local teks_busana_muslim = display.newText( "Oleh - Oleh Souvenir", display.contentCenterX, teks_olehhaji.y + scrollView_menu4.height  , used_font, 15  * (display.contentWidth / 320))
	teks_busana_muslim.anchorX = 0.5
	teks_busana_muslim:setFillColor(0)
	scrollView:insert(teks_busana_muslim)
	--composer.tinggi_line2 = teks_busana_muslim.y

	local line2 = display.newLine( 0 + 0.05 * display.contentWidth, teks_busana_muslim.y + display.contentHeight/40, display.contentWidth - display.contentWidth*0.05, teks_busana_muslim.y + display.contentHeight/40 )
	line2:setStrokeColor( 133/255,190/255,72/255)
	line2.strokeWidth = 2
	scrollView:insert(line2)
	composer.tinggi_line2 = line2.y

	scrollView_menu5 = widget.newScrollView(
	    {
	        top = teks_busana_muslim.y + display.contentHeight/30,
	        left = 0,
	        width = display.contentWidth,
	        height = 900 * ((0.45 * display.contentHeight) / 900),
	        horizontalScrollDisabled = false,
	        verticalScrollDisabled = true,
	        --backgroundColor = {133/255,190/255,72/255},
	        isBounceEnabled = false,
	        --scrollWidth = 600,
	        --scrollHeight = 2000,
	        listener = scrollListener

	    }
	)
	scrollView:insert(scrollView_menu5)


	local teks_perlengkapan_muslim = display.newText( "Perlengkapan Muslim", display.contentCenterX, teks_busana_muslim.y + scrollView_menu5.height  , used_font, 15  * (display.contentWidth / 320))
	teks_perlengkapan_muslim.anchorX = 0.5
	teks_perlengkapan_muslim:setFillColor(0)
	scrollView:insert(teks_perlengkapan_muslim)
	--composer.tinggi_line2 = teks_perlengkapan_muslim.y


	local line2 = display.newLine( 0 + 0.05 * display.contentWidth, teks_perlengkapan_muslim.y + display.contentHeight/40, display.contentWidth - display.contentWidth*0.05, teks_perlengkapan_muslim.y + display.contentHeight/40 )
	line2:setStrokeColor( 133/255,190/255,72/255)
	line2.strokeWidth = 2
	scrollView:insert(line2)
	composer.tinggi_line2 = line2.y


	scrollView_menu6 = widget.newScrollView(
	    {
	        top = teks_perlengkapan_muslim.y + display.contentHeight/30,
	        left = 0,
	        width = display.contentWidth,
	        height = 900 * ((0.45 * display.contentHeight) / 900),
	        horizontalScrollDisabled = false,
	        verticalScrollDisabled = true,
	        --backgroundColor = {133/255,190/255,72/255},
	        isBounceEnabled = false,
	        --scrollWidth = 600,
	        --scrollHeight = 2000,
	        listener = scrollListener

	    }
	)
	scrollView:insert(scrollView_menu6)



	local teks_perlengkapan_haji = display.newText( "Perlengkapan Haji", display.contentCenterX, teks_perlengkapan_muslim.y + scrollView_menu6.height, used_font, 15  * (display.contentWidth / 320))
	teks_perlengkapan_haji.anchorX = 0.5
	teks_perlengkapan_haji:setFillColor(0)
	scrollView:insert(teks_perlengkapan_haji)
	--composer.tinggi_line2 = teks_perlengkapan_haji.y


	local line2 = display.newLine( 0 + 0.05 * display.contentWidth, teks_perlengkapan_haji.y + display.contentHeight/40, display.contentWidth - display.contentWidth*0.05, teks_perlengkapan_haji.y + display.contentHeight/40 )
	line2:setStrokeColor( 133/255,190/255,72/255)
	line2.strokeWidth = 2
	scrollView:insert(line2)
	composer.tinggi_line2 = line2.y


	scrollView_menu7 = widget.newScrollView(
	    {
	        top = teks_perlengkapan_haji.y + display.contentHeight/30,
	        left = 0,
	        width = display.contentWidth,
	        height = 900 * ((0.45 * display.contentHeight) / 900),
	        horizontalScrollDisabled = false,
	        verticalScrollDisabled = true,
	        --backgroundColor = {133/255,190/255,72/255},
	        isBounceEnabled = false,
	        --scrollWidth = 600,
	        --scrollHeight = 2000,
	        listener = scrollListener

	    }
	)
	scrollView:insert(scrollView_menu7)
--]]


	--======================================================FOOTER======================================================--



--[[
	local footer_background = display.newRect( display.contentCenterX, scrollView_menu1.y + display.contentHeight/4, display.contentWidth, display.contentHeight/7)
	footer_background.anchorY = 0
	footer_background:setFillColor( 133/255,190/255,72/255)
	scrollView:insert(footer_background)

	local teks_footer = display.newText( "TEMUKAN JUGA KAMI DI", display.contentCenterX, footer_background.y + display.contentHeight/80, used_font, 15  * (display.contentWidth / 320))
	teks_footer.anchorX = 0.5
	teks_footer.anchorY = 0
	teks_footer:setFillColor(1)
	scrollView:insert(teks_footer)

	

	local logo_twitter = display.newImageRect( composer.imgDir.. "twitter.jpg", 20, 20 ); 
	logo_twitter.x = display.contentCenterX - 15;
	logo_twitter.y =  teks_footer.y + teks_footer.height + display.contentHeight/60
	logo_twitter.anchorY = 0
	scrollView:insert(logo_twitter)

	local function onTwitter()
		system.openURL("https://twitter.com/bursasajadah/")
	end

	logo_twitter:addEventListener("tap", onTwitter)

	local logo_instagram = display.newImageRect( composer.imgDir.. "instagram.jpg", 20, 20 ); 
	logo_instagram.x = logo_twitter.x - 30;
	logo_instagram.y =  teks_footer.y + teks_footer.height + display.contentHeight/60
	logo_instagram.anchorY = 0
	scrollView:insert(logo_instagram)

	local function onInstagram()
		system.openURL("https://www.instagram.com/bursa.sajadah/")
	end

	logo_instagram:addEventListener("tap", onInstagram)

	local logo_facebook = display.newImageRect( composer.imgDir.. "facebook.jpg", 20, 20 ); 
	logo_facebook.x = logo_instagram.x - 30;
	logo_facebook.y =  teks_footer.y + teks_footer.height + display.contentHeight/60
	logo_facebook.anchorY = 0
	scrollView:insert(logo_facebook)

	local function onFacebook()
		system.openURL("https://www.facebook.com/BursaSajadah/")
	end

	logo_facebook:addEventListener("tap", onFacebook)

	local logo_tokopedia = display.newImageRect( composer.imgDir.. "tokopedia.jpg", 20, 20 ); 
	logo_tokopedia.x = display.contentCenterX + 15;
	logo_tokopedia.y =  teks_footer.y + teks_footer.height + display.contentHeight/60
	logo_tokopedia.anchorY = 0
	scrollView:insert(logo_tokopedia)

	local function onTokopedia()
		system.openURL("https://www.tokopedia.com/bursasajadah")
	end

	logo_tokopedia:addEventListener("tap", onTokopedia)

	local logo_bukalapak = display.newImageRect( composer.imgDir.. "bukalapak.jpg", 20, 20 ); 
	logo_bukalapak.x = logo_tokopedia.x + 30;
	logo_bukalapak.y =  teks_footer.y + teks_footer.height + display.contentHeight/60
	logo_bukalapak.anchorY = 0
	scrollView:insert(logo_bukalapak)

	local function onBukalapak()
		system.openURL("https://www.bukalapak.com/bursasajadah")
	end

	logo_bukalapak:addEventListener("tap", onBukalapak)

	local logo_toko = display.newImageRect( composer.imgDir.. "iconstore.png", 20, 20 ); 
	logo_toko.x = logo_bukalapak.x + 30;
	logo_toko.y =  teks_footer.y + teks_footer.height + display.contentHeight/60
	logo_toko.anchorY = 0
	scrollView:insert(logo_toko)

	local function onToko()
		system.openURL("http://m.bursasajadah.com/toko")
	end

	logo_toko:addEventListener("tap", onToko)
--]]
	
	--================================================================================================================================

	
	
		--search:addEventListener("tap", onLoginView )









	-- all objects must be added to group (e.g. self.view)
	sceneGroup:insert( background )
	sceneGroup:insert( background2 )
	sceneGroup:insert(logo)
	sceneGroup:insert( menu )
	sceneGroup:insert( lingkaran_profile )
	
	
	sceneGroup:insert( scrollView )

	sceneGroup:insert(myRectangle1)
	sceneGroup:insert(teks_search)
	--[[sceneGroup:insert(myRectangle)
	sceneGroup:insert(search)--]]

	sceneGroup:insert(grup_menu)
	grup_menu.alpha = 0

	


end

function scene:show( event )
		
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then

	
	
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
	

	local function loading()
		-- body
	local options_overlay =
		{
		    isModal = true,
		    effect = "fade",
		    time = 100,
		    params = {
		        sampleVar1 = "my sample variable",
		        sampleVar2 = "another sample variable"
		    }
		}

		
		composer.showOverlay("overlay_loading", options_overlay)
		

	end
	timer.performWithDelay(10, loading)
    composer.removeHidden()

    

    local function hideover()

    

    composer.hideOverlay("fade", 100)

	end

	timer.performWithDelay(2000, hideover)


		

		


		

	-- 	local options_overlay =
	-- {
	--     isModal = true,
	--     effect = "fade",
	--     time = 400,
	--     params = {
	--         sampleVar1 = "my sample variable",
	--         sampleVar2 = "another sample variable"
	--     }
	-- }



	
	

  
   
		 function tampilBerita3()
          local index

          
          	composer.posisi_y = 0
             		composer.gambar_iklan_sajadah = 1


          	 local params = {}
             params.progress = true
     
             for index = 1, data_max do
      			   
             		--print(index)
                   local data = listData[index]
      			   

                    --composer.url_link = data.url_link
                    local image = data.image
                   
                    local count = composer.gambar_iklan_sajadah

                      local y = composer.posisi_y
                      local x1 = composer.posisi_x1
                      local x2 = composer.posisi_x2

                      local myImage = display.newImage( composer.imgDir.. "logo.png", 125, 39)
                      
                      myImage.anchorY = 0
                      if(count%2 == 1)then
                      		myImage.x = x1
                      		myImage.anchorX = 1
                      else
                      		myImage.x = x2
                      		myImage.anchorX = 0
                      end
                      myImage.y = composer.posisi_y
                      myImage.width = 700
                      myImage.height = 959
                      myImage.xScale = (0.4 * display.contentWidth) / 700
                      myImage.yScale = (0.4 * display.contentWidth) / 700
                      myImage.alpha = 1
                      --transition.to( layer.myImage, { alpha = 1.0 , delay = 0} )
                      grup1:insert(myImage)


                      local lebar = 700 * (0.4 * display.contentWidth) / 700
                      local posisi_teks_x = myImage.x + (myImage.width * myImage.xScale /2)

                       if(composer.gambar_iklan_sajadah%2 == 1)then
                       		--posisi_teks_x = myImage.x - (myImage.width * myImage.xScale /2)
                       		posisi_teks_x = myImage.x - (myImage.width * myImage.xScale)
                       else
                       		--posisi_teks_x = myImage.x + (myImage.width * myImage.xScale /2)
                       		posisi_teks_x = myImage.x
                       end

                      local posisi_teks_y = myImage.y + myImage.height * myImage.yScale + 10
                      local posisi_teks_y2 = posisi_teks_y 
                      local tinggi = posisi_teks_y - 10


                      local teks  = data.product--table.concat(composer.data_sajadah, ", ", composer.gambar_iklan_sajadah,composer.gambar_iklan_sajadah)
                      local teks2 = data.regular_price --table.concat(composer.data_sajadah_harga, ", ", composer.gambar_iklan_sajadah,composer.gambar_iklan_sajadah)


                    local ucing = composer.gambar_iklan_sajadah

                    function onProduk( event )
                    	myImage:removeEventListener("tap", onProduk)
                    	--local function listener( event )
                    	composer.id_lempar = data.product_id --table.concat(composer.data_sajadah_id, ", ", ucing,ucing)
                    	if nil~= composer.getScene("test_detail") then composer.removeScene("test_detail", true) end
						composer.gotoScene( "test_detail" )
						-- end
						  
						-- timer.performWithDelay( 500, listener) 
					end
					myImage:addEventListener("tap", onProduk )




                     local options = {

                     text = ("Rp. "..teks2..",-"),
                     x = posisi_teks_x + lebar * 0.1,
                     y = posisi_teks_y,
                     font = used_font_bold,
                     fontSize = 8  * (display.contentWidth / 320),
                     align = "left",
                     width = lebar 
                 	 }


                 	 local teks_produk_diskon = display.newText(options)
			         teks_produk_diskon.anchorX = 0
			         teks_produk_diskon.anchorY = 0
			         teks_produk_diskon:setFillColor(0.4);
			         


                 	 local options2 = {

                     text = string.upper(teks),
                     x = posisi_teks_x + lebar * 0.1,
                     y = teks_produk_diskon.y + teks_produk_diskon.height + 3,
                     font = used_font_bold,
                     fontSize = 10  * (display.contentWidth / 320),
                     align = "left",
                     width = lebar - lebar*0.2
                 	 }

                 	 

			         local teks_produk_diskon_harga = display.newText(options2)
			         teks_produk_diskon_harga.anchorX = 0
			         teks_produk_diskon_harga.anchorY = 0
			         teks_produk_diskon_harga:setFillColor(0.4);
			         

                      composer.temp_x1 = myImage.x + myImage.width*myImage.xScale + display.contentWidth/7
                      composer.gambar_iklan_sajadah = composer.gambar_iklan_sajadah + 1

                      if(composer.gambar_iklan_sajadah%2 == 1)then
                      composer.posisi_y = teks_produk_diskon_harga.y + teks_produk_diskon_harga.height + display.contentHeight/20
                      end
                      composer.posisi_y2 = teks_produk_diskon_harga.y + teks_produk_diskon_harga.height + display.contentHeight/40 
                      local tinggi2 = teks_produk_diskon_harga.y + teks_produk_diskon_harga.height + display.contentHeight/50 - tinggi  
                      tinggi2 = composer.posisi_y2 - tinggi
                      local backitem = display.newRect(posisi_teks_x, tinggi,lebar, tinggi2)
                      backitem.anchorY = 0
                      backitem.anchorX = 0
                      backitem:setFillColor(230/255,230/255,230/255)

                     grup1:insert(backitem)
			         grup1:insert(teks_produk_diskon);
			         grup1:insert(teks_produk_diskon_harga);

                      composer.tinggi_scrollview = teks_produk_diskon_harga.y
                      --print(composer.gambar_iklan)
                      --print("pic saved")

                    --print("Nama link : "..composer.url_link)
                    --print("Nama Gambar : "..composer.image)


                    local function networkListener( event )
					    if ( event.isError ) then
		                      print( "Network error - download failed" )
		              elseif ( event.phase == "began" ) then
		                      -- cancelall[began] = event.requestId
		                      -- print( "Progress Phase: began" )
		                      -- began = began + 1
		              elseif ( event.phase == "ended" ) then


		            local path = system.pathForFile( event.response.filename, event.response.baseDirectory )
					local fhd = io.open( path )

					-- Determine if file exists
					if fhd then

                      local myImage = display.newImage( event.response.filename, event.response.baseDirectory, 20,  tes )
                      
                      myImage.anchorY = 0
                      if(count%2 == 1)then
                      		myImage.x = x1
                      		myImage.anchorX = 1
                      else
                      		myImage.x = x2
                      		myImage.anchorX = 0
                      end
                      myImage.y = y
                      myImage.width = 700
                      myImage.height = 959
                      myImage.xScale = (0.4 * display.contentWidth) / 700
                      myImage.yScale = (0.4 * display.contentWidth) / 700
                      myImage.alpha = 1
                      --transition.to( layer.myImage, { alpha = 1.0 , delay = 0} )
                      grup1:insert(myImage)


                       	  fhd:close()
					else
						
					end


                      --print(data_loading.." "..data_max)
			             --[[if(data_loading == data_max - 1)then
			             	composer.hideOverlay()
			             	
			             else
			             	data_loading = data_loading + 1
			             end--]]
                  	  end


					end



					local array_count = image:len() - 4
			        local array1 = image:sub(1,array_count)
			        local array2 = image:sub(-4)

			        local download = tostring(array1.."-203x266"..array2)
			        --local download = "https://pmcdeadline2.files.wordpress.com/2016/07/logo-tv-logo.png"

					--print("hadugh : "..composer.gambar_iklan)

                    --local gambar_remote = display.loadRemoteImage( "http://coronalabs.com/images/coronalogogrey.png", "GET", networkListener, "coronalogogrey.png", system.TemporaryDirectory, display.contentCenterX, 300 )
                    --scrollView:insert(gambar_remote)

                    cancelprodukterbaru[index] = network.download( download, "GET", networkListener,params, "iklan"..index..".jpg", system.TemporaryDirectory, 0, 0 )

                    --print(composer.namagambar)

              end

              scrollView:insert(grup1)
               
        end


        function tampilSajadah()
         local index

          
          	composer.posisi_y = 0
             		composer.gambar_iklan_sajadah = 1


          	 local params = {}
             params.progress = true
     
             for index = 1, data_max do
      			   
             		--print(index)
                   local data = listData[index]
      			   

                    --composer.url_link = data.url_link
                    local image = data.image
                   
                    local count = composer.gambar_iklan_sajadah

                      local y = composer.posisi_y
                      local x1 = composer.posisi_x1
                      local x2 = composer.posisi_x2

                      local myImage = display.newImage( composer.imgDir.. "logo.png", 125, 39)
                      
                      myImage.anchorY = 0
                      if(count%2 == 1)then
                      		myImage.x = x1
                      		myImage.anchorX = 1
                      else
                      		myImage.x = x2
                      		myImage.anchorX = 0
                      end
                      myImage.y = composer.posisi_y
                      myImage.width = 700
                      myImage.height = 959
                      myImage.xScale = (0.4 * display.contentWidth) / 700
                      myImage.yScale = (0.4 * display.contentWidth) / 700
                      myImage.alpha = 1
                      --transition.to( layer.myImage, { alpha = 1.0 , delay = 0} )
                      grup2:insert(myImage)


                      local lebar = 700 * (0.4 * display.contentWidth) / 700
                      local posisi_teks_x = myImage.x + (myImage.width * myImage.xScale /2)

                       if(composer.gambar_iklan_sajadah%2 == 1)then
                       		--posisi_teks_x = myImage.x - (myImage.width * myImage.xScale /2)
                       		posisi_teks_x = myImage.x - (myImage.width * myImage.xScale)
                       else
                       		--posisi_teks_x = myImage.x + (myImage.width * myImage.xScale /2)
                       		posisi_teks_x = myImage.x
                       end

                      local posisi_teks_y = myImage.y + myImage.height * myImage.yScale + 10
                      local posisi_teks_y2 = posisi_teks_y 
                      local tinggi = posisi_teks_y - 10


                      local teks  = data.product--table.concat(composer.data_sajadah, ", ", composer.gambar_iklan_sajadah,composer.gambar_iklan_sajadah)
                      local teks2 = data.regular_price --table.concat(composer.data_sajadah_harga, ", ", composer.gambar_iklan_sajadah,composer.gambar_iklan_sajadah)


                    local ucing = composer.gambar_iklan_sajadah

                    function onProduk( event )
                    	myImage:removeEventListener("tap", onProduk)
                    	--local function listener( event )
                    	composer.id_lempar = data.product_id --table.concat(composer.data_sajadah_id, ", ", ucing,ucing)
                    	if nil~= composer.getScene("test_detail") then composer.removeScene("test_detail", true) end
						composer.gotoScene( "test_detail" )

					end
					myImage:addEventListener("tap", onProduk )




                      local options = {

                     text = ("Rp. "..teks2..",-"),
                     x = posisi_teks_x + lebar * 0.1,
                     y = posisi_teks_y,
                     font = used_font_bold,
                     fontSize = 8  * (display.contentWidth / 320),
                     align = "left",
                     width = lebar 
                 	 }


                 	 local teks_produk_diskon = display.newText(options)
			         teks_produk_diskon.anchorX = 0
			         teks_produk_diskon.anchorY = 0
			         teks_produk_diskon:setFillColor(0.4);
			         


                 	 local options2 = {

                     text = string.upper(teks),
                     x = posisi_teks_x + lebar * 0.1,
                     y = teks_produk_diskon.y + teks_produk_diskon.height + 3,
                     font = used_font_bold,
                     fontSize = 10  * (display.contentWidth / 320),
                     align = "left",
                     width = lebar - lebar*0.2
                 	 }

                 	 

			         local teks_produk_diskon_harga = display.newText(options2)
			         teks_produk_diskon_harga.anchorX = 0
			         teks_produk_diskon_harga.anchorY = 0
			         teks_produk_diskon_harga:setFillColor(0.4);

                      composer.temp_x1 = myImage.x + myImage.width*myImage.xScale + display.contentWidth/7
                      composer.gambar_iklan_sajadah = composer.gambar_iklan_sajadah + 1

                      if(composer.gambar_iklan_sajadah%2 == 1)then
                      composer.posisi_y = teks_produk_diskon_harga.y + teks_produk_diskon_harga.height + display.contentHeight/20
                      end
                      composer.posisi_y2 = teks_produk_diskon_harga.y + teks_produk_diskon_harga.height + display.contentHeight/40 
                      local tinggi2 = teks_produk_diskon_harga.y + teks_produk_diskon_harga.height + display.contentHeight/50 - tinggi  
                      tinggi2 = composer.posisi_y2 - tinggi
                      local backitem = display.newRect(posisi_teks_x, tinggi,lebar, tinggi2)
                      backitem.anchorY = 0
                      backitem.anchorX = 0
                      backitem:setFillColor(230/255,230/255,230/255)

                     grup2:insert(backitem)
			         grup2:insert(teks_produk_diskon);
			         grup2:insert(teks_produk_diskon_harga);

                      composer.tinggi_scrollview = teks_produk_diskon_harga.y

                    local function networkListener( event )
					    if ( event.isError ) then
		                      print( "Network error - download failed" )
		              elseif ( event.phase == "began" ) then

		              elseif ( event.phase == "ended" ) then


		            local path = system.pathForFile( event.response.filename, event.response.baseDirectory )
					local fhd = io.open( path )

					if fhd then

                      local myImage = display.newImage( event.response.filename, event.response.baseDirectory, 20,  tes )
                      
                      myImage.anchorY = 0
                      if(count%2 == 1)then
                      		myImage.x = x1
                      		myImage.anchorX = 1
                      else
                      		myImage.x = x2
                      		myImage.anchorX = 0
                      end
                      myImage.y = y
                      myImage.width = 700
                      myImage.height = 959
                      myImage.xScale = (0.4 * display.contentWidth) / 700
                      myImage.yScale = (0.4 * display.contentWidth) / 700
                      myImage.alpha = 1
                      --transition.to( layer.myImage, { alpha = 1.0 , delay = 0} )
                      grup2:insert(myImage)


                      fhd:close()
					else
						
					end

                  	  end

					end

					local array_count = image:len() - 4
			        local array1 = image:sub(1,array_count)
			        local array2 = image:sub(-4)

			        local download = tostring(array1.."-203x266"..array2)
                    cancelsajadah[index] = network.download( download, "GET", networkListener,params, "sajadah"..index..".jpg", system.TemporaryDirectory, 0, 0 )

              end

              scrollView:insert(grup2)
        end


        function tampilMakanan()
          local index

          
          	composer.posisi_y = 0
             		composer.gambar_iklan_sajadah = 1


          	 local params = {}
             params.progress = true
     
             for index = 1, data_max do
      			   
             		--print(index)
                   local data = listData[index]
      			   

                    --composer.url_link = data.url_link
                    local image = data.image
                   
                    local count = composer.gambar_iklan_sajadah

                      local y = composer.posisi_y
                      local x1 = composer.posisi_x1
                      local x2 = composer.posisi_x2

                      local myImage = display.newImage( composer.imgDir.. "logo.png", 125, 39)
                      
                      myImage.anchorY = 0
                      if(count%2 == 1)then
                      		myImage.x = x1
                      		myImage.anchorX = 1
                      else
                      		myImage.x = x2
                      		myImage.anchorX = 0
                      end
                      myImage.y = composer.posisi_y
                      myImage.width = 700
                      myImage.height = 959
                      myImage.xScale = (0.4 * display.contentWidth) / 700
                      myImage.yScale = (0.4 * display.contentWidth) / 700
                      myImage.alpha = 1
                      --transition.to( layer.myImage, { alpha = 1.0 , delay = 0} )
                      grup3:insert(myImage)


                      local lebar = 700 * (0.4 * display.contentWidth) / 700
                      local posisi_teks_x = myImage.x + (myImage.width * myImage.xScale /2)

                       if(composer.gambar_iklan_sajadah%2 == 1)then
                       		--posisi_teks_x = myImage.x - (myImage.width * myImage.xScale /2)
                       		posisi_teks_x = myImage.x - (myImage.width * myImage.xScale)
                       else
                       		--posisi_teks_x = myImage.x + (myImage.width * myImage.xScale /2)
                       		posisi_teks_x = myImage.x
                       end

                      local posisi_teks_y = myImage.y + myImage.height * myImage.yScale + 10
                      local posisi_teks_y2 = posisi_teks_y 
                      local tinggi = posisi_teks_y - 10


                      local teks  = data.product--table.concat(composer.data_sajadah, ", ", composer.gambar_iklan_sajadah,composer.gambar_iklan_sajadah)
                      local teks2 = data.regular_price --table.concat(composer.data_sajadah_harga, ", ", composer.gambar_iklan_sajadah,composer.gambar_iklan_sajadah)


                    local ucing = composer.gambar_iklan_sajadah

                    function onProduk( event )
                    	myImage:removeEventListener("tap", onProduk)
                    	--local function listener( event )
                    	composer.id_lempar = data.product_id --table.concat(composer.data_sajadah_id, ", ", ucing,ucing)
                    	if nil~= composer.getScene("test_detail") then composer.removeScene("test_detail", true) end
						composer.gotoScene( "test_detail" )

					end
					myImage:addEventListener("tap", onProduk )




                      local options = {

                     text = ("Rp. "..teks2..",-"),
                     x = posisi_teks_x + lebar * 0.1,
                     y = posisi_teks_y,
                     font = used_font_bold,
                     fontSize = 8  * (display.contentWidth / 320),
                     align = "left",
                     width = lebar 
                 	 }


                 	 local teks_produk_diskon = display.newText(options)
			         teks_produk_diskon.anchorX = 0
			         teks_produk_diskon.anchorY = 0
			         teks_produk_diskon:setFillColor(0.4);
			         


                 	 local options2 = {

                     text = string.upper(teks),
                     x = posisi_teks_x + lebar * 0.1,
                     y = teks_produk_diskon.y + teks_produk_diskon.height + 3,
                     font = used_font_bold,
                     fontSize = 10  * (display.contentWidth / 320),
                     align = "left",
                     width = lebar - lebar*0.2
                 	 }

                 	 

			         local teks_produk_diskon_harga = display.newText(options2)
			         teks_produk_diskon_harga.anchorX = 0
			         teks_produk_diskon_harga.anchorY = 0
			         teks_produk_diskon_harga:setFillColor(0.4);

                      composer.temp_x1 = myImage.x + myImage.width*myImage.xScale + display.contentWidth/7
                      composer.gambar_iklan_sajadah = composer.gambar_iklan_sajadah + 1

                      if(composer.gambar_iklan_sajadah%2 == 1)then
                      composer.posisi_y = teks_produk_diskon_harga.y + teks_produk_diskon_harga.height + display.contentHeight/20
                      end
                      composer.posisi_y2 = teks_produk_diskon_harga.y + teks_produk_diskon_harga.height + display.contentHeight/40 
                      local tinggi2 = teks_produk_diskon_harga.y + teks_produk_diskon_harga.height + display.contentHeight/50 - tinggi  
                      tinggi2 = composer.posisi_y2 - tinggi
                      local backitem = display.newRect(posisi_teks_x, tinggi,lebar, tinggi2)
                      backitem.anchorY = 0
                      backitem.anchorX = 0
                      backitem:setFillColor(230/255,230/255,230/255)

                     grup3:insert(backitem)
			         grup3:insert(teks_produk_diskon);
			         grup3:insert(teks_produk_diskon_harga);

                      composer.tinggi_scrollview = teks_produk_diskon_harga.y

                    local function networkListener( event )
					    if ( event.isError ) then
		                      print( "Network error - download failed" )
		              elseif ( event.phase == "began" ) then

		              elseif ( event.phase == "ended" ) then


		            local path = system.pathForFile( event.response.filename, event.response.baseDirectory )
					local fhd = io.open( path )

					if fhd then

                      local myImage = display.newImage( event.response.filename, event.response.baseDirectory, 20,  tes )
                      
                      myImage.anchorY = 0
                      if(count%2 == 1)then
                      		myImage.x = x1
                      		myImage.anchorX = 1
                      else
                      		myImage.x = x2
                      		myImage.anchorX = 0
                      end
                      myImage.y = y
                      myImage.width = 700
                      myImage.height = 959
                      myImage.xScale = (0.4 * display.contentWidth) / 700
                      myImage.yScale = (0.4 * display.contentWidth) / 700
                      myImage.alpha = 1
                      --transition.to( layer.myImage, { alpha = 1.0 , delay = 0} )
                      grup3:insert(myImage)


                      fhd:close()
					else
						
					end

                  	  end

					end

					local array_count = image:len() - 4
			        local array1 = image:sub(1,array_count)
			        local array2 = image:sub(-4)

			        local download = tostring(array1.."-203x266"..array2)
                    cancelmakanan[index] = network.download( download, "GET", networkListener,params, "makanan"..index..".jpg", system.TemporaryDirectory, 0, 0 )

              end

              scrollView:insert(grup3)
               
        end



        function tampilOlehHaji()
         local index

          
          	composer.posisi_y = 0
             		composer.gambar_iklan_sajadah = 1


          	 local params = {}
             params.progress = true
     
             for index = 1, data_max do
      			   
             		--print(index)
                   local data = listData[index]
      			   

                    --composer.url_link = data.url_link
                    local image = data.image
                   
                    local count = composer.gambar_iklan_sajadah

                      local y = composer.posisi_y
                      local x1 = composer.posisi_x1
                      local x2 = composer.posisi_x2

                      local myImage = display.newImage( composer.imgDir.. "logo.png", 125, 39)
                      
                      myImage.anchorY = 0
                      if(count%2 == 1)then
                      		myImage.x = x1
                      		myImage.anchorX = 1
                      else
                      		myImage.x = x2
                      		myImage.anchorX = 0
                      end
                      myImage.y = composer.posisi_y
                      myImage.width = 700
                      myImage.height = 959
                      myImage.xScale = (0.4 * display.contentWidth) / 700
                      myImage.yScale = (0.4 * display.contentWidth) / 700
                      myImage.alpha = 1
                      --transition.to( layer.myImage, { alpha = 1.0 , delay = 0} )
                      grup4:insert(myImage)


                      local lebar = 700 * (0.4 * display.contentWidth) / 700
                      local posisi_teks_x = myImage.x + (myImage.width * myImage.xScale /2)

                       if(composer.gambar_iklan_sajadah%2 == 1)then
                       		--posisi_teks_x = myImage.x - (myImage.width * myImage.xScale /2)
                       		posisi_teks_x = myImage.x - (myImage.width * myImage.xScale)
                       else
                       		--posisi_teks_x = myImage.x + (myImage.width * myImage.xScale /2)
                       		posisi_teks_x = myImage.x
                       end

                      local posisi_teks_y = myImage.y + myImage.height * myImage.yScale + 10
                      local posisi_teks_y2 = posisi_teks_y 
                      local tinggi = posisi_teks_y - 10


                      local teks  = data.product--table.concat(composer.data_sajadah, ", ", composer.gambar_iklan_sajadah,composer.gambar_iklan_sajadah)
                      local teks2 = data.regular_price --table.concat(composer.data_sajadah_harga, ", ", composer.gambar_iklan_sajadah,composer.gambar_iklan_sajadah)


                    local ucing = composer.gambar_iklan_sajadah

                    function onProduk( event )
                    	myImage:removeEventListener("tap", onProduk)
                    	--local function listener( event )
                    	composer.id_lempar = data.product_id --table.concat(composer.data_sajadah_id, ", ", ucing,ucing)
                    	if nil~= composer.getScene("test_detail") then composer.removeScene("test_detail", true) end
						composer.gotoScene( "test_detail" )

					end
					myImage:addEventListener("tap", onProduk )




                     local options = {

                     text = ("Rp. "..teks2..",-"),
                     x = posisi_teks_x + lebar * 0.1,
                     y = posisi_teks_y,
                     font = used_font_bold,
                     fontSize = 8  * (display.contentWidth / 320),
                     align = "left",
                     width = lebar 
                 	 }


                 	 local teks_produk_diskon = display.newText(options)
			         teks_produk_diskon.anchorX = 0
			         teks_produk_diskon.anchorY = 0
			         teks_produk_diskon:setFillColor(0.4);
			         


                 	 local options2 = {

                     text = string.upper(teks),
                     x = posisi_teks_x + lebar * 0.1,
                     y = teks_produk_diskon.y + teks_produk_diskon.height + 3,
                     font = used_font_bold,
                     fontSize = 10  * (display.contentWidth / 320),
                     align = "left",
                     width = lebar - lebar*0.2
                 	 }

                 	 

			         local teks_produk_diskon_harga = display.newText(options2)
			         teks_produk_diskon_harga.anchorX = 0
			         teks_produk_diskon_harga.anchorY = 0
			         teks_produk_diskon_harga:setFillColor(0.4);

                      composer.temp_x1 = myImage.x + myImage.width*myImage.xScale + display.contentWidth/7
                      composer.gambar_iklan_sajadah = composer.gambar_iklan_sajadah + 1

                      if(composer.gambar_iklan_sajadah%2 == 1)then
                      composer.posisi_y = teks_produk_diskon_harga.y + teks_produk_diskon_harga.height + display.contentHeight/20
                      end
                      composer.posisi_y2 = teks_produk_diskon_harga.y + teks_produk_diskon_harga.height + display.contentHeight/40 
                      local tinggi2 = teks_produk_diskon_harga.y + teks_produk_diskon_harga.height + display.contentHeight/50 - tinggi  
                      tinggi2 = composer.posisi_y2 - tinggi
                      local backitem = display.newRect(posisi_teks_x, tinggi,lebar, tinggi2)
                      backitem.anchorY = 0
                      backitem.anchorX = 0
                      backitem:setFillColor(230/255,230/255,230/255)

                     grup4:insert(backitem)
			         grup4:insert(teks_produk_diskon);
			         grup4:insert(teks_produk_diskon_harga);

                      composer.tinggi_scrollview = teks_produk_diskon_harga.y

                    local function networkListener( event )
					    if ( event.isError ) then
		                      print( "Network error - download failed" )
		              elseif ( event.phase == "began" ) then

		              elseif ( event.phase == "ended" ) then


		            local path = system.pathForFile( event.response.filename, event.response.baseDirectory )
					local fhd = io.open( path )

					if fhd then

                      local myImage = display.newImage( event.response.filename, event.response.baseDirectory, 20,  tes )
                      
                      myImage.anchorY = 0
                      if(count%2 == 1)then
                      		myImage.x = x1
                      		myImage.anchorX = 1
                      else
                      		myImage.x = x2
                      		myImage.anchorX = 0
                      end
                      myImage.y = y
                      myImage.width = 700
                      myImage.height = 959
                      myImage.xScale = (0.4 * display.contentWidth) / 700
                      myImage.yScale = (0.4 * display.contentWidth) / 700
                      myImage.alpha = 1
                      --transition.to( layer.myImage, { alpha = 1.0 , delay = 0} )
                      grup4:insert(myImage)


                      fhd:close()
					else
						
					end

                  	  end

					end

					local array_count = image:len() - 4
			        local array1 = image:sub(1,array_count)
			        local array2 = image:sub(-4)

			        local download = tostring(array1.."-203x266"..array2)
                    cancelolehhaji[index] = network.download( download, "GET", networkListener,params, "olehhaji"..index..".jpg", system.TemporaryDirectory, 0, 0 )

              end

              scrollView:insert(grup4)
        end


        function tampilBusanaMuslim()
          local index

          
          	composer.posisi_y = 0
             		composer.gambar_iklan_sajadah = 1


          	 local params = {}
             params.progress = true
     
             for index = 1, data_max do
      			   
             		--print(index)
                   local data = listData[index]
      			   

                    --composer.url_link = data.url_link
                    local image = data.image
                   
                    local count = composer.gambar_iklan_sajadah

                      local y = composer.posisi_y
                      local x1 = composer.posisi_x1
                      local x2 = composer.posisi_x2

                      local myImage = display.newImage( composer.imgDir.. "logo.png", 125, 39)
                      
                      myImage.anchorY = 0
                      if(count%2 == 1)then
                      		myImage.x = x1
                      		myImage.anchorX = 1
                      else
                      		myImage.x = x2
                      		myImage.anchorX = 0
                      end
                      myImage.y = composer.posisi_y
                      myImage.width = 700
                      myImage.height = 959
                      myImage.xScale = (0.4 * display.contentWidth) / 700
                      myImage.yScale = (0.4 * display.contentWidth) / 700
                      myImage.alpha = 1
                      --transition.to( layer.myImage, { alpha = 1.0 , delay = 0} )
                      grup5:insert(myImage)


                      local lebar = 700 * (0.4 * display.contentWidth) / 700
                      local posisi_teks_x = myImage.x + (myImage.width * myImage.xScale /2)

                       if(composer.gambar_iklan_sajadah%2 == 1)then
                       		--posisi_teks_x = myImage.x - (myImage.width * myImage.xScale /2)
                       		posisi_teks_x = myImage.x - (myImage.width * myImage.xScale)
                       else
                       		--posisi_teks_x = myImage.x + (myImage.width * myImage.xScale /2)
                       		posisi_teks_x = myImage.x
                       end

                      local posisi_teks_y = myImage.y + myImage.height * myImage.yScale + 10
                      local posisi_teks_y2 = posisi_teks_y 
                      local tinggi = posisi_teks_y - 10


                      local teks  = data.product--table.concat(composer.data_sajadah, ", ", composer.gambar_iklan_sajadah,composer.gambar_iklan_sajadah)
                      local teks2 = data.regular_price --table.concat(composer.data_sajadah_harga, ", ", composer.gambar_iklan_sajadah,composer.gambar_iklan_sajadah)


                    local ucing = composer.gambar_iklan_sajadah

                    function onProduk( event )
                    	myImage:removeEventListener("tap", onProduk)
                    	--local function listener( event )
                    	composer.id_lempar = data.product_id --table.concat(composer.data_sajadah_id, ", ", ucing,ucing)
                    	if nil~= composer.getScene("test_detail") then composer.removeScene("test_detail", true) end
						composer.gotoScene( "test_detail" )

					end
					myImage:addEventListener("tap", onProduk )




                     local options = {

                     text = ("Rp. "..teks2..",-"),
                     x = posisi_teks_x + lebar * 0.1,
                     y = posisi_teks_y,
                     font = used_font_bold,
                     fontSize = 8  * (display.contentWidth / 320),
                     align = "left",
                     width = lebar 
                 	 }


                 	 local teks_produk_diskon = display.newText(options)
			         teks_produk_diskon.anchorX = 0
			         teks_produk_diskon.anchorY = 0
			         teks_produk_diskon:setFillColor(0.4);
			         


                 	 local options2 = {

                     text = string.upper(teks),
                     x = posisi_teks_x + lebar * 0.1,
                     y = teks_produk_diskon.y + teks_produk_diskon.height + 3,
                     font = used_font_bold,
                     fontSize = 10  * (display.contentWidth / 320),
                     align = "left",
                     width = lebar - lebar*0.2
                 	 }

                 	 

			         local teks_produk_diskon_harga = display.newText(options2)
			         teks_produk_diskon_harga.anchorX = 0
			         teks_produk_diskon_harga.anchorY = 0
			         teks_produk_diskon_harga:setFillColor(0.4);

                      composer.temp_x1 = myImage.x + myImage.width*myImage.xScale + display.contentWidth/7
                      composer.gambar_iklan_sajadah = composer.gambar_iklan_sajadah + 1

                      if(composer.gambar_iklan_sajadah%2 == 1)then
                      composer.posisi_y = teks_produk_diskon_harga.y + teks_produk_diskon_harga.height + display.contentHeight/20
                      end
                      composer.posisi_y2 = teks_produk_diskon_harga.y + teks_produk_diskon_harga.height + display.contentHeight/40 
                      local tinggi2 = teks_produk_diskon_harga.y + teks_produk_diskon_harga.height + display.contentHeight/50 - tinggi  
                      tinggi2 = composer.posisi_y2 - tinggi
                      local backitem = display.newRect(posisi_teks_x, tinggi,lebar, tinggi2)
                      backitem.anchorY = 0
                      backitem.anchorX = 0
                      backitem:setFillColor(230/255,230/255,230/255)

                     grup5:insert(backitem)
			         grup5:insert(teks_produk_diskon);
			         grup5:insert(teks_produk_diskon_harga);

                      composer.tinggi_scrollview = teks_produk_diskon_harga.y

                    local function networkListener( event )
					    if ( event.isError ) then
		                      print( "Network error - download failed" )
		              elseif ( event.phase == "began" ) then

		              elseif ( event.phase == "ended" ) then


		            local path = system.pathForFile( event.response.filename, event.response.baseDirectory )
					local fhd = io.open( path )

					if fhd then

                      local myImage = display.newImage( event.response.filename, event.response.baseDirectory, 20,  tes )
                      
                      myImage.anchorY = 0
                      if(count%2 == 1)then
                      		myImage.x = x1
                      		myImage.anchorX = 1
                      else
                      		myImage.x = x2
                      		myImage.anchorX = 0
                      end
                      myImage.y = y
                      myImage.width = 700
                      myImage.height = 959
                      myImage.xScale = (0.4 * display.contentWidth) / 700
                      myImage.yScale = (0.4 * display.contentWidth) / 700
                      myImage.alpha = 1
                      --transition.to( layer.myImage, { alpha = 1.0 , delay = 0} )
                      grup5:insert(myImage)


                      fhd:close()
					else
						
					end

                  	  end

					end

					local array_count = image:len() - 4
			        local array1 = image:sub(1,array_count)
			        local array2 = image:sub(-4)

			        local download = tostring(array1.."-203x266"..array2)
                    cancelbusanamuslim[index] = network.download( download, "GET", networkListener,params, "busanamuslim"..index..".jpg", system.TemporaryDirectory, 0, 0 )

              end

              scrollView:insert(grup5)
               
        end



        function tampilPerlengkapanMuslim()
         local index

          
          	composer.posisi_y = 0
             		composer.gambar_iklan_sajadah = 1


          	 local params = {}
             params.progress = true
     
             for index = 1, data_max do
      			   
             		--print(index)
                   local data = listData[index]
      			   

                    --composer.url_link = data.url_link
                    local image = data.image
                   
                    local count = composer.gambar_iklan_sajadah

                      local y = composer.posisi_y
                      local x1 = composer.posisi_x1
                      local x2 = composer.posisi_x2

                      local myImage = display.newImage( composer.imgDir.. "logo.png", 125, 39)
                      
                      myImage.anchorY = 0
                      if(count%2 == 1)then
                      		myImage.x = x1
                      		myImage.anchorX = 1
                      else
                      		myImage.x = x2
                      		myImage.anchorX = 0
                      end
                      myImage.y = composer.posisi_y
                      myImage.width = 700
                      myImage.height = 959
                      myImage.xScale = (0.4 * display.contentWidth) / 700
                      myImage.yScale = (0.4 * display.contentWidth) / 700
                      myImage.alpha = 1
                      --transition.to( layer.myImage, { alpha = 1.0 , delay = 0} )
                      grup6:insert(myImage)


                      local lebar = 700 * (0.4 * display.contentWidth) / 700
                      local posisi_teks_x = myImage.x + (myImage.width * myImage.xScale /2)

                       if(composer.gambar_iklan_sajadah%2 == 1)then
                       		--posisi_teks_x = myImage.x - (myImage.width * myImage.xScale /2)
                       		posisi_teks_x = myImage.x - (myImage.width * myImage.xScale)
                       else
                       		--posisi_teks_x = myImage.x + (myImage.width * myImage.xScale /2)
                       		posisi_teks_x = myImage.x
                       end

                      local posisi_teks_y = myImage.y + myImage.height * myImage.yScale + 10
                      local posisi_teks_y2 = posisi_teks_y 
                      local tinggi = posisi_teks_y - 10


                      local teks  = data.product--table.concat(composer.data_sajadah, ", ", composer.gambar_iklan_sajadah,composer.gambar_iklan_sajadah)
                      local teks2 = data.regular_price --table.concat(composer.data_sajadah_harga, ", ", composer.gambar_iklan_sajadah,composer.gambar_iklan_sajadah)


                    local ucing = composer.gambar_iklan_sajadah

                    function onProduk( event )
                    	myImage:removeEventListener("tap", onProduk)
                    	--local function listener( event )
                    	composer.id_lempar = data.product_id --table.concat(composer.data_sajadah_id, ", ", ucing,ucing)
                    	if nil~= composer.getScene("test_detail") then composer.removeScene("test_detail", true) end
						composer.gotoScene( "test_detail" )

					end
					myImage:addEventListener("tap", onProduk )




                      local options = {

                     text = ("Rp. "..teks2..",-"),
                     x = posisi_teks_x + lebar * 0.1,
                     y = posisi_teks_y,
                     font = used_font_bold,
                     fontSize = 8  * (display.contentWidth / 320),
                     align = "left",
                     width = lebar 
                 	 }


                 	 local teks_produk_diskon = display.newText(options)
			         teks_produk_diskon.anchorX = 0
			         teks_produk_diskon.anchorY = 0
			         teks_produk_diskon:setFillColor(0.4);
			         


                 	 local options2 = {

                     text = string.upper(teks),
                     x = posisi_teks_x + lebar * 0.1,
                     y = teks_produk_diskon.y + teks_produk_diskon.height + 3,
                     font = used_font_bold,
                     fontSize = 10  * (display.contentWidth / 320),
                     align = "left",
                     width = lebar - lebar*0.2
                 	 }

                 	 

			         local teks_produk_diskon_harga = display.newText(options2)
			         teks_produk_diskon_harga.anchorX = 0
			         teks_produk_diskon_harga.anchorY = 0
			         teks_produk_diskon_harga:setFillColor(0.4);

                      composer.temp_x1 = myImage.x + myImage.width*myImage.xScale + display.contentWidth/7
                      composer.gambar_iklan_sajadah = composer.gambar_iklan_sajadah + 1

                      if(composer.gambar_iklan_sajadah%2 == 1)then
                      composer.posisi_y = teks_produk_diskon_harga.y + teks_produk_diskon_harga.height + display.contentHeight/20
                      end
                      composer.posisi_y2 = teks_produk_diskon_harga.y + teks_produk_diskon_harga.height + display.contentHeight/40 
                      local tinggi2 = teks_produk_diskon_harga.y + teks_produk_diskon_harga.height + display.contentHeight/50 - tinggi  
                      tinggi2 = composer.posisi_y2 - tinggi
                      local backitem = display.newRect(posisi_teks_x, tinggi,lebar, tinggi2)
                      backitem.anchorY = 0
                      backitem.anchorX = 0
                      backitem:setFillColor(230/255,230/255,230/255)

                     grup6:insert(backitem)
			         grup6:insert(teks_produk_diskon);
			         grup6:insert(teks_produk_diskon_harga);

                      composer.tinggi_scrollview = teks_produk_diskon_harga.y

                    local function networkListener( event )
					    if ( event.isError ) then
		                      print( "Network error - download failed" )
		              elseif ( event.phase == "began" ) then

		              elseif ( event.phase == "ended" ) then


		            local path = system.pathForFile( event.response.filename, event.response.baseDirectory )
					local fhd = io.open( path )

					if fhd then

                      local myImage = display.newImage( event.response.filename, event.response.baseDirectory, 20,  tes )
                      
                      myImage.anchorY = 0
                      if(count%2 == 1)then
                      		myImage.x = x1
                      		myImage.anchorX = 1
                      else
                      		myImage.x = x2
                      		myImage.anchorX = 0
                      end
                      myImage.y = y
                      myImage.width = 700
                      myImage.height = 959
                      myImage.xScale = (0.4 * display.contentWidth) / 700
                      myImage.yScale = (0.4 * display.contentWidth) / 700
                      myImage.alpha = 1
                      --transition.to( layer.myImage, { alpha = 1.0 , delay = 0} )
                      grup6:insert(myImage)


                      fhd:close()
					else
						
					end

                  	  end

					end

					local array_count = image:len() - 4
			        local array1 = image:sub(1,array_count)
			        local array2 = image:sub(-4)

			        local download = tostring(array1.."-203x266"..array2)
                    cancelperlengkapanmuslim[index] = network.download( download, "GET", networkListener,params, "perlengkapanmuslim"..index..".jpg", system.TemporaryDirectory, 0, 0 )

              end

              scrollView:insert(grup6)
               
        end



         function tampilPerlengkapanHaji()
          local index

          
          	composer.posisi_y = 0
             		composer.gambar_iklan_sajadah = 1


          	 local params = {}
             params.progress = true
     
             for index = 1, data_max do
      			   
             		--print(index)
                   local data = listData[index]
      			   

                    --composer.url_link = data.url_link
                    local image = data.image
                   
                    local count = composer.gambar_iklan_sajadah

                      local y = composer.posisi_y
                      local x1 = composer.posisi_x1
                      local x2 = composer.posisi_x2

                      local myImage = display.newImage( composer.imgDir.. "logo.png", 125, 39)
                      
                      myImage.anchorY = 0
                      if(count%2 == 1)then
                      		myImage.x = x1
                      		myImage.anchorX = 1
                      else
                      		myImage.x = x2
                      		myImage.anchorX = 0
                      end
                      myImage.y = composer.posisi_y
                      myImage.width = 700
                      myImage.height = 959
                      myImage.xScale = (0.4 * display.contentWidth) / 700
                      myImage.yScale = (0.4 * display.contentWidth) / 700
                      myImage.alpha = 1
                      --transition.to( layer.myImage, { alpha = 1.0 , delay = 0} )
                      grup7:insert(myImage)


                      local lebar = 700 * (0.4 * display.contentWidth) / 700
                      local posisi_teks_x = myImage.x + (myImage.width * myImage.xScale /2)

                       if(composer.gambar_iklan_sajadah%2 == 1)then
                       		--posisi_teks_x = myImage.x - (myImage.width * myImage.xScale /2)
                       		posisi_teks_x = myImage.x - (myImage.width * myImage.xScale)
                       else
                       		--posisi_teks_x = myImage.x + (myImage.width * myImage.xScale /2)
                       		posisi_teks_x = myImage.x
                       end

                      local posisi_teks_y = myImage.y + myImage.height * myImage.yScale + 10
                      local posisi_teks_y2 = posisi_teks_y 
                      local tinggi = posisi_teks_y - 10


                      local teks  = data.product--table.concat(composer.data_sajadah, ", ", composer.gambar_iklan_sajadah,composer.gambar_iklan_sajadah)
                      local teks2 = data.regular_price --table.concat(composer.data_sajadah_harga, ", ", composer.gambar_iklan_sajadah,composer.gambar_iklan_sajadah)


                    local ucing = composer.gambar_iklan_sajadah

                    function onProduk( event )
                    	myImage:removeEventListener("tap", onProduk)
                    	--local function listener( event )
                    	composer.id_lempar = data.product_id --table.concat(composer.data_sajadah_id, ", ", ucing,ucing)
                    	if nil~= composer.getScene("test_detail") then composer.removeScene("test_detail", true) end
						composer.gotoScene( "test_detail" )

					end
					myImage:addEventListener("tap", onProduk )




                      local options = {

                     text = ("Rp. "..teks2..",-"),
                     x = posisi_teks_x + lebar * 0.1,
                     y = posisi_teks_y,
                     font = used_font_bold,
                     fontSize = 8  * (display.contentWidth / 320),
                     align = "left",
                     width = lebar 
                 	 }


                 	 local teks_produk_diskon = display.newText(options)
			         teks_produk_diskon.anchorX = 0
			         teks_produk_diskon.anchorY = 0
			         teks_produk_diskon:setFillColor(0.4);
			         


                 	 local options2 = {

                     text = string.upper(teks),
                     x = posisi_teks_x + lebar * 0.1,
                     y = teks_produk_diskon.y + teks_produk_diskon.height + 3,
                     font = used_font_bold,
                     fontSize = 10  * (display.contentWidth / 320),
                     align = "left",
                     width = lebar - lebar*0.2
                 	 }

                 	 

			         local teks_produk_diskon_harga = display.newText(options2)
			         teks_produk_diskon_harga.anchorX = 0
			         teks_produk_diskon_harga.anchorY = 0
			         teks_produk_diskon_harga:setFillColor(0.4);

                      composer.temp_x1 = myImage.x + myImage.width*myImage.xScale + display.contentWidth/7
                      composer.gambar_iklan_sajadah = composer.gambar_iklan_sajadah + 1

                      if(composer.gambar_iklan_sajadah%2 == 1)then
                      composer.posisi_y = teks_produk_diskon_harga.y + teks_produk_diskon_harga.height + display.contentHeight/20
                      end
                      composer.posisi_y2 = teks_produk_diskon_harga.y + teks_produk_diskon_harga.height + display.contentHeight/40 
                      local tinggi2 = teks_produk_diskon_harga.y + teks_produk_diskon_harga.height + display.contentHeight/50 - tinggi  
                      tinggi2 = composer.posisi_y2 - tinggi
                      local backitem = display.newRect(posisi_teks_x, tinggi,lebar, tinggi2)
                      backitem.anchorY = 0
                      backitem.anchorX = 0
                      backitem:setFillColor(230/255,230/255,230/255)

                     grup7:insert(backitem)
			         grup7:insert(teks_produk_diskon);
			         grup7:insert(teks_produk_diskon_harga);

                      composer.tinggi_scrollview = teks_produk_diskon_harga.y

                    local function networkListener( event )
					    if ( event.isError ) then
		                      print( "Network error - download failed" )
		              elseif ( event.phase == "began" ) then

		              elseif ( event.phase == "ended" ) then


		            local path = system.pathForFile( event.response.filename, event.response.baseDirectory )
					local fhd = io.open( path )

					if fhd then

                      local myImage = display.newImage( event.response.filename, event.response.baseDirectory, 20,  tes )
                      
                      myImage.anchorY = 0
                      if(count%2 == 1)then
                      		myImage.x = x1
                      		myImage.anchorX = 1
                      else
                      		myImage.x = x2
                      		myImage.anchorX = 0
                      end
                      myImage.y = y
                      myImage.width = 700
                      myImage.height = 959
                      myImage.xScale = (0.4 * display.contentWidth) / 700
                      myImage.yScale = (0.4 * display.contentWidth) / 700
                      myImage.alpha = 1
                      --transition.to( layer.myImage, { alpha = 1.0 , delay = 0} )
                      grup7:insert(myImage)


                      fhd:close()
					else
						
					end

                  	  end

					end

					local array_count = image:len() - 4
			        local array1 = image:sub(1,array_count)
			        local array2 = image:sub(-4)

			        local download = tostring(array1.."-203x266"..array2)
                    cancelperlengkapanhaji[index] = network.download( download, "GET", networkListener,params, "perlengkapanhaji"..index..".jpg", system.TemporaryDirectory, 0, 0 )

              end

              scrollView:insert(grup7)
               
        end

		local function dataResponseListener3( event )

          if ( event.isError ) then
            -- TODO Show error here
              --print( "Network error!" )
              --loadIconListener()

          else
            --print( "App data loaded" )
            listData = json.decode( event.response )
            -- yang ini nerima data json dari server, gampangna mah data dari server d masukin ke array.


            data_max = table.getn(listData);
            composer.data_max = data_max

            local data
            composer.table1 = {}
            composer.data_harga = {}
            composer.data_id = {}

            for index = 1, data_max do
            	data = listData[index]
            	table.insert(composer.table1, index, data.product)	
            	table.insert(composer.data_harga, index, data.regular_price)
            	table.insert(composer.data_id, index, data.product_id)
            end


            ----print("data length: "..data_max)

            tampilBerita3()

           end
        end


        local function dataResponseListenerSajadah( event )

          if ( event.isError ) then
            -- TODO Show error here
              --print( "Network error!" )
              --loadIconListener()

          else
            --print( "App data loaded" )
            listData = json.decode( event.response )
            -- yang ini nerima data json dari server, gampangna mah data dari server d masukin ke array.


            data_max = table.getn(listData);
            composer.data_max = data_max

            local data
            composer.data_sajadah = {}
            composer.data_sajadah_harga = {}
            composer.data_sajadah_id = {}

            for index = 1, data_max do
            	data = listData[index]
            	table.insert(composer.data_sajadah, index, data.product)	
            	table.insert(composer.data_sajadah_harga, index, data.regular_price)
            	table.insert(composer.data_sajadah_id, index, data.product_id)
            
            end

            tampilSajadah()

           end
        end



        local function dataResponseListenerMakanan( event )

          if ( event.isError ) then
            -- TODO Show error here
              --print( "Network error!" )
              --loadIconListener()

          else
            --print( "App data loaded" )
            listData = json.decode( event.response )
            -- yang ini nerima data json dari server, gampangna mah data dari server d masukin ke array.


            data_max = table.getn(listData);
            composer.data_max = data_max

            local data
            composer.data_makanan = {}
            composer.data_makanan_harga = {}
            composer.data_makanan_id = {}

            for index = 1, data_max do
            	data = listData[index]
            	table.insert(composer.data_makanan, index, data.product)	
            	table.insert(composer.data_makanan_harga, index, data.regular_price)
            	table.insert(composer.data_makanan_id, index, data.product_id)
            end


            tampilMakanan()

           end
        end



         local function dataResponseListenerOlehHaji( event )

          if ( event.isError ) then
            -- TODO Show error here
              --print( "Network error!" )
              --loadIconListener()

          else
            ----print( "App data loaded" )
            listData = json.decode( event.response )
            -- yang ini nerima data json dari server, gampangna mah data dari server d masukin ke array.


            data_max = table.getn(listData);
            composer.data_max = data_max

            local data
            composer.data_olehhaji = {}
            composer.data_olehhaji_harga = {}
            composer.data_olehhaji_id= {}

            for index = 1, data_max do
            	data = listData[index]
            	table.insert(composer.data_olehhaji, index, data.product)	
            	table.insert(composer.data_olehhaji_harga, index, data.regular_price)
            	table.insert(composer.data_olehhaji_id, index, data.product_id)
            end

            tampilOlehHaji()

           end
        end


        local function dataResponseListenerBusanaMuslim( event )

          if ( event.isError ) then
            -- TODO Show error here
              --print( "Network error!" )
              --loadIconListener()

          else
            ----print( "App data loaded" )
            listData = json.decode( event.response )
            -- yang ini nerima data json dari server, gampangna mah data dari server d masukin ke array.


            data_max = table.getn(listData);
            composer.data_max = data_max

            local data
            composer.data_busanamuslim = {}
            composer.data_busanamuslim_harga = {}
            composer.data_busanamuslim_id = {}

            for index = 1, data_max do
            	data = listData[index]
            	table.insert(composer.data_busanamuslim, index, data.product)	
            	table.insert(composer.data_busanamuslim_harga, index, data.regular_price)
            	table.insert(composer.data_busanamuslim_id, index, data.product_id)	
            end

            tampilBusanaMuslim()

           end
        end



        local function dataResponseListenerPerlengkapanMuslim( event )

          if ( event.isError ) then
            -- TODO Show error here
              --print( "Network error!" )
              --loadIconListener()

          else
            ----print( "App data loaded" )
            listData = json.decode( event.response )
            -- yang ini nerima data json dari server, gampangna mah data dari server d masukin ke array.


            data_max = table.getn(listData);
            composer.data_max = data_max

            local data
            composer.data_perlengkapanmuslim = {}
            composer.data_perlengkapanmuslim_harga = {}
            composer.data_perlengkapanmuslim_id = {}

            for index = 1, data_max do
            	data = listData[index]
            	table.insert(composer.data_perlengkapanmuslim, index, data.product)	
            	table.insert(composer.data_perlengkapanmuslim_harga, index, data.regular_price)
            	table.insert(composer.data_perlengkapanmuslim_id, index, data.product_id)	
            end

            tampilPerlengkapanMuslim()

           end
        end



         local function dataResponseListenerPerlengkapanHaji( event )

          if ( event.isError ) then
            -- TODO Show error here
              --print( "Network error!" )
              --loadIconListener()

          else
            ----print( "App data loaded" )
            listData = json.decode( event.response )
            -- yang ini nerima data json dari server, gampangna mah data dari server d masukin ke array.


            data_max = table.getn(listData);
            composer.data_max = data_max

            local data
            composer.data_perlengkapanhaji = {}
            composer.data_perlengkapanhaji_harga = {}
            composer.data_perlengkapanhaji_id = {}

            for index = 1, data_max do
            	data = listData[index]
            	table.insert(composer.data_perlengkapanhaji, index, data.product)	
            	table.insert(composer.data_perlengkapanhaji_harga, index, data.regular_price)
            	table.insert(composer.data_perlengkapanhaji_id, index, data.product_id)
            end

            tampilPerlengkapanHaji()

           end
        end



        

         function tampilSlider()
          local index

          	 --print("masuk fungsi")
     
             for index = 1, composer.data_max_slider do
      
                  local data = listData[index]


                  	local params = {}
             		params.progress = true
             		params.timeout = 50000
             		local x = composer.temp_x


             		local x = (index-1) * display.contentWidth

                    local id = data.id
                    local image = data.image
                    local urlweb = data.url

                 
                   	--local nama_produk = {}

                   	--print(image)

                   	local myImage

			          myImage = display.newImage( composer.imgDir.. "logo.png", 125, 39  )
	  				  myImage.anchorX = 0
	                  myImage.anchorY = 0
	                  myImage.x = x--composer.temp_x
	                  myImage.y = 0
	                  myImage.width = 808
	                  myImage.height = 400
	                  myImage.xScale = (display.contentWidth) / 808
	                  myImage.yScale = (display.contentWidth) / 808
	                  myImage.alpha = 0
	                  scrollView_banner:insert(myImage)




	                

                    local function networkListener( event )
					    if ( event.isError ) then
		                      --print( "Network error - download failed" )
		              elseif ( event.phase == "began" ) then
		                      cancelall[began] = event.requestId
		                      ----print( "Progress Phase: began onyon" )
		                      began = began + 1
		                      
		              elseif ( event.phase == "ended" ) then
		                   
		              		
		               	local path = system.pathForFile( event.response.filename, event.response.baseDirectory )
						local fhd = io.open( path )

						-- Determine if file exists
						if fhd then
		               
		              	  local myImage

		              	  myImage = display.newImage( event.response.filename, event.response.baseDirectory ,20,  tes )


		  				  myImage.anchorX = 0
		                  myImage.anchorY = 0
		                  myImage.x = x--composer.temp_x
		                  myImage.y = 0
		                  myImage.width = 808
		                  myImage.height = 400
		                  myImage.xScale = (display.contentWidth) / 808
		                  myImage.yScale = (display.contentWidth) / 808
		                  myImage.alpha = 1
		                  scrollView_banner:insert(myImage)
	                  	 
		                local function onBanner()
							local popupOptions =
							{
							    url = urlweb,
							}
				 			
							-- Check if the Safari View is available
							local safariViewAvailable = native.canShowPopup( "safariView" )
							 
							if safariViewAvailable then
							    -- Show the Safari View
							    native.showPopup( "safariView", popupOptions )
							else
								system.openURL(urlweb);
							end
						end

						myImage:addEventListener("tap", onBanner)


	                  	 --print(loadall)
	              		if(loadall == total_load - 1)then
	              			--print("masuk fungsi")
	                      	hideover()
	                    end
	                    loadall = loadall + 1

	                	end
	                  end







					end


			        local array_count = image:len() - 4
			        local array1 = image:sub(1,array_count)
			        local array2 = image:sub(-4)

			        --http://bursasajadah.com/files/slider/slider-bursa-sajadah-tin.png

			        local download = tostring("http://bursasajadah.com/files/slider/"..image)


			        --print(download)
			        --local download = "https://pmcdeadline2.files.wordpress.com/2016/07/logo-tv-logo.png"


                    --local gambar_remote = display.loadRemoteImage( "http://coronalabs.com/images/coronalogogrey.png", "GET", networkListener, "coronalogogrey.png", system.TemporaryDirectory, display.contentCenterX, 300 )
                    --scrollView:insert(gambar_remote)
                    cancelbanner[index] = network.download( download, "GET", networkListener,params, "banner"..index..".jpg", system.TemporaryDirectory, 0, 0 )

                    ----print(composer.namagambar)

              end
               
        end



        local function dataResponseSlider( event )

          if ( event.isError ) then
            -- TODO Show error here
              --print( "Network error!" )
              --loadIconListener()

          else
            ----print( "App data loaded" )
            listData = json.decode( event.response )
            -- yang ini nerima data json dari server, gampangna mah data dari server d masukin ke array.

           -- --print(event.response)
            data_max = table.getn(listData);
           	total_load = total_load + data_max
            --print(data_max)
            composer.data_max_slider = data_max

            tampilSlider()

           end
        end



       dl_id7 = network.request( "http://api.bursasajadah.com/api/bursasajadah/slider", "GET", dataResponseSlider )
       dl_id1 = network.request( "http://api.bursasajadah.com/api/bursasajadah/produkcategory/oleh-oleh-paket-hemat/6/0", "GET", dataResponseListener3 )
       dl_id2 = network.request( "http://api.bursasajadah.com/api/bursasajadah/produk/71/6/0", "GET", dataResponseListenerSajadah )
       dl_id3 = network.request( "http://api.bursasajadah.com/api/bursasajadah/produkcategory/oleh-oleh-kacang-arab/6/0", "GET", dataResponseListenerMakanan )
       dl_id4 = network.request( "http://api.bursasajadah.com/api/bursasajadah/produkcategory/oleh-oleh-buah-tin-dan-kismis/6/0", "GET", dataResponseListenerOlehHaji )
       dl_id5 = network.request( "http://api.bursasajadah.com/api/bursasajadah/produkcategory/oleh---oleh-souvenir/6/0", "GET", dataResponseListenerBusanaMuslim )
      dl_id6 = network.request( "http://api.bursasajadah.com/api/bursasajadah/produk/64/6/0", "GET", dataResponseListenerPerlengkapanMuslim )
      dl_id7 = network.request( "http://api.bursasajadah.com/api/bursasajadah/produk/61/6/5", "GET", dataResponseListenerPerlengkapanHaji )





       
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
		

		network.cancel( dl_id )
		network.cancel( dl_id1 )
		network.cancel( dl_id2 )
		network.cancel( dl_id3 )
		network.cancel( dl_id4 )
		network.cancel( dl_id5 )
		network.cancel( dl_id6 )
		network.cancel( dl_id7 )
          local i

          for i = 1 , 10 do
            
            network.cancel( cancelprodukterbaru[i])
            network.cancel( cancelsajadah[i])
            network.cancel( cancelmakanan[i])
            network.cancel( cancelolehhaji[i])
            network.cancel( cancelperlengkapanhaji[i])
            network.cancel( cancelperlengkapanmuslim[i])
            network.cancel( cancelbusanamuslim[i])
            network.cancel( cancelbanner[i])
           
          end

          composer.cancelAllTimers(); 
          


          --composer.cancelAllTimers();
          
        display.remove(scrollView_banner)  
		display.remove(scrollView_menu7)
		display.remove(scrollView_menu6)
		display.remove(scrollView_menu5)
		display.remove(scrollView_menu4)
		display.remove(scrollView_menu3)
		display.remove(scrollView_menu2)
		display.remove(scrollView_menu1)
		display.remove(scrollView)
		display.remove(scrolltest_detail)
		timer.cancel(id_timer)

		Runtime:removeEventListener( "key", onKeyEventExit )

		if(teksfield ~= nil)then
			teksfield:removeSelf()
			teksfield = nil
		end
		
		--sceneGroup:removeSelf()

		-- network.cancel( dl_id ) 
  --         local i
  --         for i = 1 , composer.data_max do
  --           local idevent = cancelall[i]
  --           network.cancel( idevent)
  --           --print(cancelall[i])
  --         end
  --         composer.cancelAllTimers(); 

		--scrolltest_detail.removeSelf()
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		
		--composer.removeHidden()
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
  --           --print(cancelall[i])
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