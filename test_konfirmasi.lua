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
local began = 1
local loadall = 0
composer.page = 1
local looptimer = 0
local teksfield
cur_page = "konfirmasi"
status_back = 0

local teksfield_nama
local teksfield_invoice
local teksfield_email
local teksfield_pembayaran
local teksfield_referensi

local label_bca
local back_bca
local garis_bca
local label_mandiri
local back_mandiri
local garis_mandiri
local label_bni
local back_bni

local status_gajadi = 0


						
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
		composer.gotoScene( "view1" )
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

	
	local teks_diskon = display.newText( "Konfirmasi Pembayaran", display.contentCenterX, display.contentHeight/20 , used_font, 15  * (display.contentWidth / 320))
	teks_diskon.anchorX = 0.5
	teks_diskon:setFillColor(0)
	scrollView:insert(teks_diskon)
	composer.tinggi_line2 = teks_diskon.y

	local line2 = display.newLine( 0 + 0.05 * display.contentWidth, teks_diskon.y + display.contentHeight/40, display.contentWidth - display.contentWidth*0.05, teks_diskon.y + display.contentHeight/40 )
	line2:setStrokeColor( 133/255,190/255,72/255)
	line2.strokeWidth = 1
	scrollView:insert(line2)
	composer.tinggi_line2 = line2.y

	local function hide_all()
			if(teksfield_nama ~= nil)then
				print("nama adaan")
				teksfield_nama:removeSelf()
				teksfield_nama = nil
			end

			if(teksfield_email ~= nil)then
				print("email adaan")
				teksfield_email:removeSelf()
				teksfield_email = nil
			end
			if(teksfield_invoice ~= nil)then
				print("email adaan")
				teksfield_invoice:removeSelf()
				teksfield_invoice = nil
			end
			if(teksfield_bank ~= nil)then
				print("email adaan")
				teksfield_bank:removeSelf()
				teksfield_bank = nil
			end
			if(teksfield_pembayaran ~= nil)then
				print("email adaan")
				teksfield_pembayaran:removeSelf()
				teksfield_pembayaran = nil
			end
			if(teksfield_referensi ~= nil)then
				print("email adaan")
				teksfield_referensi:removeSelf()
				teksfield_referensi = nil
			end
	end


	local options = {
						 text = "No Invoice",
	                     x = 0 + 0.05 * display.contentWidth,
	                     y = line2.y + display.contentHeight/15,
	                     font = used_font_bold,
	                     fontSize = 13  * (display.contentWidth / 320),
	                     align = "left",
	                     width = (0.9 * display.contentWidth)
                 	 }


 	 label_invoice = display.newText(options)
     label_invoice.anchorX = 0
     label_invoice.anchorY = 0
     label_invoice:setFillColor(0);
     scrollView:insert(label_invoice);

	local garis3 = display.newLine( 0 + 0.05 * display.contentWidth, label_invoice.y + label_invoice.height + 3, display.contentWidth - display.contentWidth*0.05, label_invoice.y + label_invoice.height + 3)
	garis3:setStrokeColor( 133/255,190/255,72/255)
	garis3.strokeWidth = 1
	scrollView:insert(garis3)

	local function on_label_invoice()

		hide_all()


		teksfield_invoice = native.newTextField(display.contentCenterX, garis3.y -2, display.contentWidth*0.9, display.contentHeight/20)
		teksfield_invoice.anchorX = 0.5
		teksfield_invoice.anchorY = 1
		--teksfield_invoice.inputType = "number"
		teksfield_invoice.hasBackground = true
		--teksfield_invoice.placeholder = "invoice"
		scrollView:insert( teksfield_invoice )
		native.setKeyboardFocus(teksfield_invoice)


		local function fieldHandler_t(event) 
               if ("began" == event.phase) then 

               	label_invoice.text = teksfield_invoice.text
                  if name ~= nil then
                    --name:removeSelf()
                    --name = nil
                  end
               elseif ("ended" == event.phase) then 
                  label_invoice.text = teksfield_invoice.text
                  if(teksfield_invoice ~= nil )then
                  teksfield_invoice:removeSelf()
                  teksfield_invoice = nil
              	  end
              	  native.setKeyboardFocus(nil) 
               elseif ("submitted" == event.phase) then  
               	  label_invoice.text = teksfield_invoice.text
                 native.setKeyboardFocus(nil) 
                elseif ( event.phase == "editing" ) then
                  	
                  label_invoice.text = teksfield_invoice.text


                end  
         end 
        
		
        teksfield_invoice:addEventListener( "userInput", fieldHandler_t ) 

	end
	label_invoice:addEventListener("tap", on_label_invoice)

	local options = {
						 text = "Nama Lengkap",
	                     x = 0 + 0.05 * display.contentWidth,
	                     y = garis3.y + display.contentHeight/15,
	                     font = used_font_bold,
	                     fontSize = 13  * (display.contentWidth / 320),
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

	local function on_label_nama()	

		hide_all()

		teksfield_nama = native.newTextField(display.contentCenterX, garis1.y - 2, display.contentWidth*0.9, display.contentHeight/20)
		teksfield_nama.anchorX = 0.5
		teksfield_nama.anchorY = 1
		--teksfield_nama.inputType = "number"
		teksfield_nama.hasBackground = true
		--teksfield_nama.placeholder = "Nama"
		scrollView:insert( teksfield_nama )

		native.setKeyboardFocus(teksfield_nama)


		local function fieldHandler_t(event) 
               if ("began" == event.phase) then
               	   label_nama.text = teksfield_nama.text

                  if name ~= nil then
                    --name:removeSelf()
                    --name = nil
                  end
               elseif ("ended" == event.phase) then 
                  label_nama.text = teksfield_nama.text
                  if(teksfield_nama ~= nil )then
                  teksfield_nama:removeSelf()
                  teksfield_nama = nil
              	  end
                  native.setKeyboardFocus(nil) 

               elseif ("submitted" == event.phase) then  
               	  label_nama.text = teksfield_nama.text
                   
                elseif ( event.phase == "editing" ) then
                  	
                  label_nama.text = teksfield_nama.text


                end  
         end 
        
		--native.setKeyboardFocus( textfield_nama )
		
        teksfield_nama:addEventListener( "userInput", fieldHandler_t ) 

	end
	label_nama:addEventListener("tap", on_label_nama)



	local options = {
						 text = "Email",
	                     x = 0 + 0.05 * display.contentWidth,
	                     y = garis1.y + display.contentHeight/15,
	                     font = used_font_bold,
	                     fontSize = 13  * (display.contentWidth / 320),
	                     align = "left",
	                     width = (0.9 * display.contentWidth)
                 	 }


 	 label_email = display.newText(options)
     label_email.anchorX = 0
     label_email.anchorY = 0
     label_email:setFillColor(0);
     scrollView:insert(label_email);

	local garis2 = display.newLine( 0 + 0.05 * display.contentWidth, label_email.y + label_email.height + 3, display.contentWidth - display.contentWidth*0.05, label_email.y + label_email.height + 3)
	garis2:setStrokeColor( 133/255,190/255,72/255)
	garis2.strokeWidth = 1
	scrollView:insert(garis2)

	local function on_label_email()

		hide_all()


		teksfield_email = native.newTextField(display.contentCenterX, garis2.y -2, display.contentWidth*0.9, display.contentHeight/20)
		teksfield_email.anchorX = 0.5
		teksfield_email.anchorY = 1
		--teksfield_email.inputType = "number"
		teksfield_email.hasBackground = true
		--teksfield_email.placeholder = "email"
		scrollView:insert( teksfield_email )

		native.setKeyboardFocus(teksfield_email)


		local function fieldHandler_t(event) 
               if ("began" == event.phase) then 

               	label_email.text = teksfield_email.text
                  if name ~= nil then
                    --name:removeSelf()
                    --name = nil
                  end
               elseif ("ended" == event.phase) then 
                  label_email.text = teksfield_email.text
                  if(teksfield_email ~= nil )then
                  teksfield_email:removeSelf()
                  teksfield_email = nil
              	  end
              	  native.setKeyboardFocus(nil) 
               elseif ("submitted" == event.phase) then  
               	  label_email.text = teksfield_email.text
                   
                elseif ( event.phase == "editing" ) then
                  	
                  label_email.text = teksfield_email.text


                end  
         end 
        
		
        teksfield_email:addEventListener( "userInput", fieldHandler_t ) 

	end
	label_email:addEventListener("tap", on_label_email)



	local options = {
						 text = "Jumlah Pembayaran",
	                     x = 0 + 0.05 * display.contentWidth,
	                     y = garis2.y + display.contentHeight/15,
	                     font = used_font_bold,
	                     fontSize = 13  * (display.contentWidth / 320),
	                     align = "left",
	                     width = (0.9 * display.contentWidth)
                 	 }


 	 label_pembayaran = display.newText(options)
     label_pembayaran.anchorX = 0
     label_pembayaran.anchorY = 0
     label_pembayaran:setFillColor(0);
     scrollView:insert(label_pembayaran);

	local garis4 = display.newLine( 0 + 0.05 * display.contentWidth, label_pembayaran.y + label_pembayaran.height + 3, display.contentWidth - display.contentWidth*0.05, label_pembayaran.y + label_pembayaran.height + 3)
	garis4:setStrokeColor( 133/255,190/255,72/255)
	garis4.strokeWidth = 1
	scrollView:insert(garis4)

	local function on_label_pembayaran()

		hide_all()


		teksfield_pembayaran = native.newTextField(display.contentCenterX, garis4.y -2, display.contentWidth*0.9, display.contentHeight/20)
		teksfield_pembayaran.anchorX = 0.5
		teksfield_pembayaran.anchorY = 1
		--teksfield_pembayaran.inputType = "number"
		teksfield_pembayaran.hasBackground = true
		--teksfield_pembayaran.placeholder = "pembayaran"
		scrollView:insert( teksfield_pembayaran )
		native.setKeyboardFocus(teksfield_pembayaran)


		local function fieldHandler_t(event) 
               if ("began" == event.phase) then 

               	label_pembayaran.text = teksfield_pembayaran.text
                  if name ~= nil then
                    --name:removeSelf()
                    --name = nil
                  end
               elseif ("ended" == event.phase) then 
                  label_pembayaran.text = teksfield_pembayaran.text
                  if(teksfield_pembayaran ~= nil )then
                  teksfield_pembayaran:removeSelf()
                  teksfield_pembayaran = nil
              	  end
              	  native.setKeyboardFocus(nil) 
               elseif ("submitted" == event.phase) then  
               	  label_pembayaran.text = teksfield_pembayaran.text
                 
                  native.setKeyboardFocus(nil) 
                elseif ( event.phase == "editing" ) then
                  	
                  label_pembayaran.text = teksfield_pembayaran.text


                end  
         end 
        
		
        teksfield_pembayaran:addEventListener( "userInput", fieldHandler_t ) 

	end
	label_pembayaran:addEventListener("tap", on_label_pembayaran)




	local options = {
						 text = "- Sudah bayar ke rekening -",
	                     x = 0 + 0.05 * display.contentWidth,
	                     y = garis4.y + display.contentHeight/15,
	                     font = used_font_bold,
	                     fontSize = 13  * (display.contentWidth / 320),
	                     align = "left",
	                     width = (0.9 * display.contentWidth)
                 	 }


 	 label_bank = display.newText(options)
     label_bank.anchorX = 0
     label_bank.anchorY = 0
     label_bank:setFillColor(0);
     scrollView:insert(label_bank);

    local garis5
	garis5 = display.newLine( 0 + 0.05 * display.contentWidth, label_bank.y + label_bank.height + 3, display.contentWidth - display.contentWidth*0.05, label_bank.y + label_bank.height + 3)
	garis5:setStrokeColor( 133/255,190/255,72/255)
	garis5.strokeWidth = 1
	scrollView:insert(garis5)

	local function on_label_bank()

		hide_all()
		label_bank:removeEventListener("tap", on_label_bank)
		 --background_hitam.alpha = 0.5
		 garis5:removeSelf()
		 garis5 = nil
		
		 label_bca.alpha = 1
   	 	 back_bca.alpha = 1
    	 garis_bca.alpha = 1
  	  	 label_mandiri.alpha = 1
    	 back_mandiri.alpha = 1 
    	 garis_mandiri.alpha = 1
    	 label_bni.alpha = 1
    	 back_bni.alpha = 1



	end
	label_bank:addEventListener("tap", on_label_bank)




	local options = {
						 text = "Nomor Referensi jika ada",
	                     x = 0 + 0.05 * display.contentWidth,
	                     y = garis5.y + display.contentHeight/15,
	                     font = used_font_bold,
	                     fontSize = 13  * (display.contentWidth / 320),
	                     align = "left",
	                     width = (0.9 * display.contentWidth)
                 	 }


 	 label_referensi = display.newText(options)
     label_referensi.anchorX = 0
     label_referensi.anchorY = 0
     label_referensi:setFillColor(0);
     scrollView:insert(label_referensi);

	local garis6 = display.newLine( 0 + 0.05 * display.contentWidth, label_referensi.y + label_referensi.height + 3, display.contentWidth - display.contentWidth*0.05, label_referensi.y + label_referensi.height + 3)
	garis6:setStrokeColor( 133/255,190/255,72/255)
	garis6.strokeWidth = 1
	scrollView:insert(garis6)

	local function on_label_referensi()

		hide_all()


		teksfield_referensi = native.newTextField(display.contentCenterX, garis6.y -2, display.contentWidth*0.9, display.contentHeight/20)
		teksfield_referensi.anchorX = 0.5
		teksfield_referensi.anchorY = 1
		--teksfield_referensi.inputType = "number"
		teksfield_referensi.hasBackground = true
		--teksfield_referensi.placeholder = "referensi"
		scrollView:insert( teksfield_referensi )

		native.setKeyboardFocus(teksfield_referensi)

		local function fieldHandler_t(event) 
               if ("began" == event.phase) then 

               	label_referensi.text = teksfield_referensi.text
                  if name ~= nil then
                    --name:removeSelf()
                    --name = nil
                  end
               elseif ("ended" == event.phase) then 
                  label_referensi.text = teksfield_referensi.text
                  if(teksfield_referensi ~= nil )then
                  teksfield_referensi:removeSelf()
                  teksfield_referensi = nil
              	  end
              	  native.setKeyboardFocus(nil) 
               elseif ("submitted" == event.phase) then  
               	  label_referensi.text = teksfield_referensi.text
                  
                  native.setKeyboardFocus(nil) 
                elseif ( event.phase == "editing" ) then
                  	
                  label_referensi.text = teksfield_referensi.text


                end  
         end 
        
		
        teksfield_referensi:addEventListener( "userInput", fieldHandler_t ) 

	end
	label_referensi:addEventListener("tap", on_label_referensi)


	


	local options = {
						 text = "BCA no rek 008-9500-666 - A.N. PT. Aarti Jaya",
	                     x = 0 + 0.05 * display.contentWidth,
	                     y = garis4.y + display.contentHeight/15,
	                     font = used_font_bold,
	                     fontSize = 13  * (display.contentWidth / 320),
	                     align = "left",
	                     width = (0.9 * display.contentWidth)
                 	 }


 	 label_bca = display.newText(options)
     label_bca.anchorX = 0
     label_bca.anchorY = 0
     label_bca:setFillColor(0);


     back_bca = display.newRect(display.contentCenterX, label_bca.y + label_bca.height/2, 0.9 * display.contentWidth, label_bca.height + 2)
     back_bca:setFillColor(255/255,254/255,239/255)

    

    garis_bca = display.newLine( 0 + 0.05 * display.contentWidth, label_bca.y + label_bca.height, display.contentWidth - display.contentWidth*0.05, label_bca.y + label_bca.height)
	garis_bca:setStrokeColor( 133/255,190/255,72/255)
	garis_bca.strokeWidth = 1

     
	


     local options = {
						 text = "Mandiri no rek 130.0031.300.315 - A.N. PT. Aarti Jaya",
	                     x = 0 + 0.05 * display.contentWidth,
	                     y = label_bca.y + label_bca.height + 3,
	                     font = used_font_bold,
	                     fontSize = 13  * (display.contentWidth / 320),
	                     align = "left",
	                     width = (0.9 * display.contentWidth)
                 	 }


 	 label_mandiri = display.newText(options)
     label_mandiri.anchorX = 0
     label_mandiri.anchorY = 0
     label_mandiri:setFillColor(0);

     back_mandiri = display.newRect(display.contentCenterX, label_mandiri.y + label_mandiri.height/2, 0.9 * display.contentWidth, label_mandiri.height + 2)
     back_mandiri:setFillColor(255/255,254/255,239/255)

    garis_mandiri = display.newLine( 0 + 0.05 * display.contentWidth, label_mandiri.y + label_mandiri.height, display.contentWidth - display.contentWidth*0.05, label_mandiri.y + label_mandiri.height)
	garis_mandiri:setStrokeColor( 133/255,190/255,72/255)
	garis_mandiri.strokeWidth = 1


	 local options = {
						 text = "BNI no rek 600.6700.774 - A.N. PT. Aarti Jaya",
	                     x = 0 + 0.05 * display.contentWidth,
	                     y = label_mandiri.y + label_mandiri.height + 3,
	                     font = used_font_bold,
	                     fontSize = 13  * (display.contentWidth / 320),
	                     align = "left",
	                     width = (0.9 * display.contentWidth)
                 	 }


 	 label_bni = display.newText(options)
     label_bni.anchorX = 0
     label_bni.anchorY = 0
     label_bni:setFillColor(0);

     back_bni = display.newRect(display.contentCenterX, label_bni.y + label_bni.height/2, 0.9 * display.contentWidth, label_bni.height + 2)
     back_bni:setFillColor(255/255,254/255,239/255)


     print("label bni "..label_bni.text);


     local function hide_bank()
     	print("hide")
         label_bca.alpha = 0
	     back_bca.alpha = 0
	     garis_bca.alpha = 0
	     label_mandiri.alpha = 0
	     back_mandiri.alpha = 0
	     garis_mandiri.alpha = 0
	     label_bni.alpha = 0
	     back_bni.alpha = 0
	     local function tampil()
	     label_bank:addEventListener("tap", on_label_bank)
	 	 end
	 	 timer.performWithDelay(100, tampil)
     end

    local function show_bank()
         label_bca.alpha = 1
	     back_bca.alpha = 1
	     garis_bca.alpha = 1
	     label_mandiri.alpha = 1
	     back_mandiri.alpha = 1
	     garis_mandiri.alpha = 1
	     label_bni.alpha = 1
	     back_bni.alpha = 1

     end

    local function create_garis()
    	garis5 = display.newLine( 0 + 0.05 * display.contentWidth, label_bank.y + label_bank.height + 3, display.contentWidth - display.contentWidth*0.05, label_bank.y + label_bank.height + 3)
		garis5:setStrokeColor( 133/255,190/255,72/255)
		garis5.strokeWidth = 1
		scrollView:insert(garis5)
    end

     local function on_back_mandiri()
     	 
     	 hide_bank()

	     label_bank.text = label_mandiri.text

	     create_garis()
	    
     end
     back_mandiri:addEventListener("tap", on_back_mandiri)

     local function on_back_bni()
     	 
     	 hide_bank()

	     label_bank.text = label_bni.text

	     create_garis()
	    
     end
     back_bni:addEventListener("tap", on_back_bni)


      local function on_back_bca()

     	 hide_bank()

	     label_bank.text = label_bca.text

	     create_garis()
     end
     label_bca:addEventListener("tap", on_back_bca)

     label_bca.alpha = 0
     back_bca.alpha = 0
     garis_bca.alpha = 0
     label_mandiri.alpha = 0
     back_mandiri.alpha = 0
     garis_mandiri.alpha = 0
	 label_bni.alpha = 0
	 back_bni.alpha = 0
     

    local background_konfirmasi = display.newRoundedRect( display.contentCenterX, garis6.y + display.contentHeight/20, 0.9 * display.contentWidth, 50, 10)
	background_konfirmasi.anchorY = 0
	background_konfirmasi:setFillColor( 133/255,190/255,72/255)
	scrollView:insert(background_konfirmasi)


	local options = {
		 text = "SELESAI",
         x = background_konfirmasi.x,
         y =  background_konfirmasi.y + background_konfirmasi.height/2,
         font = used_font_bold,
         fontSize = 13  * (display.contentWidth / 320),
         align = "center",
         width = (0.9 * display.contentWidth)
 	 }


 	 local  label_konfirmasi = display.newText(options)
     label_konfirmasi.anchorX = 0.5
     label_konfirmasi.anchorY = 0.5
     label_konfirmasi:setFillColor(1);
     scrollView:insert(label_konfirmasi);
     

     local function on_konfirmasi()

     		
     		
     		local function dataListenerPost( event )

	          if ( event.isError ) then
	            -- TODO Show error here
	              print( "Network error!" )
	              --loadIconListener()

	          else
	            --print( "App data loaded" )
	            listData = json.decode( event.response )
	            -- yang ini nerima data json dari server, gampangna mah data dari server d masukin ke array.

	            print(event.response)
	            print(listData.kode)

	            if(listData.kode == 1)then
	            local alert = native.showAlert( "Konfirmasi Berhasil", "Terima Kasih, anda akan dikembalikan pada halaman utama dalam 3 detik", { "OK"})

		            local function gotoview1( )
		            	-- body
		            if nil~= composer.getScene("view1") then composer.removeScene("view1", true) end  
		            if  self.type == "press" then 
		                self:setEnabled(false) 
		            else 
		                 
		            end 
		            composer.gotoScene( "view1" ) 
		            end
		            timer.performWithDelay(3000, gotoview1)

	        	


	        	elseif(listData.kode == -1)then
	            local alert = native.showAlert( "Konfirmasi Ulang", "No invoice telah dikonfirmasikan sebelumnya, anda akan dikembalikan pada halaman utama dalam 3 detik", { "OK"})

		            local function gotoview1( )
		            	-- body
		            composer.gotoScene("view1")
		            end
		            timer.performWithDelay(3000, gotoview1)


		        else

		        local alert = native.showAlert( "Data Salah", "Ada kesalahan data, mohon dicek kembali", { "OK"})


	        	end
		            --data_max = table.getn(listData);
		            
		        end
	        end


     		local headers = {
			}

			headers["Content-Type"] = "application/json"
			headers["X-API-Key"] = "13b6ac91a2"

			

			if(label_bank.text == "BNI no rek 600.6700.774 - A.N. PT. Aarti Jaya")then
				lempar_bank = "Bank BNI a/n PT. Aarti Jaya"
			elseif(label_bank.text == "Mandiri no rek 130.0031.300.315 - A.N. PT. Aarti Jaya")then
				lempar_bank = "Bank Mandiri a/n PT. Aarti Jaya"
			elseif(label_bank.text == "BCA no rek 008-9500-666 - A.N. PT. Aarti Jaya")then
				lempar_bank = "BCA a/n PT. Aarti Jaya"
			else
				local alert = native.showAlert( "Data Belum lengkap", "Data Bank Salah", { "OK"})

				status_gajadi = 1
			end

			local refrensi_bener = ""
			if(label_referensi == "Nomor Referensi jika ada")then
				refrensi_bener = ""
			end
			local lempar = {["nomor_invoice"] = label_invoice.text , ["nama_pengirim"] = label_nama.text, ["email"] = label_email.text, ["jumlah_pembayaran"] = label_pembayaran.text, ["bank"] = lempar_bank, ["kode_referensi"] = refrensi_bener }

			local params = {}
			params.headers = headers
			params.body = json.encode(lempar)


            print("params.body : "..params.body)

            if(status_gajadi == 0)then
            hide_all()
            network.request( "http://api.bursasajadah.com/api/bursasajadah/konfirmasi", "POST", dataListenerPost, params)
        	else
        	local alert = native.showAlert( "Data Belum lengkap", "Data Bank Salah", { "OK"})
        	end
     end
     label_konfirmasi:addEventListener("tap", on_konfirmasi)
	--======================================================FOOTER======================================================--




	local footer_background = display.newRect( display.contentCenterX, garis6.y + display.contentHeight/4, display.contentWidth, display.contentHeight/7)
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
	sceneGroup:insert( lingkaran_profile )
	
	sceneGroup:insert( scrollView )
	sceneGroup:insert( background_hitam )

	sceneGroup:insert(myRectangle1)
	sceneGroup:insert(teks_search)


	scrollView:insert(back_bca);
     scrollView:insert(label_bca);
	scrollView:insert(garis_bca)
     scrollView:insert(back_mandiri);
     scrollView:insert(label_mandiri);
     scrollView:insert(garis_mandiri);
     scrollView:insert(back_bni);
     scrollView:insert(label_bni);


	
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



		local function hideover()

	    	composer.hideOverlay("fade", 100)
		end
	    
	    timer.performWithDelay(3000, hideover)


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
		                      
		   
		              elseif ( event.phase == "ended" ) then
		               
		               
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
		

	

        --hide_all()
        --[[display.remove(scrollView_banner)  
	
		display.remove(scrollView)
		display.remove(scrollView2)--]]

		--sceneGroup:removeSelf()

		-- network.cancel( dl_id ) 
  --         local i
  --         for i = 1 , composer.data_max do
  --           local idevent = cancelall[i]
  --           network.cancel( idevent)
  --           print(cancelall[i])
  --         end
  --         composer.cancelAllTimers(); 

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

		

		--scrollView2.removeSelf()
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		--timer.cancel(id_timer)

		
  		
			
		
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