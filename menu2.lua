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
local data_loading = 0
local cancelall = {}
local began = 1
local teksfield
cur_page = "menu2"
local status_back = 0

local function toview1 ()
if nil~= composer.getScene("view1") then composer.removeScene("view1", true) end  

composer.gotoScene( "view1" ) 
end



local lfs = require( "lfs" )
 
	local doc_path = system.pathForFile( "", system.TemporaryDirectory )
	 
	for file in lfs.dir( doc_path ) do
	    local destDir = system.TemporaryDirectory  -- Location where the file is stored
        os.remove( system.pathForFile( file , destDir ) )
	end

function scene:create( event )
	--local sceneGroup = nil

	local teks_search
	local grup_menu = display.newGroup()

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
	composer.tinggi_scrollview = 0
	
	composer.posisi_x1 = display.contentCenterX - display.contentWidth/10
	composer.posisi_x2 = display.contentCenterX + display.contentWidth/10
	composer.posisi_y = 0
	
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
		--teksfield.alpha = 0
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
	local menu = display.newImageRect( composer.imgDir.. "menu.png", 110, 88 ); 
	menu.x = 0 + 20 ;
	menu.y =  0 + display.contentCenterY / 11
	menu.anchorY = 0.5
	menu.anchorX = 0
	--menu:scale(0.5,0.5)
	menu.xScale = (background2.height/6) / menu.height
	menu.yScale = (background2.height/6) / menu.height


	menu:addEventListener("tap", onMenu)


	composer.tinggi_teksfield = logo.y + logo.height + display.contentHeight / 100 

	function onLogoView( event )
		composer.gotoScene( "view1" )
	end
	logo:addEventListener("tap", onLogoView )
	
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

		if nil~= composer.getScene("login_fix") then composer.removeScene("login_fix", true) end  

        composer.gotoScene( "login_fix" )
    	
   
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


	local back = display.newText( "Back", 20 , 0 + display.contentHeight / 20, used_font_bold, 15  * (display.contentWidth / 320)  )
	back.anchorX = 0
	back.anchorY = 0.5
	back.alpha = 0
	--title:setFillColor( 1 )	-- black

	function onbackView( event )
		if nil~= composer.getScene("view1") then composer.removeScene("view1", true) end  
        if  self.type == "press" then 
            self:setEnabled(false) 
        else 
            --self:removeEventListener( "tap", onMenu1 ) 
        end 
        local function goon()
        composer.gotoScene( "view1" ) 
    	end
    	timer.performWithDelay(1000, goon)
	end
	back:addEventListener("tap", onbackView )

	
	

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
	        isBounceEnabled = false,
	        --scrollWidth = 600,
	        --scrollHeight = 2000,
	        --listener = scrollListener

	    }
	)

	

	composer.tinggi_teksfield = scrollView2.y - scrollView2.height



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
		

		search:addEventListener("tap", onLoginView )



	local menu1 = display.newText( "Sajadah & Karpet", 10 , scrollView2.height /2, used_font, 12  * (display.contentWidth / 320))
	menu1.anchorY = 0.5
	menu1.anchorX = 0
	menu1:setFillColor( 1 )
	scrollView2:insert(menu1)



	local function onMenu1(event) 

				self:removeEventListener( "tap", onMenu1 ) 
				composer.halaman_page = 0
	            composer.status_kategori = 1

	           
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

	

	local terbaru_box = display.newRect( display.contentCenterX, display.contentHeight/20, display.contentWidth * 0.8, 50 )
	if(composer.status_kategori == 1)then
		terbaru_box:setFillColor( 133/255,190/255,72/255)
	else
		terbaru_box:setFillColor( 0.5)
	end
	scrollView:insert(terbaru_box)

	local teks_terbaru = display.newText( "Terbaru", terbaru_box.x, terbaru_box.y, used_font_bold, 10  * (display.contentWidth / 320))
	teks_terbaru.anchorX = 0.5
	teks_terbaru:setFillColor(1)
	scrollView:insert(teks_terbaru)



	local termurah_box = display.newRect( display.contentCenterX, terbaru_box.y + terbaru_box.height, display.contentWidth * 0.8, 50 )
	if(composer.status_kategori == 2)then
		termurah_box:setFillColor( 133/255,190/255,72/255)
	else
		termurah_box:setFillColor( 0.5)
	end
	scrollView:insert(termurah_box)

	local teks_termurah = display.newText( "Termurah", termurah_box.x, termurah_box.y, used_font_bold, 10  * (display.contentWidth / 320))
	teks_termurah.anchorX = 0.5
	teks_termurah:setFillColor(1)
	scrollView:insert(teks_termurah)


	local terlaris_box = display.newRect( display.contentCenterX, termurah_box.y + termurah_box.height, display.contentWidth * 0.8, 50 )
	if(composer.status_kategori == 3)then
		terlaris_box:setFillColor( 133/255,190/255,72/255)
	else
		terlaris_box:setFillColor( 0.5)
	end
	scrollView:insert(terlaris_box)


	local teks_terlaris = display.newText( "Terlaris", terlaris_box.x, terlaris_box.y, used_font_bold, 10  * (display.contentWidth / 320))
	teks_terlaris.anchorX = 0.5
	teks_terlaris:setFillColor(1)
	scrollView:insert(teks_terlaris)

	composer.posisi_y = terlaris_box.y + terlaris_box.height + display.contentHeight/20


	local function onTerbaru(event) 
	            composer.status_kategori = 1
	            but_terbaru(terbaru_box)
	          return true 
	       end 
	       terbaru_box:addEventListener("tap", onTerbaru ) 

   function but_terbaru(self) 
      
            if nil~= composer.getScene("menu2") then composer.removeScene("menu2", true) end  
            if  self.type == "press" then 
                self:setEnabled(false) 
            else 
                self:removeEventListener( "tap", onTerbaru ) 
            end 
            composer.gotoScene( "menu2" ) 
        
   end 


   local function onTermurah(event) 
	            composer.status_kategori = 2
	            but_termurah(termurah_box)
	          return true 
	       end 
	       termurah_box:addEventListener("tap", onTermurah ) 

   function but_termurah(self) 
      
            if nil~= composer.getScene("menu2") then composer.removeScene("menu2", true) end  
            if  self.type == "press" then 
                self:setEnabled(false) 
            else 
                self:removeEventListener( "tap", onTermurah ) 
            end 
            composer.gotoScene( "menu2" ) 
        
   end 


   local function onTerlaris(event) 
	            composer.status_kategori = 3
	            but_terlaris(terlaris_box)
	          return true 
	       end 
	       terlaris_box:addEventListener("tap", onTerlaris ) 

   function but_terlaris(self) 
      
            if nil~= composer.getScene("menu2") then composer.removeScene("menu2", true) end  
            if  self.type == "press" then 
                self:setEnabled(false) 
            else 
                self:removeEventListener( "tap", onTerlaris ) 
            end 
            composer.gotoScene( "menu2" ) 
        
   end 


	-- all objects must be added to group (e.g. self.view)
	sceneGroup:insert( background )
	sceneGroup:insert( background2 )
	sceneGroup:insert(logo)
	sceneGroup:insert( back )
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
end

function scene:show( event )
	
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then


	-- local function loading()
	-- 	-- body
	-- local options_overlay =
	-- 	{
	-- 	    isModal = true,
	-- 	    effect = "fromLeft",
	-- 	    time = 100,
	-- 	    params = {
	-- 	        sampleVar1 = "my sample variable",
	-- 	        sampleVar2 = "another sample variable"
	-- 	    }
	-- 	}

	-- composer.showOverlay("overlay_loading", options_overlay)

	-- end
	-- timer.performWithDelay(10, loading)


		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		composer.removeHidden()
     


    
   
     function tampilMakanan()
          local index

     
             for index = 1, data_max do
      
                  local data = listData[index]

                    composer.url_link = data.url_link
                    local image = data.image
                   

                    
                    --print("Nama link : "..composer.url_link)
                    --print("Nama Gambar : "..composer.image)


                    local count = composer.gambar_iklan_makanan
                    local y = composer.posisi_y
                    local x1 = composer.posisi_x1
                    local x2 = composer.posisi_x2


                    local myImage = display.newImage(  composer.imgDir.. "logo.png", 125, 39 )
                      
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
                      myImage.xScale = (0.3 * display.contentWidth) / 700
                      myImage.yScale = (0.3 * display.contentWidth) / 700
                      myImage.alpha = 1
                      --transition.to( layer.myImage, { alpha = 1.0 , delay = 0} )
                      scrollView:insert(myImage)



                      local posisi_teks_x = myImage.x + (myImage.width * myImage.xScale /2)

                       if(composer.gambar_iklan_makanan%2 == 1)then
                       		posisi_teks_x = myImage.x - (myImage.width * myImage.xScale /2)
                       else
                       		posisi_teks_x = myImage.x + (myImage.width * myImage.xScale /2)
                       end

                      local posisi_teks_y = myImage.y + myImage.height * myImage.yScale + 10
                      local posisi_teks_y2 = posisi_teks_y


                      local teks  = table.concat(composer.data_makanan, ", ", composer.gambar_iklan_makanan,composer.gambar_iklan_makanan)
                      local teks2 = table.concat(composer.data_makanan_harga, ", ", composer.gambar_iklan_makanan,composer.gambar_iklan_makanan)


                    local ucing = composer.gambar_iklan_makanan

                    function onProduk( event )
                    	myImage:removeEventListener("tap", onProduk)
                    	--local function listener( event )
                    	composer.id_lempar = data.product_id --table.concat(composer.data_sajadah_id, ", ", ucing,ucing)
                    	if nil~= composer.getScene("view2") then composer.removeScene("view2", true) end
						composer.gotoScene( "view2" )
						-- end
						  
						-- timer.performWithDelay( 500, listener) 
					end
					myImage:addEventListener("tap", onProduk )




                     local options = {

                     text = teks,
                     x = posisi_teks_x,
                     y = posisi_teks_y,
                     font = used_font,
                     fontSize = 10  * (display.contentWidth / 320),
                     align = "center",
                     width = myImage.width * myImage.xScale + display.contentWidth/10
                 	 }


                 	 local teks_produk_diskon = display.newText(options)
			         teks_produk_diskon.anchorX = 0.5
			         teks_produk_diskon.anchorY = 0
			         teks_produk_diskon:setFillColor(0);
			         scrollView:insert(teks_produk_diskon);


                 	 local options2 = {

                     text = tostring("Rp. "..teks2..",-"),
                     x = posisi_teks_x,
                     y = teks_produk_diskon.y + teks_produk_diskon.height + display.contentHeight/40,
                     font = used_font_bold,
                     fontSize = 13  * (display.contentWidth / 320),
                     align = "center",
                     width = myImage.width * myImage.xScale + display.contentWidth/30
                 	 }

                 	 

			         local teks_produk_diskon_harga = display.newText(options2)
			         teks_produk_diskon_harga.anchorX = 0.5
			         teks_produk_diskon_harga.anchorY = 0
			         teks_produk_diskon_harga:setFillColor(0);
			         scrollView:insert(teks_produk_diskon_harga);

                      composer.temp_x1 = myImage.x + myImage.width*myImage.xScale + display.contentWidth/7
                      composer.gambar_iklan_makanan = composer.gambar_iklan_makanan + 1

                      if(composer.gambar_iklan_makanan%2 == 1)then
                      composer.posisi_y = teks_produk_diskon_harga.y + teks_produk_diskon_harga.height + display.contentHeight/50
                      end
                      --print(composer.gambar_iklan)
                      --print("pic saved")

                      composer.tinggi_scrollview = teks_produk_diskon_harga.y
    				
                      if(composer.gambar_iklan_makanan == data_max) then
                      local tampil_next = display.newText( "Next", 0 + display.contentWidth * 0.8, composer.tinggi_scrollview + 150 , used_font_bold, 12  * (display.contentWidth / 320))
					tampil_next.anchorX = 0
					tampil_next:setFillColor(1)
					

					local myRoundedRect = display.newRect( tampil_next.x + tampil_next.width/2, tampil_next.y, tampil_next.width + tampil_next.width/2 + display.contentWidth/40, tampil_next.height + tampil_next.height/2 + 5)
					myRoundedRect.strokeWidth = 0
					myRoundedRect:setFillColor(  133/255,190/255,72/255 )
					--myRoundedRect:setStrokeColor( 1, 0, 0 )

					scrollView:insert(myRoundedRect)
					

					local tampil_prev = display.newText( "Prev", 0 + display.contentWidth * 0.8 - tampil_next.width, composer.tinggi_scrollview + 150 , used_font_bold, 12  * (display.contentWidth / 320))
					tampil_prev.anchorX = 1
					tampil_prev:setFillColor(1)

					


					local myRoundedRect2 = display.newRect( tampil_prev.x - tampil_prev.width/2, tampil_prev.y, tampil_prev.width + tampil_prev.width/2 + display.contentWidth/40, tampil_prev.height + tampil_prev.height/2 + 5 )
					myRoundedRect2.strokeWidth = 0
					myRoundedRect2:setFillColor(  133/255,190/255,72/255 )

	scrollView:insert(myRoundedRect2)
	scrollView:insert(tampil_prev)
	scrollView:insert(tampil_next)


	if(composer.halaman_page == 0)then
		tampil_prev.alpha = 0
		myRoundedRect2.alpha = 0
	end
	--composer.tinggi_tampil_next = tampil_next.y

	local line2 = display.newLine( 0, tampil_prev.y + display.contentHeight/10, display.contentWidth, tampil_prev.y + display.contentHeight/10 )
	line2:setStrokeColor(1)
	line2.strokeWidth = 2
	scrollView:insert(line2)
	--composer.tinggi_line2 = line2.y


	--======================================================FOOTER======================================================--




	local footer_background = display.newRect( display.contentCenterX, tampil_next.y + display.contentHeight/8, display.contentWidth, display.contentHeight/7)
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

	local function ontampil_next(event) 
	            but_tampil_next(tampil_next)
	            --composer.id_kategori = 71
	          return true 
	       end 
	       tampil_next:addEventListener("tap", ontampil_next ) 

	   function but_tampil_next(self) 
	      
	            if nil~= composer.getScene("menu2") then composer.removeScene("menu2", true) end  
	            if  self.type == "press" then 
	                self:setEnabled(false) 
	            else 
	                self:removeEventListener( "tap", ontampil_next ) 
	            end 
	            composer.gotoScene( "menu2" ) 
	            composer.halaman_page = composer.halaman_page + 10
	        
	   end 


	   local function ontampil_prev(event) 
	            but_tampil_prev(tampil_prev)
	            --composer.id_kategori = 71
	          return true 
	       end 
	       tampil_prev:addEventListener("tap", ontampil_prev ) 

	   function but_tampil_prev(self) 
	      
	            if nil~= composer.getScene("menu2") then composer.removeScene("menu2", true) end  
	            if  self.type == "press" then 
	                self:setEnabled(false) 
	            else 
	                self:removeEventListener( "tap", ontampil_prev ) 
	            end 
	            composer.gotoScene( "menu2" ) 
	            composer.halaman_page = composer.halaman_page - 10
	        
	   end 
                      end






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
                      myImage.xScale = (0.3 * display.contentWidth) / 700
                      myImage.yScale = (0.3 * display.contentWidth) / 700
                      myImage.alpha = 1
                      --transition.to( layer.myImage, { alpha = 1.0 , delay = 0} )
                      scrollView:insert(myImage)


                       	  fhd:close()
					else
						
					end


                      	 if(data_loading == data_max - 1)then
			             	composer.hideOverlay()
			             	
			             else
			             	data_loading = data_loading + 1
			             end
                      

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
                    cancelall[index] = network.download( download, "GET", networkListener,params, "makanan"..index..".jpg", system.TemporaryDirectory, 0, 0 )

                    --print(composer.namagambar)

              end
               
        end




    local function dataResponseListenerMakanan( event )

          if ( event.isError ) then
            -- TODO Show error here
              print( "Network error!" )
              --loadIconListener()

          else
            print( "App data loaded" )
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



    if(composer.status_kategori == 1)then
			dl_id1 = network.request( "http://api.bursasajadah.com/api/bursasajadah/filter/48/-/terbaru/-/10/"..composer.halaman_page, "GET", dataResponseListenerMakanan )    		
	elseif(composer.status_kategori == 2)then
			dl_id1 = network.request( "http://api.bursasajadah.com/api/bursasajadah/filter/48/terendah/terbaru/-/10/"..composer.halaman_page, "GET", dataResponseListenerMakanan ) 
	else
    		dl_id1 = network.request( "http://api.bursasajadah.com/api/bursasajadah/filter/48/-/-/terlaris/10/"..composer.halaman_page, "GET", dataResponseListenerMakanan ) 
	end
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then

		network.cancel( dl_id1 )
		--network.cancel( dl_id ) 
          local i
          for i = 1 , 10 do
            
            network.cancel( cancelall[i])
            --print("hesemelehe "..cancelall[i])
          end
          composer.cancelAllTimers(); 


		if(teksfield~=nil)then
		teksfield:removeSelf()
		teksfield = nil
		end
		
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