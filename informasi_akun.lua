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

local user_id = ""
cur_page = "menu3"

status_back = 0


local teks_search
local grup_menu = display.newGroup()

require "sqlite3"

local datab = "data.db"
local path = system.pathForFile(datab, system.DocumentsDirectory)
db = sqlite3.open( path )
 
for row in db:nrows("SELECT * FROM is_login") do
  user_id = row.id_user
end

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

		if(teksfield~=nil)then
		teksfield:removeSelf()
		teksfield = nil
		end

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
 	if(composer.is_login == '1')then
 			teks_log = "Profile"
 	else
 			teks_log = "Login"
 	end
	local login = display.newText( teks_log, display.contentWidth - 20 , 0 + display.contentHeight / 20, "Raleway-Regular.ttf", 15  * (display.contentWidth / 320)  )
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

    --composer.hideOverlay("fade", 100)
    

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


		teks_search = display.newText( "Search", 20, myRectangle1.y , "Raleway-Regular.ttf", 10  * (display.contentWidth / 320))
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
		

		search:addEventListener("tap", onLoginView )

	    


	--end



	local menu1 = display.newText( "Sajadah & Karpet", 10 , scrollView2.height /2, "Raleway-Regular.ttf", 12  * (display.contentWidth / 320))
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



	local menu2 = display.newText( "Makanan", menu1.x + menu1.width + display.contentWidth/10 , scrollView2.height /2, "Raleway-Regular.ttf", 12  * (display.contentWidth / 320))
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

	local menu3 = display.newText( "Oleh - Oleh Haji", menu2.x + menu2.width + display.contentWidth/10, scrollView2.height /2, "Raleway-Regular.ttf", 12  * (display.contentWidth / 320))
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


	local menu4 = display.newText( "Perlengkapan Haji", menu3.x + menu3.width + display.contentWidth/10 , scrollView2.height /2, "Raleway-Regular.ttf", 12  * (display.contentWidth / 320))
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

	local menu5 = display.newText( "Perlengkapan Muslim", menu4.x + menu4.width + display.contentWidth/10, scrollView2.height /2, "Raleway-Regular.ttf", 12  * (display.contentWidth / 320))
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


	local menu6 = display.newText( "Busana Muslim", menu5.x + menu5.width + display.contentWidth/10, scrollView2.height /2, "Raleway-Regular.ttf", 12  * (display.contentWidth / 320))
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



	local menu7 = display.newText( "Produk Diskon", menu6.x + menu6.width + display.contentWidth/10 , scrollView2.height /2, "Raleway-Regular.ttf", 12  * (display.contentWidth / 320))
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


	local spasi1 = display.newText( " ", menu7.x + menu7.width + 20 , 10, "Raleway-Regular.ttf", 12  * (display.contentWidth / 320))
	spasi1.anchorY = 0
	spasi1.anchorX = 0
	spasi1:setFillColor( 1 )
	scrollView2:insert(spasi1)

	
	local teks_diskon = display.newText( "Detail Akun", display.contentCenterX, display.contentHeight/20 , "Raleway-Bold.ttf", 15  * (display.contentWidth / 320))
	teks_diskon.anchorX = 0.5
	teks_diskon:setFillColor(0)
	scrollView:insert(teks_diskon)
	composer.tinggi_line2 = teks_diskon.y

	local line2 = display.newLine( 0 + 0.05 * display.contentWidth, teks_diskon.y + display.contentHeight/40, display.contentWidth - display.contentWidth*0.05, teks_diskon.y + display.contentHeight/40 )
	line2:setStrokeColor( 133/255,190/255,72/255)
	line2.strokeWidth = 1
	scrollView:insert(line2)
	composer.tinggi_line2 = line2.y


	


	local options = {
						 text = "",
	                     x = 0 + 0.05 * display.contentWidth,
	                     y = line2.y + display.contentHeight/15,
	                     font = "Raleway-Regular.ttf",
	                     fontSize = 15  * (display.contentWidth / 320),
	                     align = "left",
	                     width = (0.9 * display.contentWidth)
                 	 }


 	 label_nama = display.newText(options)
     label_nama.anchorX = 0
     label_nama.anchorY = 0
     label_nama:setFillColor(0);
     scrollView:insert(label_nama);

	local garis1 = display.newLine( 0 + 0.05 * display.contentWidth, label_nama.y + label_nama.height + 3, display.contentWidth - display.contentWidth*0.05,label_nama.y + label_nama.height + 3)
	garis1:setStrokeColor( 133/255,190/255,72/255)
	garis1.strokeWidth = 1
	scrollView:insert(garis1)

	local options = {
						 text = "Nama",
	                     x = 0 + 0.05 * display.contentWidth,
	                     y = label_nama.y - 5,
	                     font = "Raleway-Regular.ttf",
	                     fontSize = 9  * (display.contentWidth / 320),
	                     align = "left",
	                     width = (0.9 * display.contentWidth)
                 	 }


 	 label_nama_up = display.newText(options)
     label_nama_up.anchorX = 0
     label_nama_up.anchorY = 1
     label_nama_up:setFillColor(0.4);
     scrollView:insert(label_nama_up);


	local options = {
						 text = "",
	                     x = 0 + 0.05 * display.contentWidth,
	                     y = garis1.y + display.contentHeight/15,
	                     font = "Raleway-Regular.ttf",
	                     fontSize = 13  * (display.contentWidth / 320),
	                     align = "left",
	                     width = (0.9 * display.contentWidth)
                 	 }


 	 label_email = display.newText(options)
     label_email.anchorX = 0
     label_email.anchorY = 0
     label_email:setFillColor(0);
     scrollView:insert(label_email);


     local options = {
						 text = "Email",
	                     x = 0 + 0.05 * display.contentWidth,
	                     y = label_email.y - 5,
	                     font = "Raleway-Regular.ttf",
	                     fontSize = 9  * (display.contentWidth / 320),
	                     align = "left",
	                     width = (0.9 * display.contentWidth)
                 	 }


 	 label_email_up = display.newText(options)
     label_email_up.anchorX = 0
     label_email_up.anchorY = 1
     label_email_up:setFillColor(0.4);
     scrollView:insert(label_email_up);

	local garis2 = display.newLine( 0 + 0.05 * display.contentWidth, label_email.y + label_email.height + 3, display.contentWidth - display.contentWidth*0.05, label_email.y + label_email.height + 3)
	garis2:setStrokeColor( 133/255,190/255,72/255)
	garis2.strokeWidth = 1
	scrollView:insert(garis2)


	local options = {
						 text = "",
	                     x = 0 + 0.05 * display.contentWidth,
	                     y = garis2.y + display.contentHeight/15,
	                     font = "Raleway-Regular.ttf",
	                     fontSize = 13  * (display.contentWidth / 320),
	                     align = "left",
	                     width = (0.9 * display.contentWidth)
                 	 }


 	 label_telepon = display.newText(options)
     label_telepon.anchorX = 0
     label_telepon.anchorY = 0
     label_telepon:setFillColor(0);
     scrollView:insert(label_telepon);


     local options = {
						 text = "Nomor Ponsel",
	                     x = 0 + 0.05 * display.contentWidth,
	                     y = label_telepon.y - 5,
	                     font = "Raleway-Regular.ttf",
	                     fontSize = 9  * (display.contentWidth / 320),
	                     align = "left",
	                     width = (0.9 * display.contentWidth)
                 	 }


 	 label_telepon_up = display.newText(options)
     label_telepon_up.anchorX = 0
     label_telepon_up.anchorY = 1
     label_telepon_up:setFillColor(0.4);
     scrollView:insert(label_telepon_up);


    local garis3 = display.newLine( 0 + 0.05 * display.contentWidth, label_telepon.y + label_telepon.height + 3, display.contentWidth - display.contentWidth*0.05, label_telepon.y + label_telepon.height + 3)
	garis3:setStrokeColor( 133/255,190/255,72/255)
	garis3.strokeWidth = 1
	scrollView:insert(garis3)

	local teksfield_telepon

	local function on_label_telepon()	

		--hide_all()

		teksfield_telepon = native.newTextField(display.contentCenterX, garis3.y -2, display.contentWidth*0.9, display.contentHeight/20)
		teksfield_telepon.anchorX = 0.5
		teksfield_telepon.anchorY = 1
		--teksfield_telepon.inputType = "number"
		teksfield_telepon.hasBackground = true
		--teksfield_telepon.placeholder = "telepon"
		scrollView:insert( teksfield_telepon )


		local function fieldHandler_t(event) 

				label_telepon.text = teksfield_telepon.text

               if ("began" == event.phase) then 
                  if name ~= nil then
                    --name:removeSelf()
                    --name = nil
                  end
               elseif ("ended" == event.phase) then 
                  label_telepon.text = teksfield_telepon.text
                  teksfield_telepon:removeSelf()
                  teksfield_telepon = nil

               elseif ("submitted" == event.phase) then  
               	  label_telepon.text = teksfield_telepon.text
                  composer.search = teksfield.text
                  native.setKeyboardFocus(nil) 
                elseif ( event.phase == "editing" ) then
                  	
                  label_telepon.text = teksfield_telepon.text


                end  
         end 
        
		
        teksfield_telepon:addEventListener( "userInput", fieldHandler_t ) 

	end
	label_telepon:addEventListener("tap", on_label_telepon)






	local teks_diskon2 = display.newText( "Detail Alamat Pengiriman", display.contentCenterX, display.contentHeight/10 + label_telepon.y, "Raleway-Bold.ttf", 15  * (display.contentWidth / 320))
	teks_diskon2.anchorX = 0.5
	teks_diskon2:setFillColor(0)
	scrollView:insert(teks_diskon2)
	composer.tinggi_line2 = teks_diskon2.y

	local line2x = display.newLine( 0 + 0.05 * display.contentWidth, teks_diskon2.y + display.contentHeight/40, display.contentWidth - display.contentWidth*0.05, teks_diskon2.y + display.contentHeight/40 )
	line2x:setStrokeColor( 133/255,190/255,72/255)
	line2x.strokeWidth = 1
	scrollView:insert(line2x)
	composer.tinggi_line2x = line2x.y





	local options = {
						 text = "",
	                     x = 0 + 0.05 * display.contentWidth,
	                     y = line2x.y + display.contentHeight/15,
	                     font = "Raleway-Regular.ttf",
	                     fontSize = 15  * (display.contentWidth / 320),
	                     align = "left",
	                     width = (0.9 * display.contentWidth)
                 	 }


 	 label_namax = display.newText(options)
     label_namax.anchorX = 0
     label_namax.anchorY = 0
     label_namax:setFillColor(0);
     scrollView:insert(label_namax);

	local garis1x = display.newLine( 0 + 0.05 * display.contentWidth, label_namax.y + label_namax.height + 3, display.contentWidth - display.contentWidth*0.05,label_namax.y + label_namax.height + 3)
	garis1x:setStrokeColor( 133/255,190/255,72/255)
	garis1x.strokeWidth = 1
	scrollView:insert(garis1x)

	local options = {
						 text = "Nama Lengkap",
	                     x = 0 + 0.05 * display.contentWidth,
	                     y = label_namax.y - 5,
	                     font = "Raleway-Regular.ttf",
	                     fontSize = 9  * (display.contentWidth / 320),
	                     align = "left",
	                     width = (0.9 * display.contentWidth)
                 	 }


 	 label_namax_up = display.newText(options)
     label_namax_up.anchorX = 0
     label_namax_up.anchorY = 1
     label_namax_up:setFillColor(0.4);
     scrollView:insert(label_namax_up);




     local options = {
						 text = "",
	                     x = 0 + 0.05 * display.contentWidth,
	                     y = garis1x.y + display.contentHeight/15,
	                     font = "Raleway-Regular.ttf",
	                     fontSize = 15  * (display.contentWidth / 320),
	                     align = "left",
	                     width = (0.9 * display.contentWidth)
                 	 }


 	 label_teleponx = display.newText(options)
     label_teleponx.anchorX = 0
     label_teleponx.anchorY = 0
     label_teleponx:setFillColor(0);
     scrollView:insert(label_teleponx);

	local garis1 = display.newLine( 0 + 0.05 * display.contentWidth, label_teleponx.y + label_teleponx.height + 3, display.contentWidth - display.contentWidth*0.05,label_teleponx.y + label_teleponx.height + 3)
	garis1:setStrokeColor( 133/255,190/255,72/255)
	garis1.strokeWidth = 1
	scrollView:insert(garis1)

	local options = {
						 text = "Nomor Ponsel",
	                     x = 0 + 0.05 * display.contentWidth,
	                     y = label_teleponx.y - 5,
	                     font = "Raleway-Regular.ttf",
	                     fontSize = 9  * (display.contentWidth / 320),
	                     align = "left",
	                     width = (0.9 * display.contentWidth)
                 	 }


 	 label_teleponx_up = display.newText(options)
     label_teleponx_up.anchorX = 0
     label_teleponx_up.anchorY = 1
     label_teleponx_up:setFillColor(0.4);
     scrollView:insert(label_teleponx_up);




     local options = {
						 text = "",
	                     x = 0 + 0.05 * display.contentWidth,
	                     y = garis1.y + display.contentHeight/15,
	                     font = "Raleway-Regular.ttf",
	                     fontSize = 15  * (display.contentWidth / 320),
	                     align = "left",
	                     width = (0.9 * display.contentWidth)
                 	 }


 	 label_alamatx = display.newText(options)
     label_alamatx.anchorX = 0
     label_alamatx.anchorY = 0
     label_alamatx:setFillColor(0);
     scrollView:insert(label_alamatx);

	local garis2x = display.newLine( 0 + 0.05 * display.contentWidth, label_alamatx.y + label_alamatx.height + 3, display.contentWidth - display.contentWidth*0.05,label_alamatx.y + label_alamatx.height + 3)
	garis2x:setStrokeColor( 133/255,190/255,72/255)
	garis2x.strokeWidth = 1
	scrollView:insert(garis2x)

	local options = {
						 text = "Alamat",
	                     x = 0 + 0.05 * display.contentWidth,
	                     y = label_alamatx.y - 5,
	                     font = "Raleway-Regular.ttf",
	                     fontSize = 9  * (display.contentWidth / 320),
	                     align = "left",
	                     width = (0.9 * display.contentWidth)
                 	 }


 	 label_alamatx_up = display.newText(options)
     label_alamatx_up.anchorX = 0
     label_alamatx_up.anchorY = 1
     label_alamatx_up:setFillColor(0.4);
     scrollView:insert(label_alamatx_up);



     local options = {
						 text = "",
	                     x = 0 + 0.05 * display.contentWidth,
	                     y = garis2x.y + display.contentHeight/15,
	                     font = "Raleway-Regular.ttf",
	                     fontSize = 15  * (display.contentWidth / 320),
	                     align = "left",
	                     width = (0.9 * display.contentWidth)
                 	 }


 	 label_kecamatanx = display.newText(options)
     label_kecamatanx.anchorX = 0
     label_kecamatanx.anchorY = 0
     label_kecamatanx:setFillColor(0);
     scrollView:insert(label_kecamatanx);

	local garis3x = display.newLine( 0 + 0.05 * display.contentWidth, label_kecamatanx.y + label_kecamatanx.height + 3, display.contentWidth - display.contentWidth*0.05,label_kecamatanx.y + label_kecamatanx.height + 3)
	garis3x:setStrokeColor( 133/255,190/255,72/255)
	garis3x.strokeWidth = 1
	scrollView:insert(garis3x)

	local options = {
						 text = "Kecamatan",
	                     x = 0 + 0.05 * display.contentWidth,
	                     y = label_kecamatanx.y - 5,
	                     font = "Raleway-Regular.ttf",
	                     fontSize = 9  * (display.contentWidth / 320),
	                     align = "left",
	                     width = (0.9 * display.contentWidth)
                 	 }


 	 label_kecamatanx_up = display.newText(options)
     label_kecamatanx_up.anchorX = 0
     label_kecamatanx_up.anchorY = 1
     label_kecamatanx_up:setFillColor(0.4);
     scrollView:insert(label_kecamatanx_up);





      local options = {
						 text = "",
	                     x = 0 + 0.05 * display.contentWidth,
	                     y = garis3x.y + display.contentHeight/15,
	                     font = "Raleway-Regular.ttf",
	                     fontSize = 15  * (display.contentWidth / 320),
	                     align = "left",
	                     width = (0.9 * display.contentWidth)
                 	 }


 	 label_kotax = display.newText(options)
     label_kotax.anchorX = 0
     label_kotax.anchorY = 0
     label_kotax:setFillColor(0);
     scrollView:insert(label_kotax);

	local garis4x = display.newLine( 0 + 0.05 * display.contentWidth, label_kotax.y + label_kotax.height + 3, display.contentWidth - display.contentWidth*0.05,label_kotax.y + label_kotax.height + 3)
	garis4x:setStrokeColor( 133/255,190/255,72/255)
	garis4x.strokeWidth = 1
	scrollView:insert(garis4x)

	local options = {
						 text = "Kota",
	                     x = 0 + 0.05 * display.contentWidth,
	                     y = label_kotax.y - 5,
	                     font = "Raleway-Regular.ttf",
	                     fontSize = 9  * (display.contentWidth / 320),
	                     align = "left",
	                     width = (0.9 * display.contentWidth)
                 	 }


 	 label_kotax_up = display.newText(options)
     label_kotax_up.anchorX = 0
     label_kotax_up.anchorY = 1
     label_kotax_up:setFillColor(0.4);
     scrollView:insert(label_kotax_up);



     local options = {
						 text = "",
	                     x = 0 + 0.05 * display.contentWidth,
	                     y = garis4x.y + display.contentHeight/15,
	                     font = "Raleway-Regular.ttf",
	                     fontSize = 15  * (display.contentWidth / 320),
	                     align = "left",
	                     width = (0.9 * display.contentWidth)
                 	 }


 	 label_provinsix = display.newText(options)
     label_provinsix.anchorX = 0
     label_provinsix.anchorY = 0
     label_provinsix:setFillColor(0);
     scrollView:insert(label_provinsix);

	local garis5x = display.newLine( 0 + 0.05 * display.contentWidth, label_provinsix.y + label_provinsix.height + 3, display.contentWidth - display.contentWidth*0.05,label_provinsix.y + label_provinsix.height + 3)
	garis5x:setStrokeColor( 133/255,190/255,72/255)
	garis5x.strokeWidth = 1
	scrollView:insert(garis5x)

	local options = {
						 text = "Provinsi",
	                     x = 0 + 0.05 * display.contentWidth,
	                     y = label_provinsix.y - 5,
	                     font = "Raleway-Regular.ttf",
	                     fontSize = 9  * (display.contentWidth / 320),
	                     align = "left",
	                     width = (0.9 * display.contentWidth)
                 	 }


 	 label_provinsix_up = display.newText(options)
     label_provinsix_up.anchorX = 0
     label_provinsix_up.anchorY = 1
     label_provinsix_up:setFillColor(0.4);
     scrollView:insert(label_provinsix_up);



     local options = {
						 text = "",
	                     x = 0 + 0.05 * display.contentWidth,
	                     y = garis5x.y + display.contentHeight/15,
	                     font = "Raleway-Regular.ttf",
	                     fontSize = 15  * (display.contentWidth / 320),
	                     align = "left",
	                     width = (0.9 * display.contentWidth)
                 	 }


 	 label_kode_posx = display.newText(options)
     label_kode_posx.anchorX = 0
     label_kode_posx.anchorY = 0
     label_kode_posx:setFillColor(0);
     scrollView:insert(label_kode_posx);

	local garis6x = display.newLine( 0 + 0.05 * display.contentWidth, label_kode_posx.y + label_kode_posx.height + 3, display.contentWidth - display.contentWidth*0.05,label_kode_posx.y + label_kode_posx.height + 3)
	garis6x:setStrokeColor( 133/255,190/255,72/255)
	garis6x.strokeWidth = 1
	scrollView:insert(garis6x)

	local options = {
						 text = "Kode Pos",
	                     x = 0 + 0.05 * display.contentWidth,
	                     y = label_kode_posx.y - 5,
	                     font = "Raleway-Regular.ttf",
	                     fontSize = 9  * (display.contentWidth / 320),
	                     align = "left",
	                     width = (0.9 * display.contentWidth)
                 	 }


 	 label_kode_posx_up = display.newText(options)
     label_kode_posx_up.anchorX = 0
     label_kode_posx_up.anchorY = 1
     label_kode_posx_up:setFillColor(0.4);
     scrollView:insert(label_kode_posx_up);

	local function updatedata()
		system.openURL("http://bursasajadah.com/profile")
	end

	local background_checkout = display.newRect( display.contentCenterX, garis6x.y + display.contentHeight/10, display.contentWidth * 0.9, 50)
	background_checkout.anchorY = 0.5
	background_checkout.anchorX = 0.5
	background_checkout:setFillColor( 133/255,190/255,72/255)
	scrollView:insert(background_checkout)

	local teks_email = display.newText( "UPDATE DATA", background_checkout.x, background_checkout.y , "Raleway-Regular.ttf", 12  * (display.contentWidth / 320))
	teks_email.anchorX = 0.5
	teks_email:setFillColor(1)
	scrollView:insert(teks_email)

	background_checkout:addEventListener("tap", updatedata)


	--======================================================FOOTER======================================================--




	local footer_background = display.newRect( display.contentCenterX, garis6x.y + display.contentHeight/4, display.contentWidth, display.contentHeight/7)
	footer_background.anchorY = 0
	footer_background:setFillColor( 133/255,190/255,72/255)
	scrollView:insert(footer_background)

	local teks_footer = display.newText( "TEMUKAN JUGA KAMI DI", display.contentCenterX, footer_background.y + display.contentHeight/80, "Raleway-Regular.ttf", 15  * (display.contentWidth / 320))
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




	function getData()

		local data = listData[1]

       	label_nama.text = data.first_name	
       	label_email.text = data.email
       	label_telepon.text = data.phone	
       	label_namax.text = tostring(data.first_name.." "..data.last_name)	
       	label_teleponx.text = data.phone
       	label_alamatx.text = data.alamat
       	label_kecamatanx.text = data.kecamatan
       	label_provinsix.text = data.provinsi
       	label_kotax.text = data.kota
       	label_kode_posx.text = data.kode_pos

    end








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

	
	
end

function scene:show( event )
	
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then

	
	
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then

		composer.removeHidden()



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

        local function dataResponse(event)
        	if ( event.isError ) then
            -- TODO Show error here
              print( "Network error!" )
              --loadIconListener()

	          else
	          		listData = json.decode(event.response)

	          		data_max = table.getn(listData);

	          		--print(event.response)

	          		getData()
	          end
        end



        dl_iddata = network.request("http://api.bursasajadah.com/api/bursasajadah/PQp8xrFkrBz3byU/"..user_id , get , dataResponse)
       -- dl_id7 = network.request( "http://api.bursasajadah.com/api/bursasajadah/slider", "GET", dataResponseSlider )
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