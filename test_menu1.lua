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
composer.subkategori = 0
--composer.halaman_page = 0
local data_loading = 0
local cancelall = {}
local began = 1
local teksfield
local status_back = 0
cur_page = "menu1"
composer.text_sorting = "-"



local function toview1 ()
if nil~= composer.getScene("test_home") then composer.removeScene("test_home", true) end  

composer.gotoScene( "test_home" ) 
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
	local grup1 = display.newGroup()

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
	
	composer.posisi_x1 = display.contentCenterX - display.contentWidth/20
	composer.posisi_x2 = display.contentCenterX + display.contentWidth/20
	composer.posisi_y = 0
	composer.tinggi_scrollview = 0
	
	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.
	
	-- create a white background to fill screen
	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor(230/255, 230/255, 230/255 )-- white
	

	--[[local background2 = display.newRect( display.contentCenterX, 0, display.contentWidth, display.contentHeight/5)
	background2.anchorY = 0
	background2:setFillColor( 133/255,190/255,72/255)--]]

	local background2 = display.newRect( display.contentCenterX, 0, display.contentWidth, display.contentHeight/8)
	background2.anchorY = 0
	background2:setFillColor( 1)
	
	background_hitam = display.newRect( 0 , background2.y + background2.height, display.contentWidth, display.contentHeight - background2.height)
	background_hitam.anchorY = 0
	background_hitam.anchorX = 0
	background_hitam.alpha = 0
	background_hitam:setFillColor(0)


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
	-- 	composer.gotoScene( "view2" )
	-- end
 --    title:addEventListener("tap", onSecondView ) 



   

 	

	local function showMenu()
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

	
	function onLoginView( event )
		

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


	


	
	

	--composer.tinggi_header = background2.height
	
	

	

  composer.tinggi_teksfield = background2.height + display.contentHeight/30
	--composer.tinggi_teksfield = logo.y + logo.height + display.contentHeight / 100 
	--composer.tinggi_teksfield = 100

	--local function hideover()

	local function hideover()

    	composer.hideOverlay("fade", 100)
	end
    
    timer.performWithDelay(3000, hideover)

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
		

    	composer.tinggi_header = composer.tinggi_teksfield + display.contentHeight/30

        
		

	
	
	
    local function scrollListener( event )
 
	    local phase = event.phase
 
		    if ( phase == "moved" ) then
		        local dy = math.abs( ( event.y - event.yStart ) )
		        -- If the touch on the button has moved more than 10 pixels,
		        -- pass focus back to the scroll view so it can continue scrolling
		        if ( dy > 30 ) then
		            --scrollView:takeFocus( event )

		            if(grup1.alpha == 1)then
		            	grup1.alpha = 0
		            end
		        end
		    end
		    return true
		end

	--composer.tinggi_header = background2.height
	
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
	        listener = scrollListener

	    }
	)


	local teks_sajadah = display.newText( "Sajadah & Karpet", display.contentCenterX, display.contentHeight/20 , used_font_bold, 15  * (display.contentWidth / 320))
	teks_sajadah.anchorX = 0.5
	teks_sajadah:setFillColor(0.4)
	scrollView:insert(teks_sajadah)

	local back_tipe = display.newRoundedRect(display.contentCenterX - 10, teks_sajadah.y + display.contentHeight/20, display.contentWidth/5, display.contentHeight/30, 5)
	back_tipe.anchorX = 1
	back_tipe:setFillColor(133/255,190/255,72/255)
	scrollView:insert(back_tipe)

	local teks_tipe = display.newText( "TIPE", back_tipe.x - back_tipe.width/2, back_tipe.y , used_font_bold, 12  * (display.contentWidth / 320))
	teks_tipe.anchorX = 0.5
	teks_tipe:setFillColor(1)
	scrollView:insert(teks_tipe)

	local function onTeks_tipe(event) 
	            composer.status_kategori = 4
	            but_teks_tipe(teks_tipe)
	          return true 
	       end 
	       teks_tipe:addEventListener("tap", onTeks_tipe ) 

   function but_teks_tipe(self) 
      
            if nil~= composer.getScene("test_menu1") then composer.removeScene("test_menu1", true) end  
            if  self.type == "press" then 
                self:setEnabled(false) 
            else 
                self:removeEventListener( "tap", onTeks_tipe ) 
            end 
            composer.gotoScene( "test_menu1" ) 
        
   end 

   	local back_ukuran = display.newRoundedRect(display.contentCenterX + 10, teks_sajadah.y + display.contentHeight/20, display.contentWidth/5, display.contentHeight/30, 5)
	back_ukuran.anchorX = 0
	back_ukuran:setFillColor(133/255,190/255,72/255)
	scrollView:insert(back_ukuran)


	local teks_ukuran = display.newText( "UKURAN", back_ukuran.x + back_ukuran.width/2,  back_ukuran.y, used_font_bold, 12  * (display.contentWidth / 320))
	teks_ukuran.anchorX = 0.5
	teks_ukuran:setFillColor(1)
	scrollView:insert(teks_ukuran)
	

	local function onTeks_ukuran(event) 
        composer.status_kategori = 5
        but_teks_ukuran(teks_ukuran)
      return true 
   end 
   teks_ukuran:addEventListener("tap", onTeks_ukuran ) 

   function but_teks_ukuran(self) 
      
            if nil~= composer.getScene("test_menu1") then composer.removeScene("test_menu1", true) end  
            if  self.type == "press" then 
                self:setEnabled(false) 
            else 
                self:removeEventListener( "tap", onTeks_ukuran ) 
            end 
            composer.gotoScene( "test_menu1" ) 
        
   end 



    local teks_sorting = display.newText( "Sorting", 20,  teks_ukuran.y + display.contentWidth/10, used_font_bold, 12  * (display.contentWidth / 320))
	teks_sorting.anchorX = 0
	teks_sorting:setFillColor(0.2)
	scrollView:insert(teks_sorting)
	

	local back_sorting = display.newRoundedRect(teks_sorting.x + teks_sorting.width + 20, teks_sorting.y, display.contentWidth*0.7, display.contentHeight/30, 2)
	back_sorting.anchorX = 0
	back_sorting:setFillColor(0.9)
	scrollView:insert(back_sorting)

	local teks_sorting2 = display.newText( composer.text_sorting, back_sorting.x + 20,  teks_sorting.y, used_font, 12  * (display.contentWidth / 320))
	teks_sorting2.anchorX = 0
	teks_sorting2:setFillColor(0.2)
	scrollView:insert(teks_sorting2)


	--Grup1
	grup1.x = back_sorting.x
	grup1.y = back_sorting.y - back_sorting.height/2
	grup1.alpha = 0

	local back_sorting2 = display.newRoundedRect(0, 0, display.contentWidth*0.7, 3* back_sorting.height, 2)
	back_sorting2.anchorX = 0
	back_sorting2.anchorY = 0
	back_sorting2:setFillColor(0.9)
	grup1:insert(back_sorting2)

	local teks_teks1 = display.newText( "Terbaru", 20,  back_sorting2.height/6, used_font, 12  * (display.contentWidth / 320))
	teks_teks1.anchorX = 0
	teks_teks1.anchorY = 0.5
	teks_teks1:setFillColor(0)
	grup1:insert(teks_teks1)

	local function onTeks_ukuran(event) 
		composer.text_sorting = "Terbaru"
        composer.status_kategori = 1
        but_teks_ukuran(teks_teks1)
      return true 
    end 
    teks_teks1:addEventListener("tap", onTeks_ukuran ) 

	local teks_teks2 = display.newText( "Termurah", 20,  back_sorting2.height/2, used_font, 12  * (display.contentWidth / 320))
	teks_teks2.anchorX = 0
	teks_teks2.anchorY = 0.5
	teks_teks2:setFillColor(0)
	grup1:insert(teks_teks2)

	local function onTeks_ukuran(event) 
		composer.text_sorting = "Termurah"
        composer.status_kategori = 2
        but_teks_ukuran(teks_teks2)
      return true 
    end 
    teks_teks2:addEventListener("tap", onTeks_ukuran )

	local teks_teks3 = display.newText( "Terlaris", 20,  back_sorting2.height * 5/6, used_font, 12  * (display.contentWidth / 320))
	teks_teks3.anchorX = 0
	teks_teks3.anchorY = 0.5
	teks_teks3:setFillColor(0)
	grup1:insert(teks_teks3)

	local function onTeks_ukuran(event) 
		composer.text_sorting = "Terlaris"
        composer.status_kategori = 3
        but_teks_ukuran(teks_teks3)
      return true 
    end 
    teks_teks3:addEventListener("tap", onTeks_ukuran )



	

	local function onsorting()
		grup1.alpha=1
		grup1:toFront()
	end
	back_sorting:addEventListener("tap", onsorting)

	composer.posisi_y = teks_sorting.y + display.contentHeight/20

	-- all objects must be added to group (e.g. self.view)
	sceneGroup:insert( background )
	sceneGroup:insert( background2 )
	sceneGroup:insert(logo)
	sceneGroup:insert( menu )
	sceneGroup:insert( lingkaran_profile )
	
	sceneGroup:insert( scrollView )
	scrollView:insert(grup1)
	sceneGroup:insert(myRectangle1)
	sceneGroup:insert(teks_search)

	sceneGroup:insert(grup_menu)
	grup_menu.alpha = 0
end

function scene:show( event )
	
	local sceneGroup = self.view
	local phase = event.phase
	

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

	if phase == "will" then
     
	

		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then

		  composer.removeHidden()

    
	
          function tampilSajadah()
          local index

          	



          	 local params = {}
             params.progress = true
     
             for index = 1, data_max do
      			   


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
                      scrollView:insert(myImage)



                      local posisi_teks_x = myImage.x + (myImage.width * myImage.xScale /2)

                       if(composer.gambar_iklan_sajadah%2 == 1)then
                       		posisi_teks_x = myImage.x - (myImage.width * myImage.xScale)
                       else
                       		posisi_teks_x = myImage.x
                       end

                      local posisi_teks_y = myImage.y + myImage.height * myImage.yScale + 10
                      local posisi_teks_y2 = posisi_teks_y 


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



					local lebar = 700 * (0.4 * display.contentWidth) / 700

                    local options = {

                     text = tostring("Rp. "..teks2..",-"),
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
			         teks_produk_diskon:setFillColor(0);


                 	 local options2 = {

                     text = teks,
                     x = posisi_teks_x + lebar * 0.1,
                     y = teks_produk_diskon.y + teks_produk_diskon.height + display.contentHeight/80,
                     font = used_font,
                     fontSize = 8  * (display.contentWidth / 320),
                     align = "left",
                     width = lebar - lebar*0.2
                 	 }

                 	 

			         local teks_produk_diskon_harga = display.newText(options2)
			         teks_produk_diskon_harga.anchorX = 0
			         teks_produk_diskon_harga.anchorY = 0
			         teks_produk_diskon_harga:setFillColor(0);

			          local tinggi = posisi_teks_y - 10
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

                     scrollView:insert(backitem)
			         scrollView:insert(teks_produk_diskon);
			         scrollView:insert(teks_produk_diskon_harga);

                    

                      composer.tinggi_scrollview = teks_produk_diskon_harga.y
                      --print(composer.gambar_iklan)
                      --print("pic saved")



                      if(composer.gambar_iklan_sajadah == data_max)then


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
								--myRoundedRect:setStrokeColor( 1, 0, 0 )

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
								            composer.id_kategori = 71
								          return true 
								       end 
								       tampil_next:addEventListener("tap", ontampil_next ) 

								   function but_tampil_next(self) 
								      
								            if nil~= composer.getScene("test_menu1") then composer.removeScene("test_menu1", true) end  
								            if  self.type == "press" then 
								                self:setEnabled(false) 
								            else 
								                self:removeEventListener( "tap", ontampil_next ) 
								            end 
								            composer.gotoScene( "test_menu1" ) 
								            composer.halaman_page= composer.halaman_page + 10
								        
								   end 


								   local function ontampil_prev(event) 
								            but_tampil_prev(tampil_prev)
								            composer.id_kategori = 71
								          return true 
								       end 
								       tampil_prev:addEventListener("tap", ontampil_prev ) 

								   function but_tampil_prev(self) 
								      
								            if nil~= composer.getScene("test_menu1") then composer.removeScene("test_menu1", true) end  
								            if  self.type == "press" then 
								                self:setEnabled(false) 
								            else 
								                self:removeEventListener( "tap", ontampil_prev ) 
								            end 
								            composer.gotoScene( "test_menu1" ) 
								            composer.halaman_page = composer.halaman_page - 10
								        
								   end 





                  	  end

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
                      scrollView:insert(myImage)


                       	  fhd:close()
					else
						
					end


                      --print(data_loading.." "..data_max)
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

                    cancelall[index] = network.download( download, "GET", networkListener,params, "sajadah"..index..".jpg", system.TemporaryDirectory, 0, 0 )

                    --print(composer.namagambar)

              end
               
        end



    local function dataResponseListenerSajadah( event )

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




    if(composer.status_kategori == 1)then
			dl_id1 = network.request( "http://api.bursasajadah.com/api/bursasajadah/filter/71/-/terbaru/-/10/"..composer.halaman_page, "GET", dataResponseListenerSajadah )    		
	elseif(composer.status_kategori == 2)then
			dl_id1 = network.request( "http://api.bursasajadah.com/api/bursasajadah/filter/71/terendah/terbaru/-/10/"..composer.halaman_page, "GET", dataResponseListenerSajadah ) 
	elseif(composer.status_kategori == 3)then
    		dl_id1 = network.request( "http://api.bursasajadah.com/api/bursasajadah/filter/71/-/-/terlaris/10/"..composer.halaman_page, "GET", dataResponseListenerSajadah ) 
	elseif(composer.status_kategori == 4)then
			dl_id1 = network.request( "http://api.bursasajadah.com/api/bursasajadah/produkcategory/tipe/10/"..composer.halaman_page, "GET", dataResponseListenerSajadah )
	else
			dl_id1 = network.request( "http://api.bursasajadah.com/api/bursasajadah/produkcategory/ukuran/10/"..composer.halaman_page, "GET", dataResponseListenerSajadah )
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
          for i = 1 , composer.data_max do
           
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