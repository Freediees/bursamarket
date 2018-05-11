-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------

local widget = require( "widget" )
local json = require ("json")
local composer = require( "composer" )
local scene = composer.newScene()
local used_font = "PT_Sans-Web-Regular.ttf"
local used_font_bold = "PT_Sans-Web-Bold.ttf"
composer.gambar_detail = 1
composer.temp_detail = 0 + display.contentWidth * 0.05
composer.posisi_gambar = 0
composer.status = 1
status_back = 0
composer.teks_pilihan_warna = " - "
composer.teks_pilihan_ukuran = " - "
composer.page = 2
local teksfield2
local teksfield_total
local began = 1
cancelall = {}
cur_page = "view2"
local grup_menu = display.newGroup()
local buy
composer.sku = ""
composer.nama_produk = ""
composer.harga_produk = ""
composer.harga_disc = ""
composer.warna = ""
composer.ukuran = ""
composer.weight = ""
composer.qty = 1


local index_gambar = 1
local posisi_detail = 0

local warna_user = 0
local ukuran_user = 0


require "sqlite3"

local datab = "data.db"
local path = system.pathForFile(datab, system.DocumentsDirectory)
db = sqlite3.open( path )


-- local lfs = require( "lfs" )
 
-- 	local doc_path = system.pathForFile( "", system.TemporaryDirectory )
	 
-- 	for file in lfs.dir( doc_path ) do
-- 	    local destDir = system.TemporaryDirectory  -- Location where the file is stored
--         os.remove( system.pathForFile( file , destDir ) )
-- 	end


function scene:create( event )
	local sceneGroup = self.view
	




	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor(230/255, 230/255, 230/255 )	-- white
	

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
	

	
	local function onLogoEvent(event) 
			self:removeEventListener( "tap", onLogoEvent ) 
            but_logo(logo)   
          
          
          return true 
       end 
       logo:addEventListener("tap", onLogoEvent ) 

   function but_logo(self) 
      
            if nil~= composer.getScene("test_home") then composer.removeScene("test_home", true) end  
            if  self.type == "press" then 
                self:setEnabled(false) 
            else 
                
            end 
            composer.gotoScene( "test_home" ) 
        
   end 


   local back = display.newText( "Back", 20 , 0 + display.contentHeight / 20, used_font, 15  * (display.contentWidth / 320)  )
	back.anchorX = 0
	back.anchorY = 0.5
	back.alpha = 0
	--title:setFillColor( 1 )	-- black

	function onbackView( event )
		if nil~= composer.getScene("test_home") then composer.removeScene("test_home", true) end  
        if  self.type == "press" then 
            self:setEnabled(false) 
        else 
            --self:removeEventListener( "tap", onMenu1 ) 
        end 
        local function goon()
        composer.gotoScene( "test_home" ) 
    	end
    	timer.performWithDelay(1000, goon)
	end
	back:addEventListener("tap", onbackView )

	
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

	composer.tinggi_header = composer.tinggi_teksfield + display.contentHeight/30
	

	local function toview1 ()
			if nil~= composer.getScene("test_home") then composer.removeScene("test_home", true) end  

            composer.gotoScene( "test_home" ) 
	end

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

	local function scrollListener1( event )
 
	    local phase = event.phase
	    if ( phase == "began" ) then 
	    	if(teksfield_total ~= nil)then
	    		teksfield_total:removeSelf()
	    		teksfield_total = nil
	    	end
	    elseif ( phase == "moved" ) then 
	    elseif ( phase == "ended" ) then 
	    end
	    return true
	end

	local function scrollListenerBannerz( event )
 		
	   local phase = event.phase
	    if ( phase == "began" ) then
	    elseif ( phase == "moved" ) then

	    elseif ( phase == "ended" ) then
	    	local dy = ( event.x - event.xStart ) 
	    	if ( dy > 50 ) then
		            swipeRight_Detail()
		        elseif ( dy < -50 ) then
			    	swipeLeft_Detail()
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
	        backgroundColor = {248/255,248/255,248/255},
	        --backgroundColor = {230/255, 230/255, 230/255},
	        --scrollWidth = 600,
	        --scrollHeight = 2000,
	        --listener = scrollListener

	    }
	)

	
	local scrollBarOpt = {
	    width = 20,
	    height = 20,
	    numFrames = 3,
	    sheetContentWidth = 20,
	    sheetContentHeight = 60
	}
	local scrollBarSheet = graphics.newImageSheet( composer.imgDir.."tab1.png", scrollBarOpt )

	scrollView3 = widget.newScrollView(
	    {
	        top = 0 + display.contentHeight/30,
	        left = composer.temp_detail,
	        width = 700 * ((0.9 * display.contentWidth) / 700),
	        height = 700 * ((0.9 * display.contentWidth) / 700),
	        horizontalScrollDisabled = false,
	        verticalScrollDisabled = true,
	        backgroundColor = {133/255,190/255,72/255},
	        isBounceEnabled = false,
	        
	        hideBackground = true,
	        --scrollWidth = 600,
	        --scrollHeight = 2000,
	        listener = scrollListenerBannerz,
	        scrollBarOptions = {
	        	sheet = scrollBarSheet,
	            topFrame = 1,
	            middleFrame = 2,
	            bottomFrame = 3
	        }
	    }
	)
	scrollView3:setIsLocked(true)
	scrollView:insert(scrollView3)

	function swipeLeft_Detail()

		print("left")
		

		if(index_gambar < composer.data_max_gambar and index_gambar>=0)then
		scrollView3:scrollToPosition
		{
			x = posisi_detail - display.contentWidth*0.9 * index_gambar
		}
		if(index_gambar ~= composer.data_max_gambar -1)then
			index_gambar = index_gambar + 1
		end
		print(index_gambar)
		print(composer.data_max_gambar)
		end
	end

	function swipeRight_Detail()

		print("right")
		
		if(index_gambar ~= 0)then
			index_gambar = index_gambar -1
		end
		if(index_gambar <= composer.data_max_gambar and index_gambar>=0)then
		scrollView3:scrollToPosition
		{
			x = posisi_detail - display.contentWidth*0.9 * index_gambar
		}
		print(index_gambar)
		print(composer.data_max_gambar)
		end
	end
	

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
		









	function call_sisanya()

					local posisi_teks_y = scrollView3.height + display.contentHeight * 0.1
					local posisi_teks_x  = display.contentWidth * 0.05
					composer.hideOverlay("fade", 200)

					 if(composer.nama_produk == nil)then
							composer.nama_produk = "-"
						end

                     local options = {
						 text = composer.nama_produk,
	                     x = posisi_teks_x,
	                     y = posisi_teks_y,
	                     font = used_font,
	                     fontSize = 17  * (display.contentWidth / 320),
	                     align = "left",
	                     width = (0.9 * display.contentWidth)
                 	 }

                 	 print(composer.nama_produk)

                 	 local teks_produk_diskon = display.newText(options)
			         teks_produk_diskon.anchorX = 0
			         teks_produk_diskon.anchorY = 0
			         --teks_produk_diskon:setFillColor(133/255,190/255,72/255);
			         teks_produk_diskon:setFillColor(0.2);
			         scrollView:insert(teks_produk_diskon);


			         if(composer.harga_produk == nil)then
			     	 		composer.harga_produk = "- (Ask For Price)"
			     	 	end

			         if(composer.halaman_menu == 7) then
			         local options2 = {
						 text = tostring("Rp "..composer.harga_produk),
	                     x = posisi_teks_x,
	                     y = posisi_teks_y + teks_produk_diskon.height + display.contentHeight/30,
	                     font = used_font,
	                     fontSize = 11  * (display.contentWidth / 320),
	                     align = "left",
	                     --width = (0.45 * display.contentWidth)
                 	 }




                 	 local teks_produk_diskon_harga = display.newText(options2)
			         teks_produk_diskon_harga.anchorX = 0
			         teks_produk_diskon_harga.anchorY = 0
			         teks_produk_diskon_harga:setFillColor(133/255,190/255,72/255);
			         scrollView:insert(teks_produk_diskon_harga);

			        local coret = display.newLine( teks_produk_diskon_harga.x, teks_produk_diskon_harga.y + teks_produk_diskon_harga.height/2, teks_produk_diskon_harga.x + teks_produk_diskon_harga.width, teks_produk_diskon_harga.y + teks_produk_diskon_harga.height/2 )
					coret:setStrokeColor( 0)
					coret.strokeWidth = 2
					scrollView:insert(coret)


						if(composer.harga_disc == nil)then
							composer.harga_disc = "-"
						end
			         local options3 = {
						 text = tostring("Rp "..composer.harga_disc),
	                     x = teks_produk_diskon_harga.x + teks_produk_diskon_harga.width + display.contentWidth/20 ,
	                     y = posisi_teks_y + teks_produk_diskon.height + display.contentHeight/30,
	                     font = used_font,
	                     fontSize = 11  * (display.contentWidth / 320),
	                     align = "left",
	                     --width = (0.45 * display.contentWidth)
                 	 }


                 	 local teks_produk_diskon_harga2 = display.newText(options3)
			         teks_produk_diskon_harga2.anchorX = 0
			         teks_produk_diskon_harga2.anchorY = 0
			         teks_produk_diskon_harga2:setFillColor(133/255,190/255,72/255);
			         scrollView:insert(teks_produk_diskon_harga2);


			     	 else

			     	 	if(composer.harga_produk == nil)then
			     	 		composer.harga_produk = "- (Ask For Price)"
			     	 	end

			     	 	local options2 = {
						 text = tostring("Rp "..composer.harga_produk),
	                     x = posisi_teks_x,
	                     y = posisi_teks_y + teks_produk_diskon.height + display.contentHeight/80,
	                     font = used_font,
	                     fontSize = 16  * (display.contentWidth / 320),
	                     align = "left",
	                     --width = (0.45 * display.contentWidth)
                 		}




	                 	 local teks_produk_diskon_harga = display.newText(options2)
				         teks_produk_diskon_harga.anchorX = 0
				         teks_produk_diskon_harga.anchorY = 0
				         teks_produk_diskon_harga:setFillColor(133/255,190/255,72/255);
				         scrollView:insert(teks_produk_diskon_harga);


			     	 end

			     	 

			     	 local optionszz = {
						 text ="Harga yang Tertera hanya berlaku untuk Pembelian Online",
	                     x = display.contentWidth * 0.05,
	                     y = posisi_teks_y + display.contentHeight/10,
	                     font = used_font,
	                     fontSize = 11  * (display.contentWidth / 320),
	                     align = "left",
	                     width = (0.9 * display.contentWidth)
                 	 }


                 	 local tulisan_merah = display.newText(optionszz)
			         tulisan_merah.anchorX = 0
			         tulisan_merah.anchorY = 0
			         tulisan_merah:setFillColor(1,0,0);
			         scrollView:insert(tulisan_merah);


			         buy = display.newRect(0, tulisan_merah.y + display.contentHeight/10, display.contentWidth/2, display.contentHeight/15)
			     	 buy:setFillColor(112/255, 193/255, 90/255)
			     	 buy.anchorX = 0
			     	 buy.anchorY = 0
			     	 scrollView:insert(buy)

			     	 local optionszz = {
						 text ="BELI SEKARANG",
	                     x = buy.x + buy.width/2,
	                     y = buy.y + buy.height/2, 
	                     font = used_font,
	                     fontSize = 11  * (display.contentWidth / 320),
	                     align = "center",
	                     --width = (0.9 * display.contentWidth)
                 	 }


                 	 local buy_text = display.newText(optionszz)
			         buy_text.anchorX = 0.5
			         buy_text.anchorY = 0.5
			         buy_text:setFillColor(1);
			         scrollView:insert(buy_text);

			         --buy.addEventListener("tap", onPilihanBeli)

			     	 local chat = display.newRect(display.contentCenterX, tulisan_merah.y + display.contentHeight/10, display.contentWidth/2, display.contentHeight/15)
			     	 chat:setFillColor(229/255, 190/255, 0/255)
			     	 chat.anchorX = 0
			     	 chat.anchorY = 0
			     	 scrollView:insert(chat)

			     	 local function onChat()
			     	 	-- body
			     	 	local alert = native.showAlert( "Alert", "Fungsi Ini Belum Tersedia", { "OK"})

			     	 end
			     	 chat:addEventListener("tap", onChat)

			     	 local optionszz = {
						 text ="CHAT ADMIN",
	                     x = chat.x + chat.width/2,
	                     y = chat.y + chat.height/2, 
	                     font = used_font,
	                     fontSize = 11  * (display.contentWidth / 320),
	                     align = "center",
	                     --width = (0.9 * display.contentWidth)
                 	 }


                 	 local chat_text = display.newText(optionszz)
			         chat_text.anchorX = 0.5
			         chat_text.anchorY = 0.5
			         chat_text:setFillColor(1);
			         scrollView:insert(chat_text);



			         if(composer.desc_product == nil)then
			         	composer.desc_product = "-"
			         end



			         local options3 = {

						 text = "Deskripsi Produk",
	                     x = display.contentWidth * 0.05,
	                     y = buy.y + buy.height + display.contentHeight/20,
	                     font = used_font,
	                     fontSize = 17  * (display.contentWidth / 320),
	                     align = "left",
	                     width = (0.9 * display.contentWidth)
                 	 }


                 	 local label_desc = display.newText(options3)
			         label_desc.anchorX = 0
			         label_desc.anchorY = 0
			         label_desc:setFillColor(0.2);
			         scrollView:insert(label_desc);


			         local options3 = {

						 text = composer.desc_product,
	                     x = display.contentWidth * 0.05,
	                     y = label_desc.y + label_desc.height + display.contentHeight/20,
	                     font = used_font,
	                     fontSize = 11  * (display.contentWidth / 320),
	                     align = "left",
	                     width = (0.9 * display.contentWidth)
                 	 }


                 	 local teks_produk_diskon_desc = display.newText(options3)
			         teks_produk_diskon_desc.anchorX = 0
			         teks_produk_diskon_desc.anchorY = 0
			         teks_produk_diskon_desc:setFillColor(0.2);
			         scrollView:insert(teks_produk_diskon_desc);


			         composer.tinggi_desc = teks_produk_diskon_desc.y + teks_produk_diskon_desc.height

					local pilihan_warna = display.newText( "Warna", 0 + display.contentWidth * 0.05 , composer.tinggi_desc + display.contentHeight/20 , used_font, 11  * (display.contentWidth / 320))
					pilihan_warna.anchorX = 0
					pilihan_warna:setFillColor( 0 )
					scrollView:insert(pilihan_warna)



					

					local background_warna = display.newRoundedRect( pilihan_warna.x, pilihan_warna.y + pilihan_warna.height/2 + 10, display.contentWidth*0.9, display.contentHeight/15, 5)
					background_warna.anchorY = 0
					background_warna.anchorX = 0
					background_warna:setFillColor( 133/255,190/255,72/255)
					scrollView:insert(background_warna)



					pilihan_warna2 = display.newText( " - Apa Saja - ", background_warna.x + 10 , background_warna.y + background_warna.height/2 , used_font, 11  * (display.contentWidth / 320))
					pilihan_warna2.anchorX = 0
					pilihan_warna2:setFillColor( 1 )
					scrollView:insert(pilihan_warna2)



					scrollViewWarna = widget.newScrollView(
					    {
					        top = background_hitam.y + display.contentHeight/20,
					        left = 0 + display.contentWidth * 0.05,
					        width = display.contentWidth - display.contentWidth * 0.1,
					        height = background_hitam.height - 2 * (display.contentHeight/20),
					        horizontalScrollDisabled = true,
					        verticalScrollDisabled = false,
					        hideBackground = true,
					        isBounceEnabled = false,
					        --scrollWidth = 600,
					        --scrollHeight = 2000,
					        listener = scrollListener

					    }
					)

					back_rounded = display.newRoundedRect(0 + display.contentWidth * 0.05,background_hitam.y + display.contentHeight/20, display.contentWidth*0.9, scrollViewWarna.height + 20, 5)
					back_rounded:setFillColor(0.9)
					back_rounded.anchorX = 0
					back_rounded.anchorY = 0
					back_rounded.alpha = 0

					sceneGroup:insert(back_rounded)
					sceneGroup:insert(scrollViewWarna)
					scrollViewWarna.alpha = 0

					local function onPilihanWarna()
						status_back = 1
						if(composer.data_max_warna > 0)then
						scrollViewWarna.alpha = 1
						back_rounded.alpha = 1
						background_hitam.alpha = 0.5
						scrollView:setIsLocked( true )
						end
					end
					background_warna:addEventListener("tap", onPilihanWarna)



					local index_warna
          			local posisi_warna = 20

          			if(composer.data_max_warna == nil)then
          				composer.data_max_warna = 0
          			end

          			if(composer.data_max_warna > 0)then
					for index_warna = 1, composer.data_max_warna do
                  		local data2 = listDataWarna[index_warna]
                  		--print(data2.varian)

                  		local teks1 = display.newText( data2.varian,30 , posisi_warna, used_font, 12  * (display.contentWidth / 320))
						teks1.anchorX = 0
						teks1.anchorY = 0.5
						teks1:setFillColor( 0 )
						scrollViewWarna:insert(teks1)

						local line = display.newLine( 10, teks1.y + teks1.height, scrollViewWarna.width-10, teks1.y + teks1.height )
						line:setStrokeColor( 133/255,190/255,72/255)
						line.strokeWidth = 1
						scrollViewWarna:insert(line)


						local function onTeks1()

							background_hitam.alpha = 0
							pilihan_warna2:removeSelf()
							pilihan_warna2 = nil
							composer.warna = data2.varian
							warna_user = 99
							pilihan_warna2 = display.newText( data2.varian, background_warna.x + 10 , background_warna.y + background_warna.height/2 , used_font, 11  * (display.contentWidth / 320))
							pilihan_warna2.anchorX = 0
							pilihan_warna2:setFillColor( 1 )
							scrollView:insert(pilihan_warna2)

							scrollViewWarna.alpha = 0
							back_rounded.alpha = 0
							scrollView:setIsLocked( false )
						end
						teks1:addEventListener("tap", onTeks1)


						posisi_warna = posisi_warna + teks1.height + display.contentWidth/20
                  	end

                  	else
                  		composer.warna = ""
                  		local teks1 = display.newText( " - Apa Saja - ", posisi_warna , scrollViewWarna.height/2, used_font, 15  * (display.contentWidth / 320))
						teks1.anchorX = 0
						teks1.anchorY = 0.5
						teks1:setFillColor( 1 )
						scrollViewWarna:insert(teks1)
                  	end

					local pilihan_size = display.newText( " Ukuran ", 0 + display.contentWidth * 0.05 , background_warna.y + background_warna.height + 20, used_font, 11  * (display.contentWidth / 320))
					pilihan_size.anchorX = 0
					pilihan_size:setFillColor( 0 )
					scrollView:insert(pilihan_size)

					local background_ukuran = display.newRoundedRect( pilihan_size.x, pilihan_size.y + pilihan_size.height/2 + 10, display.contentWidth*0.9, display.contentHeight/15, 5)
					background_ukuran.anchorY = 0
					background_ukuran.anchorX = 0
					background_ukuran:setFillColor( 133/255,190/255,72/255)
					scrollView:insert(background_ukuran)

					pilihan_size2 = display.newText( " - Apa Saja -", background_ukuran.x + 10 , background_ukuran.y + background_ukuran.height/2 , used_font, 11  * (display.contentWidth / 320))
					pilihan_size2.anchorX = 0
					pilihan_size2:setFillColor( 1 )
					scrollView:insert(pilihan_size2)


					

					scrollViewUkuran = widget.newScrollView(
					    {
					        top = background_hitam.y + display.contentHeight/20,
					        left = 0 + display.contentWidth * 0.05,
					        width = display.contentWidth - display.contentWidth * 0.1,
					        height = background_hitam.height - 2 * (display.contentHeight/20),
					        horizontalScrollDisabled = true,
					        verticalScrollDisabled = false,
					       -- backgroundColor = {0.99},
					        isBounceEnabled = false,
					        hideBackground = true,
					        --scrollWidth = 600,
					        --scrollHeight = 2000,
					        listener = scrollListener

					    }
					)
					sceneGroup:insert(scrollViewUkuran)
					scrollViewUkuran.alpha = 0


					local function onPilihanUkuran()
						if(composer.data_max_ukuran > 0)then
						status_back = 1
						back_rounded.alpha = 1
						scrollViewUkuran.alpha = 1
						background_hitam.alpha = 0.5
						scrollView:setIsLocked( true )
						end
					end
					background_ukuran:addEventListener("tap", onPilihanUkuran)

					local index_warna
          			local index_ukuran
          			local posisi_ukuran = 20

          			if(composer.data_max_ukuran > 0)then
					for index_ukuran = 1, composer.data_max_ukuran do
                  		local data2 = listDataUkuran[index_ukuran]
                  		--print(data2.varian)

                  		local teks1 = display.newText( data2.varian, 30 , posisi_ukuran, used_font, 15  * (display.contentWidth / 320))
						teks1.anchorX = 0
						teks1.anchorY = 0.5
						teks1:setFillColor( 0 )
						scrollViewUkuran:insert(teks1)

						local line = display.newLine( 10, teks1.y + teks1.height, scrollViewWarna.width-10, teks1.y + teks1.height )
						line:setStrokeColor( 133/255,190/255,72/255)
						line.strokeWidth = 1
						scrollViewWarna:insert(line)


						local function onTeks1()

							
							pilihan_size2:removeSelf()
							pilihan_size2 = nil
							background_hitam.alpha = 0
							composer.ukuran = data2.varian
							ukuran_user = 99
							pilihan_size2 = display.newText( data2.varian, background_warna.x + 10 , background_ukuran.y + background_ukuran.height/2 , used_font, 11  * (display.contentWidth / 320))
							pilihan_size2.anchorX = 0
							pilihan_size2:setFillColor( 1 )
							scrollView:insert(pilihan_size2)

							scrollViewUkuran.alpha = 0
							back_rounded.alpha = 0
							scrollView:setIsLocked( false )
						end
						teks1:addEventListener("tap", onTeks1)

						posisi_ukuran = posisi_ukuran + teks1.height + display.contentWidth/20
                  	end

                  	else
                  		composer.ukuran = ""
                  		local teks1 = display.newText( " - Apa Saja - ", posisi_ukuran , scrollViewUkuran.height/2, used_font, 15  * (display.contentWidth / 320))
						teks1.anchorX = 0
						teks1.anchorY = 0.5
						teks1:setFillColor( 1  )
						scrollViewUkuran:insert(teks1)
                  	end


                  	local pilihan_total = display.newText( " Jumlah ", 0 + display.contentWidth * 0.05 , background_ukuran.y + background_ukuran.height + 20, used_font, 11  * (display.contentWidth / 320))
					pilihan_total.anchorX = 0
					pilihan_total:setFillColor( 0 )
					scrollView:insert(pilihan_total)

					local background_total = display.newRoundedRect( pilihan_total.x, pilihan_total.y + pilihan_total.height/2 + 10, display.contentWidth*0.9, display.contentHeight/15, 5)
					background_total.anchorY = 0
					background_total.anchorX = 0
					background_total:setFillColor( 0.9)
					scrollView:insert(background_total)

					local label_total = display.newText( "1", background_total.x + 10 , background_total.y + background_total.height/2, used_font, 13  * (display.contentWidth / 320))
					label_total.anchorY = 0.5
					label_total.anchorX = 0
					label_total:setFillColor( 0 )
					scrollView:insert(label_total)


					local function create_teksfield_total()

					teksfield_total = native.newTextField(display.contentCenterX, label_total.y, display.contentWidth*0.85, display.contentHeight/15)
					teksfield_total.anchorX = 0.5
					teksfield_total.anchorY = 0.5
					teksfield_total.inputType = "number"
					teksfield_total.font = native.newFont( used_font, 12  * (display.contentWidth / 320) )
					teksfield_total.hasBackground = false
					teksfield_total.size = 12  * (display.contentWidth / 320)
					teksfield_total:resizeHeightToFitFont()
					scrollView:insert( teksfield_total )


					local function fieldHandler_total(event) 
				               if ("began" == event.phase) then 

				               	  label_total.text = ""

				                  if name ~= nil then
				                    --name:removeSelf()
				                    --name = nil

				                  end
				               elseif ("ended" == event.phase) then 
				                  composer.qty = teksfield_total.text
				                  label_total.text = teksfield_total.text
				                  if(teksfield_total.text == nil or teksfield_total.text == "")then
				                  	label_total.text = "1"
				                  end
				                  if(teksfield_total ~= nil)then
				                  teksfield_total:removeSelf()
				                  teksfield_total = nil
				              	  end

				               elseif ("submitted" == event.phase) then  
				                  composer.qty = teksfield_total.text
				                  label_total.text = teksfield_total.text

				                  if(teksfield_total.text == nil or teksfield_total.text == "")then
				                  	label_total.text = "1"
				                  end
				                  native.setKeyboardFocus(nil) 
				              	  				                elseif ( event.phase == "editing" ) then
				                  
				                 composer.qty = teksfield_total.text

				                end  
				         end 

				    teksfield_total:addEventListener( "userInput", fieldHandler_total ) 


					end

					background_total:addEventListener("tap", create_teksfield_total)


					local background_beli = display.newRoundedRect( pilihan_total.x, background_total.y + background_total.height + display.contentHeight/10 , display.contentWidth*0.9, display.contentHeight/15, 5)
					if(tonumber(composer.stock) == 0)then
						background_beli:setFillColor( 1,0,0)
					else
						background_beli:setFillColor( 133/255,190/255,72/255)
					end
					background_beli.anchorY = 0
					background_beli.anchorX = 0
					scrollView:insert(background_beli)


					function onPilihanBeli()


						
						-- composer.nama_produk = data.product
	     --              	composer.harga_produk = data.regular_price
	     --              	composer.desc_product = listData2.deskripsi
	     --              	composer.harga_disc = data.disc_price
	     				composer.id_lempar = tonumber(composer.id_lempar)
						local id_lempar = composer.id_lempar
						local nama_produk = composer.nama_produk
						local harga_produk = composer.harga_produk
						local harga_disc = composer.harga_disc
						local warna = composer.warna
						local ukuran = composer.ukuran
						local weight = composer.weight
						local qty = composer.qty
						
						
						local harga_fix
						print("harganya : "..composer.harga_disc)

						if(tonumber(composer.harga_disc) ~= nil and tonumber(composer.harga_disc) ~= 0)then
							harga_fix = composer.harga_disc
						else
							harga_fix = composer.harga_produk
						end

						if(qty == nil or qty == "")then
							qty = 1
						end

						-- print(composer.harga_disc)
						-- print(composer.harga_produk)
						-- print(harga_fix)
						local loop = 0
						local sum = 0
						for row in db:nrows([[SELECT * FROM t_produk_cart where sku = ']]..composer.sku..[[']]) do
						  loop = loop + 1
						end

						if(loop > 0)then

							print("masuk update")
							for row in db:nrows([[SELECT sum(qty) as total FROM t_produk_cart  where sku = ']]..composer.sku..[[']]) do
								sum = row.total
							end
							qty = qty + sum
							local tablesetup = [[update t_produk_cart set qty = ']]..qty..[[' where sku = ']]..composer.sku..[[']]
						    db:exec(tablesetup)
						else
							print("masuk insert")
							local tablesetup = [[INSERT INTO t_produk_cart VALUES(NULL, ']]..composer.sku..[[', ']]..id_lempar..[[',']]..nama_produk..[[',']]..harga_fix..[[',']]..qty..[[',']]..weight..[[',']]..warna..[[',']]..ukuran..[[');]]
						   	db:exec(tablesetup)
						end
						local status = 0
						if(composer.data_max_ukuran > 0 and ukuran_user == 0)then
							status = 1
						end
						if(composer.data_max_warna > 0 and warna_user == 0)then
							status = 1
						end

						--print("status : "..status)
						--print(composer.data_max_ukuran)
						--print(composer.data_max_warna)
						--print(ukuran_user)
						--print(warna_user)
						
						if(status == 0)then

							background_beli.alpha = 0.5
							background_beli:removeEventListener("tap", onPilihanBeli)

							if nil~= composer.getScene("test_cart") then composer.removeScene("test_cart", true) end 
							composer.gotoScene("test_cart")
						else
							local alert = native.showAlert( "Data Belum lengkap", "Data warna atau ukuran belum dipilih", { "OK"})
						end


					end

					if(tonumber(composer.stock) > 0) then
						buy:addEventListener("tap", onPilihanBeli)
						background_beli:addEventListener("tap", onPilihanBeli)
					end


					if(tonumber(composer.stock) > 0)then
						teks_beli = display.newText( "BELI", display.contentCenterX, background_beli.y + background_beli.height/2 , used_font, 11  * (display.contentWidth / 320))
					else
						teks_beli = display.newText( "Stock Habis", display.contentCenterX, background_beli.y + background_beli.height/2 , used_font, 11  * (display.contentWidth / 320))
					end
					teks_beli.anchorX = 0.5
					teks_beli:setFillColor( 1 )
					scrollView:insert(teks_beli)

			         	local tinggi_teks1 = background_beli.y + display.contentHeight/ 7


			         	

	--======================================================FOOTER======================================================--




	local footer_background = display.newRect( display.contentCenterX, tinggi_teks1 + display.contentHeight/20, display.contentWidth, display.contentHeight/7)
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


           
                      composer.gambar_detail = composer.gambar_detail + 1
	end
	

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.
	sceneGroup:insert( background )
	sceneGroup:insert( background2 )
	sceneGroup:insert(logo)
	sceneGroup:insert( back )
	sceneGroup:insert( lingkaran_profile )
	sceneGroup:insert( menu )
	sceneGroup:insert( scrollView )
	

	sceneGroup:insert(myRectangle1)
	sceneGroup:insert(teks_search)


	sceneGroup:insert(background_hitam)
	-- create a white background to fill screen



end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	

	cur_page = "view2"





	-- composer.removeHidden()
	

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


	if phase == "will" then

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

		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then

	composer.removeHidden()
		-- Called when the scene is now on screen
	  

	 --    teksfield2 = native.newTextField( 0 + display.contentWidth/20, composer.tinggi_teksfield , 0.8 * display.contentWidth, 40 )
		-- teksfield2.anchorX = 0
		-- sceneGroup:insert( teksfield2 )


		

      if composer.gambar_detail == 1 then

	  local function loadIconListenerDetail( event )
       		

	  				  if ( event.isError ) then
		                      --print( "Network error - download failed" )
		              elseif ( event.phase == "began" ) then
		                      cancelall[began] = event.requestId
		                      ----print( "Progress Phase: began" )
		                      began = began + 1
		              elseif ( event.phase == "ended" ) then
		                     -- --print( "displaying response image file" )
		                     local posisi_gambar = composer.posisi_gambar
	  				  --print("posisi_gambar : "..posisi_gambar)


	  				  local myImage = display.newImage( composer.imgDir.. "logo.png", 125, 39)
                      
                      myImage.anchorX = 0
                      myImage.anchorY = 0
                      myImage.x = composer.posisi_gambar
                      ----print("posisi gambar x : "..myImage.x)
                      myImage.y = 0
                      myImage.width = 700
                      myImage.height = 959
                      myImage.xScale = (0.9 * display.contentWidth) / 700
                      myImage.yScale = (0.9 * display.contentWidth) / 700
                      myImage.alpha = 1
                      scrollView3:insert(myImage)


                    local path = system.pathForFile( event.response.filename, event.response.baseDirectory )
					local fhd = io.open( path )

					-- Determine if file exists
					if fhd then


					  local background_back_image = display.newRect(composer.posisi_gambar, 0, 0.9 * display.contentWidth, scrollView3.height)
					  background_back_image:setFillColor(0.9,0.9,0.9)
					  background_back_image.anchorX = 0
					  background_back_image.anchorY = 0
					  scrollView3:insert(background_back_image)

					  local myImage
                      myImage = display.newImage( event.response.filename, event.response.baseDirectory, 20,  tes )
                      
                      if(myImage == nil)then
                      	myImage = display.newImage( composer.imgDir.. "logo.png", 125, 39)
                      end
                      myImage.anchorX = 0.5
                      myImage.anchorY = 0
                      myImage.x = composer.posisi_gambar + (display.contentWidth*0.9)/2
                      ----print("posisi gambar x : "..myImage.x)
                      myImage.y = 0
                      myImage.width = 700
                      myImage.height = 959
                      myImage.xScale = (scrollView3.height) / 959
                      myImage.yScale = (scrollView3.height) / 959
                      myImage.alpha = 1
                      scrollView3:insert(myImage)

                    end
                      composer.posisi_gambar = composer.posisi_gambar + (myImage.width * myImage.xScale)


                      local posisi_teks_x = 0 + display.contentWidth * 0.05
                      local posisi_teks_y = scrollView3.height + display.contentHeight * 0.1
                      local posisi_desc = 20 + display.contentHeight/30 + myImage.height * myImage.xScale




			         local tinggi_warna = 0
			        -- composer.tinggi_desc = teks_produk_diskon_desc.y + teks_produk_diskon_desc.height
			         composer.gambar_detail = composer.gambar_detail + 1


			         --print(composer.gambar_detail.." : "..composer.data_max_gambar)
			         if(composer.gambar_detail == composer.data_max_gambar) then

			         		call_sisanya()

			         end


		             end

	  				  
			        
                      
    
      end

	 function tampilDetail()
          local index
          

     
             for index = 1, composer.data_max do
      
                  local data = listData[index] 
                  local data2 = listDataUkuran[index]
                  --print("nama produk : "..data.product)  
                  

                  composer.nama_produk = data.product
                  composer.harga_produk = data.regular_price
                  composer.desc_product = listData2.deskripsi
                  composer.harga_disc = data.disc_price
                  composer.weight = data.weight
                  composer.sku = data.sku
                  composer.stock = data.stock



                  

                    local function networkListener( event )
					    if ( event.isError ) then
					        --print ( "Network error - download failed" )
					    else
					        event.target.alpha = 0
					        transition.to( event.target, { alpha = 1.0 } )
					    end
					 
					    --print ( "event.response.fullPath: ", event.response.fullPath )
					    --print ( "event.response.filename: ", event.response.filename )
					    --print ( "event.response.baseDirectory: ", event.response.baseDirectory )
					end
              end
        end

    function tampilGambar()

    	  --print("masuk fungsi")
          local index

          local params = {}
          params.progress = true
     
             for index = 1, composer.data_max_gambar do
      
                  local data = listData[index]
                   

                  composer.image = data.image
                  --print("alamat image : "..composer.image)

                    ----print("Nama link : "..composer.url_link)
                    ----print("Nama Gambar : "..composer.image)


                    local function networkListener( event )
					    if ( event.isError ) then
					        --print ( "Network error - download failed" )
					    else
					        event.target.alpha = 0
					        transition.to( event.target, { alpha = 1.0 } )
					    end
					 
					    --print ( "event.response.fullPath: ", event.response.fullPath )
					    --print ( "event.response.filename: ", event.response.filename )
					    --print ( "event.response.baseDirectory: ", event.response.baseDirectory )
					end


					local array_count = composer.image:len() - 4
			        local array1 = composer.image:sub(1,array_count)
			        local array2 = composer.image:sub(-4)

			        local download = tostring(array1..array2)
			        --local download = "https://pmcdeadline2.files.wordpress.com/2016/07/logo-tv-logo.png"

			       -- --print("hesemelehe")
			        ----print("hallo : "..data.image)

                     cancelall[index] = network.download( download, "GET", loadIconListenerDetail,params, "datadetail"..index..".jpg", system.TemporaryDirectory, 0, 0 )

                    ----print(composer.namagambar)

              end
               
        end

	local function dataResponseListener( event )


          if ( event.isError ) then
            -- TODO Show error here
              --print( "Network error!" )
              --loadIconListener()

          else


            --print( "App data loadedeeee" )
            listData2 = json.decode( event.response )
            -- yang ini nerima data json dari server, gampangna mah data dari server d masukin ke array.
            --listData = listData.content;

            data_max = table.getn(listData2.content);
            data_max_warna = table.getn(listData2.warna)
            data_max_ukuran = table.getn(listData2.ukuran)

            listData = listData2.content
           	listDataUkuran = listData2.ukuran
           	listDataWarna = listData2.warna

            composer.data_max = data_max
            composer.data_max_warna = data_max_warna
            composer.data_max_ukuran = data_max_ukuran
            ----print("deskripsi sebenarnya = "..listData2.deskripsi)




            local data

            --print("data max = "..data_max)
            ----print("data produk = "..data.product)

            --composer.data_detail = {}
            --composer.data_detail_harga = {}
            --composer.data_desc_product = {}

            for index = 1, data_max do
            	data = listData[index]
            	--table.insert(composer.data_detail, index, data.product)	
            	--table.insert(composer.data_detail_harga, index, data.regular_price)
            	--table.insert(composer.data_detail_description, index, data.desc_product)
            end

            tampilDetail()

           end
        end



        local function dataResponseListenerGambar( event )


          if ( event.isError ) then
            -- TODO Show error here
              --print( "Network error!" )
              --loadIconListener()

          else


            --print( "App data loadedeeee" )
            listData = json.decode( event.response )
            -- yang ini nerima data json dari server, gampangna mah data dari server d masukin ke array.
            --listData = listData.content;

            data_max = table.getn(listData);

            composer.data_max_gambar = data_max


            local data

            ----print("data produk = "..data.product)

            --composer.data_detail = {}
            --composer.data_detail_harga = {}
            --composer.data_desc_product = {}

            for index = 1, data_max do
            	data = listData[index]
            	--table.insert(composer.data_detail, index, data.product)	
            	--table.insert(composer.data_detail_harga, index, data.regular_price)
            	--table.insert(composer.data_detail_description, index, data.desc_product)
            end

            tampilGambar()

           end
        end
        	
		
		--print("id produk = "..composer.id_lempar)

		print(composer.id_lempar)
		dl_id1 = network.request( "http://api.bursasajadah.com/api/bursasajadah/productdetail/"..composer.id_lempar, "GET", dataResponseListener )
		dl_id2 = network.request( "http://api.bursasajadah.com/api/bursasajadah/image/"..composer.id_lempar.."/4", "GET", dataResponseListenerGambar )
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.

		end
	end	



end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		network.cancel( dl_id1 )
		network.cancel( dl_id2 )
		network.cancel( dl_id ) 
          local i
          for i = 1 , composer.data_max_gambar do
            local idevent = cancelall[i]
            network.cancel( idevent)
            ----print("hesemelehe "..cancelall[i])
          end
          composer.cancelAllTimers(); 

        if(scrollViewUkuran ~= nil) then
		scrollViewUkuran:removeSelf()
		scrollViewUkuran = nil
		end
		
		if(scrollViewWarna ~= nil) then
		scrollViewWarna:removeSelf()
		scrollViewWarna = nil
		end

		display.remove(scrollView3)
		display.remove(scrollView)
		display.remove(scrollView2)
		if(teksfield~=nil)then
		teksfield:removeSelf()
		teksfield = nil
		end

		if(teksfield ~= nil)then
			teksfield_total:removeSelf()
			teksfield_total = nil
		end

		if(sceneGroup ~= nil )then
		sceneGroup:removeSelf()
		sceneGroup = nil
		end
		-- Called when the scene is on screen and is about to move off screen
		
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
