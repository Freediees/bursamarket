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

		teksfield:removeSelf()
		teksfield = nil


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
 	if(composer.is_login == 1)then
 			teks_log = "Logout"
 	else
 			teks_log = "Login"
 	end
	local login = display.newText( teks_log, display.contentWidth - 20 , 0 + display.contentHeight / 20, used_font_bold, 15  * (display.contentWidth / 320)  )
	login.anchorX = 1
	login.anchorY = 0.5
	login.alpha = 1
	--title:setFillColor( 1 )	-- black


	function onLogoutView( event )

		
		if nil~= composer.getScene("login_fix") then composer.removeScene("login_fix", true) end  
        if  self.type == "press" then 
            self:setEnabled(false) 
        else 
            --self:removeEventListener( "tap", onMenu1 ) 
        end 
        composer.is_login = 0
        local tablesetup = [[UPDATE is_login set is_login = '0';]]
		db:exec( tablesetup )
        composer.gotoScene( "login_fix" ) 
   
	end


	function onLoginView( event )

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
	login:addEventListener("tap", onLogoutView )


	


	
	

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

    --composer.hideOverlay("fade", 100)
    

	    


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

	local teks1 = display.newText( "INFORMASI & PEMESANAN", display.contentCenterX , 0 + display.contentHeight / 20, used_font_bold, 15  * (display.contentWidth / 320))
	teks1.anchorX = 0.5
	teks1:setFillColor( 0 )
	scrollView:insert(teks1)

	local line = display.newLine( 0, teks1.height + display.contentHeight/ 15, display.contentWidth, teks1.height + display.contentHeight/ 15 )
	line:setStrokeColor( 133/255,190/255,72/255)
	line.strokeWidth = 2
	scrollView:insert(line)

	composer.tinggi_line = line.y

	print(composer.tinggi_line)

	local teks_bbm = display.newText( "BBM : BSAJADAH / 2BA9262A", display.contentCenterX + display.contentWidth / 20, line.y + display.contentHeight/30 , used_font_bold, 10 * (display.contentWidth / 320))
	teks_bbm.anchorX = 1
	teks_bbm:setFillColor(133/255,190/255,72/255)
	scrollView:insert(teks_bbm)
	composer.tinggi_teks_bbm = teks_bbm.y

	local button_teks_bbm = display.newText( "Click to invite", 20 + display.contentCenterX + display.contentWidth / 20, line.y + display.contentHeight/30 , used_font_bold, 10 * (display.contentWidth / 320))
	button_teks_bbm.anchorX = 0
	button_teks_bbm:setFillColor(244/255,209/255,66/255)
	scrollView:insert(button_teks_bbm)
	composer.tinggi_button_teks_bbm = button_teks_bbm.y

	local function onTeksBBM()
		system.openURL("bbmi://2BA9262A")
	end

	button_teks_bbm:addEventListener("tap", onTeksBBM)

	print("tinggi teks = "..composer.tinggi_teks_bbm)

	local teks_line = display.newText( "Line ID : @bursasajadah", display.contentCenterX + display.contentWidth / 20, composer.tinggi_teks_bbm + display.contentHeight/30 , used_font_bold, 10  * (display.contentWidth / 320))
	teks_line.anchorX = 1
	teks_line:setFillColor(133/255,190/255,72/255)
	scrollView:insert(teks_line)
	composer.tinggi_teks_line = teks_line.y


	local button_teks_line = display.newText( "Click to invite", 20 + display.contentCenterX + display.contentWidth / 20, composer.tinggi_teks_bbm + display.contentHeight/30, used_font_bold, 10 * (display.contentWidth / 320))
	button_teks_line.anchorX = 0
	button_teks_line:setFillColor(244/255,209/255,66/255)
	scrollView:insert(button_teks_line)
	composer.tinggi_button_teks_line = button_teks_line.y


	local function onTeksLine()
		system.openURL("https://line.me/R/ti/p/%40bursasajadah")
	end

	button_teks_line:addEventListener("tap", onTeksLine)

	print("tinggi teks = "..composer.tinggi_teks_bbm)



	local teks_sms = display.newText( "Telp/SMS : 081322131666", display.contentCenterX + display.contentWidth / 20, composer.tinggi_teks_line + display.contentHeight/30 , used_font_bold, 10  * (display.contentWidth / 320))
	teks_sms.anchorX = 1
	teks_sms:setFillColor(133/255,190/255,72/255)
	scrollView:insert(teks_sms)
	composer.tinggi_teks_sms = teks_sms.y


	local button_teks_sms = display.newText( "Click to call", 20 +  display.contentCenterX + display.contentWidth / 20, composer.tinggi_teks_line + display.contentHeight/30 , used_font_bold, 10  * (display.contentWidth / 320))
	button_teks_sms.anchorX = 0
	button_teks_sms:setFillColor(244/255,209/255,66/255)
	scrollView:insert(button_teks_sms)
	composer.tinggi_button_teks_sms = button_teks_sms.y


	local function onTeksSms()
		system.openURL("tel:+6281322141666")
	end

	button_teks_sms:addEventListener("tap", onTeksSms)

	print("tinggi teks = "..composer.tinggi_teks_bbm)

	local teks_whatsapp = display.newText( "Whatsapp : 081322131666", display.contentCenterX+ display.contentWidth / 20 , composer.tinggi_teks_sms + display.contentHeight/30 , used_font_bold, 10 * (display.contentWidth / 320))
	teks_whatsapp.anchorX = 1
	teks_whatsapp:setFillColor(133/255,190/255,72/255)
	scrollView:insert(teks_whatsapp)
	composer.tinggi_teks_whatsapp = teks_whatsapp.y

	local button_teks_whatsapp = display.newText( "Click to message", 20 + display.contentCenterX+ display.contentWidth / 20 , composer.tinggi_teks_sms + display.contentHeight/30 , used_font_bold, 10 * (display.contentWidth / 320))
	button_teks_whatsapp.anchorX = 0
	button_teks_whatsapp:setFillColor(244/255,209/255,66/255)
	scrollView:insert(button_teks_whatsapp)
	composer.tinggi_button_teks_whatsapp = button_teks_whatsapp.y

	local function onTekswhatsapp()
		system.openURL("intent://send/+6281322141666#Intent;scheme=smsto;package=com.whatsapp;action=android.intent.action.SENDTO;end")
	end

	button_teks_whatsapp:addEventListener("tap", onTekswhatsapp)

	print("tinggi teks = "..composer.tinggi_teks_bbm)

	local teks_whatsapp2 = display.newText( "whatsapp2 : 085813152023", display.contentCenterX + display.contentWidth / 20, composer.tinggi_teks_whatsapp + display.contentHeight/30 , used_font_bold, 10 * (display.contentWidth / 320))
	teks_whatsapp2.anchorX = 1
	teks_whatsapp2:setFillColor(133/255,190/255,72/255)
	scrollView:insert(teks_whatsapp2)
	composer.tinggi_teks_whatsapp2 = teks_whatsapp2.y


	local button_teks_whatsapp2 = display.newText( "Click to message", 20 + display.contentCenterX + display.contentWidth / 20, composer.tinggi_teks_whatsapp + display.contentHeight/30 , used_font_bold, 10 * (display.contentWidth / 320))
	button_teks_whatsapp2.anchorX = 0
	button_teks_whatsapp2:setFillColor(244/255,209/255,66/255)
	scrollView:insert(button_teks_whatsapp2)
	composer.tinggi_button_teks_whatsapp2 = button_teks_whatsapp2.y


	local function onTekswhatsapp2()
		system.openURL("intent://send/+6285813152023#Intent;scheme=smsto;package=com.whatsapp;action=android.intent.action.SENDTO;end")
	end

	button_teks_whatsapp2:addEventListener("tap", onTekswhatsapp2)


	local teks_email = display.newText( "email : admin@bursasajadah.com", display.contentCenterX + display.contentWidth / 20, composer.tinggi_teks_whatsapp2 + display.contentHeight/30 , used_font_bold, 10  * (display.contentWidth / 320))
	teks_email.anchorX = 1
	teks_email:setFillColor(133/255,190/255,72/255)
	scrollView:insert(teks_email)
	composer.tinggi_teks_email = teks_email.y


	local button_teks_email = display.newText( "Click to message", 20 +  display.contentCenterX + display.contentWidth / 20, composer.tinggi_teks_whatsapp2 + display.contentHeight/30 , used_font_bold, 10  * (display.contentWidth / 320))
	button_teks_email.anchorX = 0
	button_teks_email:setFillColor(244/255,209/255,66/255)
	scrollView:insert(button_teks_email)
	composer.tinggi_button_teks_email = button_teks_email.y

	local function onTeksEmail()
		system.openURL("mailto:admin@bursasajadah.com")
	end

	button_teks_email:addEventListener("tap", onTeksEmail)


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
	        top = teks_email.x + display.contentHeight/20,
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
	local teks_diskon = display.newText( "Keranjang Belanja", display.contentCenterX, scrollView_banner.y + scrollView_banner.height/1.25 , used_font, 15  * (display.contentWidth / 320))
	teks_diskon.anchorX = 0.5
	teks_diskon:setFillColor(0)
	scrollView:insert(teks_diskon)
	composer.tinggi_line2 = teks_diskon.y

	local line2 = display.newLine( 0 + 0.05 * display.contentWidth, teks_diskon.y + display.contentHeight/40, display.contentWidth - display.contentWidth*0.05, teks_diskon.y + display.contentHeight/40 )
	line2:setStrokeColor( 133/255,190/255,72/255)
	line2.strokeWidth = 2
	scrollView:insert(line2)
	composer.tinggi_line2 = line2.y






	--======================================================FOOTER======================================================--




	local footer_background = display.newRect( display.contentCenterX, line2.y + display.contentHeight/4, display.contentWidth, display.contentHeight/7)
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


	teksfield = native.newTextField( 0 + display.contentWidth/20, composer.tinggi_teksfield , 0.8 * display.contentWidth, 40 )
		teksfield.anchorX = 0
		teksfield.alpha = 1
		sceneGroup:insert( teksfield )

		local function fieldHandler_t(event) 
               if ("began" == event.phase) then 
                  if name ~= nil then
                    --name:removeSelf()
                    --name = nil
                  end
               elseif ("ended" == event.phase) then 
                  composer.search = teksfield.text


               elseif ("submitted" == event.phase) then  
                  composer.search = teksfield.text
                  native.setKeyboardFocus(nil) 
                elseif ( event.phase == "editing" ) then
                  
                  composer.search = teksfield.text

                end  
         end 
        teksfield:addEventListener( "userInput", fieldHandler_t ) 

        local myRectangle = display.newRect( 0 + display.contentWidth/20 + teksfield.width, composer.tinggi_teksfield, 0.1 * display.contentWidth, 40 )
		myRectangle.strokeWidth = 0
		myRectangle.anchorX = 0
		myRectangle:setFillColor( 244/255,209/255,66/255 )
		myRectangle:setStrokeColor( 1, 0, 0 )
		sceneGroup:insert(myRectangle)

		local search = display.newImageRect( composer.imgDir.. "search.png", 1260, 916 ); 
		search.x = myRectangle.x + myRectangle.width / 2;
		search.y = myRectangle.y
		search.anchorY = 0.5
		--search:scale(0.5,0.5)
		search.xScale = (0.9 * myRectangle.height) / search.width 
		search.yScale = (0.9 * myRectangle.height) / search.width 
		sceneGroup:insert(search)

		search:addEventListener("tap", onLoginView )
end

function scene:show( event )
	composer.removeHidden()
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then

	
	
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then


       


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
                    local url = data.url
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
						system.openURL(url)
					end

					myImage:addEventListener("tap", onBanner)

                    local function networkListener( event )
					    if ( event.isError ) then
		                      print( "Network error - download failed" )
		              elseif ( event.phase == "began" ) then
		                      cancelall[began] = event.requestId
		                      --print( "Progress Phase: began onyon" )
		                      began = began + 1
		                      
		              elseif ( event.phase == "ended" ) then
		                   
		              		print(loadall)
		              		if(loadall == 70)then
		              			print("masuk fungsi")
		                      	hideover()
		                    end
		                    loadall = loadall + 1
		               
		               
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


        dl_id7 = network.request( "http://api.bursasajadah.com/api/bursasajadah/slider", "GET", dataResponseSlider )
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