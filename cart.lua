-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------
local widget = require( "widget" )
local json = require ("json")
local composer = require( "composer" )
local scene = composer.newScene()
local used_font = "Raleway-Regular.ttf"
local used_font_bold = "Raleway-Bold.ttf"
composer.id_kategori = 0
composer.status_kategori= 1 
composer.halaman_page = 0
local cancelall = {}
local began = 1
local loadall = 0
composer.page = 1
local looptimer = 0
local teksfield
cur_page = "cart"

 

require "sqlite3"

local datab = "data.db"
local path = system.pathForFile(datab, system.DocumentsDirectory)
db = sqlite3.open( path )
 


function scene:create( event )

	began = 1
	local teks_search
	local grup_menu = display.newGroup()


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
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.
	
	-- create a white background to fill screen
	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 1 )	-- white
	

	local background2 = display.newRect( display.contentCenterX, 0, display.contentWidth, display.contentHeight/5)
	background2.anchorY = 0
	background2:setFillColor( 133/255,190/255,72/255)
	

	local logo = display.newImageRect( composer.imgDir.. "logo.png", 125, 39 ); 
	logo.x = display.contentCenterX;
	logo.y =  0 + display.contentCenterY / 11
	logo.anchorY = 0.5
	--logo:scale(0.5,0.5)
	logo.xScale = (display.contentWidth/4) / logo.width 
	logo.yScale = (display.contentWidth/4) / logo.width 


	local function onMenu()

		if(teksfield~=nil)then
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
	local menu = display.newImageRect( composer.imgDir.. "menu.png", 110, 88 ); 
	menu.x = 0 + 20 ;
	menu.y =  0 + display.contentCenterY / 11
	menu.anchorY = 0.5
	menu.anchorX = 0
	--menu:scale(0.5,0.5)
	menu.xScale = (background2.height/6) / menu.height
	menu.yScale = (background2.height/6) / menu.height


	menu:addEventListener("tap", onMenu)
	

	

	function onLogoView( event )
		composer.gotoScene( "view1" )
	end
	--logo:addEventListener("tap", onLogoView )
	
	-- create some text



 --    function onSecondView( event )
	-- 	composer.gotoScene( "view2" )
	-- end
 --    title:addEventListener("tap", onSecondView ) 



   

 	local teks_log = ""
 	if(composer.is_login == '1')then
 			teks_log = "Profile"
 	else
 			teks_log = "Login"
 	end
	local login = display.newText( teks_log, display.contentWidth - 20 , 0 + display.contentHeight / 20, used_font_bold, 15  * (display.contentWidth / 320)  )
	login.anchorX = 1
	login.anchorY = 0.5
	login.alpha = 1

	local function showMenu()
		if(teks_log == "Login")then
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
	login:addEventListener("tap", showMenu)

	local pembelian = display.newText( "Pembelian Saya", display.contentWidth - 20 , login.y + login.height + 5, used_font_bold, 13  * (display.contentWidth / 320)  )
	pembelian.anchorX = 1
	pembelian.anchorY = 0.5
	pembelian.alpha = 1
	pembelian:setFillColor(0)

	local function on_pembelian()
		composer.gotoScene("cart")
	end
	pembelian:addEventListener("tap", on_pembelian)

	local informasi = display.newText( "Informasi Akun", display.contentWidth - 20 , pembelian.y + pembelian.height + 5, used_font_bold, 13  * (display.contentWidth / 320)  )
	informasi.anchorX = 1
	informasi.anchorY = 0.5
	informasi.alpha = 1
	informasi:setFillColor(0)

	local function on_informasi()
		composer.gotoScene("informasi_akun")
	end
	informasi:addEventListener("tap", on_informasi)

	
	function onLogoutView( event )

		composer.is_login = 0
        local tablesetup = [[UPDATE is_login set status_login = '0';]]
		db:exec( tablesetup )
		local tablesetup = [[UPDATE is_login set id_user = '0';]]
		db:exec( tablesetup )

		if nil~= composer.getScene("home") then composer.removeScene("home", true) end  

        composer.gotoScene( "home" )
    	
   
	end

	local logout = display.newText( "Logout", display.contentWidth - 20 , informasi.y + informasi.height + 5, used_font_bold, 13  * (display.contentWidth / 320)  )
	logout.anchorX = 1
	logout.anchorY = 0.5
	logout.alpha = 1
	logout:setFillColor(0)

	logout:addEventListener("tap", onLogoutView )

	local back_menu = display.newRect(pembelian.x - pembelian.width/2, pembelian.y, informasi.width + display.contentWidth/20, pembelian.height + 3)
	back_menu:setFillColor(255/255,254/255,239/255)
	grup_menu:insert(back_menu)

	local back_menu = display.newRect(pembelian.x - pembelian.width/2, informasi.y, informasi.width + display.contentWidth/20, informasi.height + 3)
	back_menu:setFillColor(255/255,254/255,239/255)
	grup_menu:insert(back_menu)

	local back_menu = display.newRect(pembelian.x - pembelian.width/2, logout.y, informasi.width + display.contentWidth/20, logout.height + 3)
	back_menu:setFillColor(255/255,254/255,239/255)
	grup_menu:insert(back_menu)

	grup_menu:insert(pembelian)
	grup_menu:insert(informasi)
	grup_menu:insert(logout)


	function onLoginView( event )
		

	--title:setFillColor( 1 )	-- black
	  if(teksfield ~= nil)then
      teksfield:removeSelf()
      teksfield = nil
  	  end


		if(composer.search ~= nil)then
		if nil~= composer.getScene("login") then composer.removeScene("login", true) end  
        if  self.type == "press" then 
            self:setEnabled(false) 
        else 
            --self:removeEventListener( "tap", onMenu1 ) 
        end 
        composer.gotoScene( "login" ) 
   		end
	end


	


	
	

	composer.tinggi_header = background2.height
	
	scrollView = widget.newScrollView(
	    {
	        top = 0 + composer.tinggi_header,
	        left = 0,
	        width = display.contentWidth,
	        height = display.contentHeight - composer.tinggi_header,
	        horizontalScrollDisabled = true,
	        isBounceEnabled = true,
	        --backgroundColor = {0,0.4, 0.1, 1}
	        --scrollWidth = 600,
	        --scrollHeight = 2000,
	        --listener = scrollListener

	    }
	)

	scrollView2 = widget.newScrollView(
	    {
	        top = composer.tinggi_header - display.contentHeight /20,
	        left = 0,
	        width = display.contentWidth,
	        height = display.contentHeight / 20,
	        horizontalScrollDisabled = false,
	        verticalScrollDisabled = true,
	        backgroundColor = {133/255,190/255,72/255},
	        --backgroundColor = {120/255,190/255,72/255},
	        isBounceEnabled = false,
	        --scrollWidth = 600,
	        --scrollHeight = 2000,
	        --listener = scrollListener

	    }
	)

		
	--composer.tinggi_teksfield = logo.y + logo.height + display.contentHeight / 100 
	composer.tinggi_teksfield = scrollView2.y - scrollView2.height

	--local function hideover()

	local function hideover()

    	composer.hideOverlay("fade", 100)
	end
    
    timer.performWithDelay(3000, hideover)

    local function createteksfield()

    	

    	teksfield = native.newTextField(  0 , composer.tinggi_teksfield , 0.9 * display.contentWidth, 30 )
		teksfield.anchorX = 0
		teksfield.alpha = 1
		sceneGroup:insert( teksfield )

		native.setKeyboardFocus( teksfield )


		local function fieldHandler_t(event) 
               if ("began" == event.phase) then 
                  if name ~= nil then
                    --name:removeSelf()
                    --name = nil
                  end
               elseif ("ended" == event.phase) then 
                  composer.search = teksfield.text
                  teks_search.text = teksfield.text
                  if(teksfield ~= nil)then
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


		local myRectangle1 = display.newRect( 0 , composer.tinggi_teksfield , 0.9 * display.contentWidth, 30 )
		myRectangle1.strokeWidth = 0
		myRectangle1.anchorX = 0
		myRectangle1:setFillColor( 1 )
		myRectangle1:setStrokeColor(1 )
		

		myRectangle1:addEventListener("tap", createteksfield)


		teks_search = display.newText( "Search", 20, myRectangle1.y , used_font, 10  * (display.contentWidth / 320))
		teks_search.anchorX = 0
		teks_search:setFillColor(0)
		


        local myRectangle = display.newRect( display.contentWidth, composer.tinggi_teksfield, 0.1 * display.contentWidth, 30 )
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
		search.yScale = (0.9 * myRectangle.height) / search.width 
		

		function onLoginView( event )
		
		  search:removeEventListener("tap", onLoginView )
		--title:setFillColor( 1 )	-- black
		  if(teksfield ~= nil)then
	      teksfield:removeSelf()
	      teksfield = nil
	  	  end


			if(composer.search ~= nil)then
			if nil~= composer.getScene("login") then composer.removeScene("login", true) end  
	        if  self.type == "press" then 
	            self:setEnabled(false) 
	        else 
	            --self:removeEventListener( "tap", onMenu1 ) 
	        end 
	        composer.gotoScene( "login" ) 
	   		end
		end
	
		search:addEventListener("tap", onLoginView )


	--end



	local menu1 = display.newText( "Sajadah & Karpet", 10 , scrollView2.height /2, used_font, 12  * (display.contentWidth / 320))
	menu1.anchorY = 0.5
	menu1.anchorX = 0
	menu1:setFillColor( 1 )
	scrollView2:insert(menu1)



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
	      
	            if nil~= composer.getScene("menu1") then composer.removeScene("menu1", true) end  
	            if  self.type == "press" then 
	                self:setEnabled(false) 
	            else 
	                
	            end 

	            
	            composer.gotoScene( "menu1" ) 
	   end 



	local menu2 = display.newText( "Makanan", menu1.x + menu1.width + display.contentWidth/10 , scrollView2.height /2, used_font, 12  * (display.contentWidth / 320))
	menu2.anchorY = 0.5
	menu2.anchorX = 0
	menu2:setFillColor( 1 )
	scrollView2:insert(menu2)


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
	      
	            if nil~= composer.getScene("menu2") then composer.removeScene("menu2", true) end  
	            if  self.type == "press" then 
	                self:setEnabled(false) 
	            else 
	                
	            end 
	            composer.gotoScene( "menu2" ) 
	        
	   end 

	local menu3 = display.newText( "Oleh - Oleh Haji", menu2.x + menu2.width + display.contentWidth/10, scrollView2.height /2, used_font, 12  * (display.contentWidth / 320))
	menu3.anchorY = 0.5
	menu3.anchorX = 0
	menu3:setFillColor( 1 )
	scrollView2:insert(menu3)


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
	      
	            if nil~= composer.getScene("menu3") then composer.removeScene("menu3", true) end  
	            if  self.type == "press" then 
	                self:setEnabled(false) 
	            else 
	                
	            end 
	            composer.gotoScene( "menu3" ) 
	        
	   end 


	local menu4 = display.newText( "Perlengkapan Haji", menu3.x + menu3.width + display.contentWidth/10 , scrollView2.height /2, used_font, 12  * (display.contentWidth / 320))
	menu4.anchorY = 0.5
	menu4.anchorX = 0
	menu4:setFillColor( 1 )
	scrollView2:insert(menu4)


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
	      
	            if nil~= composer.getScene("menu4") then composer.removeScene("menu4", true) end  
	            if  self.type == "press" then 
	                self:setEnabled(false) 
	            else 
	                
	            end 
	            composer.gotoScene( "menu4" ) 
	        
	   end 

	local menu5 = display.newText( "Perlengkapan Muslim", menu4.x + menu4.width + display.contentWidth/10, scrollView2.height /2, used_font, 12  * (display.contentWidth / 320))
	menu5.anchorY = 0.5
	menu5.anchorX = 0
	menu5:setFillColor( 1 )
	scrollView2:insert(menu5)


	local function onmenu5(event) 
				composer.halaman_page = 0
				self:removeEventListener( "tap", onmenu5 ) 
				for i = 1 , 75 do
		            local idevent = cancelall[i]
		            network.cancel( idevent)
		            --print("hesemelehe "..cancelall[i])
		          end
		          composer.cancelAllTimers();

				composer.status_kategori= 1 
	            but_menu5(menu5)
	            composer.id_kategori = 61
	          return true 
	       end 
	       menu5:addEventListener("tap", onmenu5 ) 

	   function but_menu5(self) 
	      
	            if nil~= composer.getScene("menu5") then composer.removeScene("menu5", true) end  
	            if  self.type == "press" then 
	                self:setEnabled(false) 
	            else 
	                
	            end 
	            composer.gotoScene( "menu5" )  
	        
	   end 


	local menu6 = display.newText( "Busana Muslim", menu5.x + menu5.width + display.contentWidth/10, scrollView2.height /2, used_font, 12  * (display.contentWidth / 320))
	menu6.anchorY = 0.5
	menu6.anchorX = 0
	menu6:setFillColor( 1 )
	scrollView2:insert(menu6)


	local function onmenu6(event) 
				composer.halaman_page = 0
				self:removeEventListener( "tap", onmenu6 )
				for i = 1 , 75 do
		            local idevent = cancelall[i]
		            network.cancel( idevent)
		            --print("hesemelehe "..cancelall[i])
		          end
		          composer.cancelAllTimers();

				composer.status_kategori= 1 
	            but_menu6(menu6)
	            composer.id_kategori = 61
	          return true 
	       end 
	       menu6:addEventListener("tap", onmenu6 ) 

	   function but_menu6(self) 
	      
	            if nil~= composer.getScene("menu6") then composer.removeScene("menu6", true) end  
	            if  self.type == "press" then 
	                self:setEnabled(false) 
	            else 
	                 
	            end 
	            composer.gotoScene( "menu6" ) 
	        
	   end 



	local menu7 = display.newText( "Produk Diskon", menu6.x + menu6.width + display.contentWidth/10 , scrollView2.height /2, used_font, 12  * (display.contentWidth / 320))
	menu7.anchorY = 0.5
	menu7.anchorX = 0
	menu7:setFillColor( 1 )
	scrollView2:insert(menu7)


	local function onmenu7(event) 
				composer.halaman_page = 0
				self:removeEventListener( "tap", onmenu7 ) 
				for i = 1 , 75 do
		            local idevent = cancelall[i]
		            network.cancel( idevent)
		            --print("hesemelehe "..cancelall[i])
		          end
		          composer.cancelAllTimers();

	            but_menu7(menu7)
	            composer.id_kategori = 61
	            composer.status_kategori = 1
	          return true 
	       end 
	       menu7:addEventListener("tap", onmenu7 ) 

	   function but_menu7(self) 
	      
	            if nil~= composer.getScene("menu7") then composer.removeScene("menu7", true) end  
	            if  self.type == "press" then 
	                self:setEnabled(false) 
	            else 
	                
	            end 
	            composer.gotoScene( "menu7" ) 
	        
	   end 


	local spasi1 = display.newText( " ", menu7.x + menu7.width + 20 , 10, used_font_bold, 12  * (display.contentWidth / 320))
	spasi1.anchorY = 0
	spasi1.anchorX = 0
	spasi1:setFillColor( 1 )
	scrollView2:insert(spasi1)



	-- local line2 = display.newLine( 0, composer.tinggi_teks_email + display.contentHeight/30, display.contentWidth, composer.tinggi_teks_email + display.contentHeight/30 )
	-- line2:setStrokeColor( 133/255,190/255,72/255)
	-- line2.strokeWidth = 2
	-- scrollView:insert(line2)
	-- composer.tinggi_line2 = line2.y



	local function scrollListener( event )
 
	    local phase = event.phase
 
		    if ( phase == "moved" ) then
		        local dy = math.abs( ( event.y - event.yStart ) )
		        -- If the touch on the button has moved more than 10 pixels,
		        -- pass focus back to the scroll view so it can continue scrolling
		        if ( dy > 30 ) then
		            scrollView:takeFocus( event )
		        end
		    end
		    return true
		end




	  -- myImage.width = 808
   --    myImage.height = 400
   --    myImage.xScale = (display.contentWidth) / 808
   --    myImage.yScale = (display.contentWidth) / 808


	scrollView_banner = widget.newScrollView(
	    {
	        top = display.contentHeight/20,
	        left = 0,
	        width = display.contentWidth,
	        height = 400 * (display.contentWidth) / 808,
	        horizontalScrollDisabled = false,
	        verticalScrollDisabled = false,
	        --backgroundColor = {133/255,190/255,72/255},
	        isBounceEnabled = false,
	        --scrollWidth = 600,
	        scrollHeight = 1,

	        listener = scrollListener

	    }
	)
	scrollView_banner:setIsLocked(true)
	


	local function timerslider()

		if(looptimer < composer.data_max_slider)then
		scrollView_banner:scrollToPosition
		{
			x = display.contentWidth * (-looptimer)
		}
		end

		--print("looping : "..display.contentWidth * looptimer)

			if(looptimer == composer.data_max_slider)then
				looptimer = 0
			else
				looptimer = looptimer + 1
			end
	end
	id_timer = timer.performWithDelay(5000, timerslider, -1)


	scrollView:insert(scrollView_banner)
	local teks_diskon = display.newText( "Keranjang Belanja", display.contentCenterX, display.contentHeight/20 , used_font, 15  * (display.contentWidth / 320))
	teks_diskon.anchorX = 0.5
	teks_diskon:setFillColor(0)
	scrollView:insert(teks_diskon)
	composer.tinggi_line2 = teks_diskon.y

	local line2 = display.newLine( 0 + 0.05 * display.contentWidth, teks_diskon.y + display.contentHeight/40, display.contentWidth - display.contentWidth*0.05, teks_diskon.y + display.contentHeight/40 )
	line2:setStrokeColor( 133/255,190/255,72/255)
	line2.strokeWidth = 2
	scrollView:insert(line2)
	composer.tinggi_line2 = line2.y


	local tinggi_line2 = composer.tinggi_line2
	


	for row in db:nrows("SELECT * FROM t_produk_cart") do
    print( "Row " .. row.produk_id )


    local id_cart = row.t_produk_id
    print("id_cart = "..id_cart)

    local background_label = display.newRect( display.contentCenterX, tinggi_line2 + display.contentHeight/20, display.contentWidth * 0.95, display.contentHeight/7)
	background_label.anchorY = 0
	background_label:setFillColor( 255/255,254/255,239/255)
	scrollView:insert(background_label)


	local options = {
		 text = row.nama_produk,
         x = background_label.x - background_label.width/2 + 10,
         y = background_label.y + 5,
         font = used_font_bold,
         fontSize = 12  * (display.contentWidth / 320),
         align = "left",
         width = background_label.width - display.contentWidth/10
 	 }

	local nama_produk = display.newText(options)
	nama_produk.anchorX = 0
	nama_produk.anchorY = 0
	nama_produk:setFillColor(0)
	scrollView:insert(nama_produk)

	local button_x = display.newText( "X", background_label.x + background_label.width/2 - 10, background_label.y + 5, used_font, 15  * (display.contentWidth / 320))
	button_x.anchorX = 1
	button_x.anchorY = 0
	button_x:setFillColor(1,0,0)
	scrollView:insert(button_x)
	local function onButtonX()

		local tablesetup = [[DELETE FROM t_produk_cart WHERE t_produk_id=]]..id_cart..[[;]]
		db:exec(tablesetup)

		if nil~= composer.getScene("cart") then composer.removeScene("cart", true) end 
		composer.gotoScene("cart")
	end
	button_x:addEventListener("tap", onButtonX)

	local harga_produk = display.newText( "Rp."..row.price, background_label.x - background_label.width/2 + 10, nama_produk.y + nama_produk.height + 5, used_font, 11  * (display.contentWidth / 320))
	harga_produk.anchorX = 0
	harga_produk.anchorY = 0
	harga_produk:setFillColor(1,0,0)
	scrollView:insert(harga_produk)


	local qty_produk = display.newText( "Qty : "..row.qty, background_label.x - background_label.width/2 + 10, background_label.y + background_label.height - display.contentHeight/30, used_font, 12  * (display.contentWidth / 320))
	qty_produk.anchorX = 0
	qty_produk.anchorY = 0
	qty_produk:setFillColor(0)
	scrollView:insert(qty_produk)



 	
 	tinggi_line2 = tinggi_line2 + background_label.height + 10
	end
	--======================================================FOOTER======================================================--


	local function onCheckout()
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

		composer.showOverlay("overlay_menu", options_overlay)
		composer.gotoScene("checkout1")
	end

	local background_checkout = display.newRect( display.contentCenterX + 10, tinggi_line2 + display.contentHeight/10, display.contentWidth * 0.4, 50)
	background_checkout.anchorY = 0.5
	background_checkout.anchorX = 0
	background_checkout:setFillColor( 133/255,190/255,72/255)
	scrollView:insert(background_checkout)

	background_checkout:addEventListener("tap", onCheckout)



	local background_belanja_lagi = display.newRect( display.contentCenterX - 10, tinggi_line2 + display.contentHeight/10, display.contentWidth * 0.4, 50)
	background_belanja_lagi.anchorY = 0.5
	background_belanja_lagi.anchorX = 1
	background_belanja_lagi:setFillColor( 133/255,190/255,72/255)
	scrollView:insert(background_belanja_lagi)

	background_belanja_lagi:addEventListener("tap", onLogoView)

	local teks_email = display.newText( "CHECKOUT", background_checkout.x + background_checkout.width/2, background_checkout.y , used_font_bold, 12  * (display.contentWidth / 320))
	teks_email.anchorX = 0.5
	teks_email:setFillColor(1)
	scrollView:insert(teks_email)

	local teks_email = display.newText( "BELANJA LAGI", background_belanja_lagi.x - background_belanja_lagi.width/2, background_belanja_lagi.y , used_font_bold, 12  * (display.contentWidth / 320))
	teks_email.anchorX = 0.5
	teks_email:setFillColor(1)
	scrollView:insert(teks_email)


	local footer_background = display.newRect( display.contentCenterX, background_checkout.y + display.contentHeight/6, display.contentWidth, display.contentHeight/7)
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

	
	--================================================================================================================================













	-- all objects must be added to group (e.g. self.view)
	sceneGroup:insert( background )
	sceneGroup:insert( background2 )
	sceneGroup:insert(logo)
	sceneGroup:insert( menu )
	
	sceneGroup:insert( login )
	sceneGroup:insert( scrollView )
	sceneGroup:insert( scrollView2 )

	sceneGroup:insert(myRectangle1)
	sceneGroup:insert(teks_search)
	sceneGroup:insert(myRectangle)
	sceneGroup:insert(search)

	sceneGroup:insert(grup_menu)
	grup_menu.alpha = 0



	-- teksfield = native.newTextField( 0 + display.contentWidth/20, composer.tinggi_teksfield , 0.8 * display.contentWidth, 40 )
	-- 	teksfield.anchorX = 0
	-- 	teksfield.alpha = 1
	-- 	sceneGroup:insert( teksfield )

	
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then

	
	
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
	composer.removeHidden()


		local function loading()
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
		--composer.removeHidden()
       


		function tampilSlider()
          local index

          	 print("masuk fungsi")
     
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

                   	print(image)

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
						end
					end

					myImage:addEventListener("tap", onBanner)

                    local function networkListener( event )
					    if ( event.isError ) then
		                      print( "Network error - download failed" )
		              elseif ( event.phase == "began" ) then
		                      cancelall[began] = event.requestId
		                      --print( "Progress Phase: began onyon" )
		                      --began = began + 1
		                      
		              elseif ( event.phase == "ended" ) then
		                   
		              		print(loadall)
		              		--[[if(loadall == 70)then
		              			print("masuk fungsi")
		                      	hideover()
		                    end
		                    loadall = loadall + 1--]]
		               
		               
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
	                  	 
	                  	 began = began + 1
	                  	  if(began == composer.data_max_slider - 1)then
      			  			  composer.hideOverlay("fade", 200) 
      			 		  end


	                  end







					end


			        local array_count = image:len() - 4
			        local array1 = image:sub(1,array_count)
			        local array2 = image:sub(-4)

			        --http://bursasajadah.com/files/slider/slider-bursa-sajadah-tin.png

			        local download = tostring("http://bursasajadah.com/files/slider/"..image)

			        print(download)
			        --local download = "https://pmcdeadline2.files.wordpress.com/2016/07/logo-tv-logo.png"


                    --local gambar_remote = display.loadRemoteImage( "http://coronalabs.com/images/coronalogogrey.png", "GET", networkListener, "coronalogogrey.png", system.TemporaryDirectory, display.contentCenterX, 300 )
                    --scrollView:insert(gambar_remote)
                    dl_id = network.download( download, "GET", networkListener,params, "banner"..index..".jpg", system.TemporaryDirectory, 0, 0 )

                    --print(composer.namagambar)

              end
               
        end



        local function dataResponseSlider( event )

          if ( event.isError ) then
            -- TODO Show error here
              print( "Network error!" )
              --loadIconListener()

          else
            --print( "App data loaded" )
            listData = json.decode( event.response )
            -- yang ini nerima data json dari server, gampangna mah data dari server d masukin ke array.

           -- print(event.response)

            data_max = table.getn(listData);
            print(data_max)
            composer.data_max_slider = data_max

            tampilSlider()

           end
        end


        --dl_id7 = network.request( "http://api.bursasajadah.com/api/bursasajadah/slider", "GET", dataResponseSlider )
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
		
  		if(teksfield ~= nil)then
			teksfield:removeSelf()
			teksfield = nil
		end


        display.remove(scrollView_banner)  
	
		display.remove(scrollView)
		display.remove(scrollView2)
		--timer.cancel(id_timer)

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