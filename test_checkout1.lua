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
status_back = 0
cur_page = "checkout1"
local teks_search
local grup_menu = display.newGroup()


local cancelbanner = {}
local hasil_nama = ""
local hasil_email = ""
local hasil_telepon = ""
local hasil_ = ""


local status_kecamatan = 0

composer.provinsi = ""
composer.kabupaten = ""
composer.kecamatan = ""


local teksfield_nama
local teksfield_email
local teksfield_telepon
local teksfield_alamat
local teksfield_kode_pos


local user_id = ""
require "sqlite3"

local datab = "data.db"
local path = system.pathForFile(datab, system.DocumentsDirectory)
db = sqlite3.open( path )

local count = 0
for row in db:nrows("SELECT kecamatan FROM t_checkout1") do
	count = count + 1
end

print("jumlah count = "..count)
if count > 0 then
	local tablesetup = [[DELETE FROM t_checkout1;]]
	db:exec(tablesetup)
end


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
			if(teksfield_telepon ~= nil)then
				print("email adaan")
				teksfield_telepon:removeSelf()
				teksfield_telepon = nil
			end
			if(teksfield_alamat ~= nil)then
				print("email adaan")
				teksfield_alamat:removeSelf()
				teksfield_alamat = nil
			end
			if(teksfield_kode_pos ~= nil)then
				print("email adaan")
				teksfield_kode_pos:removeSelf()
				teksfield_kode_pos = nil
			end
			if(teksfield_kecamatan ~= nil)then
				print("email adaan")
				teksfield_kecamatan:removeSelf()
				teksfield_kecamatan = nil
			end
	end

	


	local function scrollListener1( event )
 
	    local phase = event.phase
	    if ( phase == "began" ) then hide_all()
	    elseif ( phase == "moved" ) then 
	    elseif ( phase == "ended" ) then 
	    end
	    return true
	end
	

	
	composer.tinggi_teksfield = background2.height + display.contentHeight/30
	composer.tinggi_header = composer.tinggi_teksfield + display.contentHeight/30

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
	        listener = scrollListener1

	    }
	)

	

		
	--composer.tinggi_teksfield = logo.y + logo.height + display.contentHeight / 100 
	--composer.tinggi_teksfield = scrollView2.y - scrollView2.height

	--local function hideover()

    --composer.hideOverlay("fade", 100)
    

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
		myRectangle1:setStrokeColor(127/255,171/255,74/255 )
		

		myRectangle1:addEventListener("tap", createteksfield)


		teks_search = display.newText( "Cari Produk Disini", myRectangle1.x - myRectangle1.width/2 + 20, myRectangle1.y , used_font, 10  * (display.contentWidth / 320))
		teks_search.anchorX = 0
		teks_search:setFillColor(0)
		

    	composer.tinggi_header = composer.tinggi_teksfield + display.contentHeight/30


	--end

	
	local teks_diskon = display.newText( "Keranjang Belanja", display.contentCenterX, display.contentHeight/20 , used_font, 15  * (display.contentWidth / 320))
	teks_diskon.anchorX = 0.5
	teks_diskon:setFillColor(0)
	scrollView:insert(teks_diskon)
	composer.tinggi_line2 = teks_diskon.y

	local line2 = display.newLine( 0 + 0.05 * display.contentWidth, teks_diskon.y + display.contentHeight/40, display.contentWidth - display.contentWidth*0.05, teks_diskon.y + display.contentHeight/40 )
	line2:setStrokeColor( 133/255,190/255,72/255)
	line2.strokeWidth = 1
	scrollView:insert(line2)
	composer.tinggi_line2 = line2.y

	local teks_info = display.newText( "Masukan Informasi Pengiriman Barang", display.contentCenterX, line2.y + display.contentHeight/15, used_font, 15  * (display.contentWidth / 320))
	teks_info.anchorX = 0.5
	teks_info:setFillColor(0)
	scrollView:insert(teks_info)
	composer.tinggi_line2 = teks_info.y


	

	

	local options = {
						 text = "Nama Lengkap",
	                     x = 0 + 0.05 * display.contentWidth,
	                     y = teks_info.y + display.contentHeight/15,
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

		status_back = 1
		hide_all()

		teksfield_nama = native.newTextField(display.contentCenterX, garis1.y - 2, display.contentWidth*0.9, display.contentHeight/20)
		teksfield_nama.anchorX = 0.5
		teksfield_nama.anchorY = 1
		--teksfield_nama.inputType = "number"
		--teksfield_nama.hasBackground = true
		native.setKeyboardFocus(teksfield_nama)
		--teksfield_nama.placeholder = "Nama"
		scrollView:insert( teksfield_nama )



		local function fieldHandler_t(event) 
               if ("began" == event.phase) then
               	  --label_nama.text = teksfield_nama.text

                  if name ~= nil then
                    --name:removeSelf()
                    --name = nil
                  end
               elseif ("ended" == event.phase) then 
                  label_nama.text = teksfield_nama.text
                  status_back = 0
                  if(teksfield_nama~=nil)then
                  	teksfield_nama:removeSelf()
                  	teksfield_nama = nil
              	  end
                  native.setKeyboardFocus(nil) 

               elseif ("submitted" == event.phase) then  
               	  label_nama.text = teksfield_nama.text
                  composer.search = teksfield.text
                  native.setKeyboardFocus(nil) 
                elseif ( event.phase == "editing" ) then
                  	
                  label_nama.text = teksfield_nama.text


                end  
         end 
		
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
		status_back = 1

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
                  status_back = 0
                  teksfield_email:removeSelf()
                  teksfield_email = nil
                  native.setKeyboardFocus(nil) 
               elseif ("submitted" == event.phase) then  
               	  label_email.text = teksfield_email.text
                  composer.search = teksfield.text
                  native.setKeyboardFocus(nil) 
                elseif ( event.phase == "editing" ) then
                  	
                  label_email.text = teksfield_email.text


                end  
         end 
        
		
        teksfield_email:addEventListener( "userInput", fieldHandler_t ) 

	end
	label_email:addEventListener("tap", on_label_email)




	local options = {
						 text = "Telepon",
	                     x = 0 + 0.05 * display.contentWidth,
	                     y = garis2.y + display.contentHeight/15,
	                     font = used_font_bold,
	                     fontSize = 13  * (display.contentWidth / 320),
	                     align = "left",
	                     width = (0.9 * display.contentWidth)
                 	 }


 	 label_telepon = display.newText(options)
     label_telepon.anchorX = 0
     label_telepon.anchorY = 0
     label_telepon:setFillColor(0);
     scrollView:insert(label_telepon);

    local garis3 = display.newLine( 0 + 0.05 * display.contentWidth, label_telepon.y + label_telepon.height + 3, display.contentWidth - display.contentWidth*0.05, label_telepon.y + label_telepon.height + 3)
	garis3:setStrokeColor( 133/255,190/255,72/255)
	garis3.strokeWidth = 1
	scrollView:insert(garis3)


	local function on_label_telepon()	

		hide_all()
		status_back = 1
		teksfield_telepon = native.newTextField(display.contentCenterX, garis3.y -2, display.contentWidth*0.9, display.contentHeight/20)
		teksfield_telepon.anchorX = 0.5
		teksfield_telepon.anchorY = 1
		teksfield_telepon.inputType = "number"
		teksfield_telepon.hasBackground = true
		--teksfield_telepon.placeholder = "telepon"
		scrollView:insert( teksfield_telepon )

		native.setKeyboardFocus(teksfield_telepon)

		local function fieldHandler_t(event) 

				label_telepon.text = teksfield_telepon.text

               if ("began" == event.phase) then 
                  if name ~= nil then
                    --name:removeSelf()
                    --name = nil
                  end
               elseif ("ended" == event.phase) then 
                  label_telepon.text = teksfield_telepon.text
                  status_back = 0
                  teksfield_telepon:removeSelf()
                  teksfield_telepon = nil
                  native.setKeyboardFocus(nil) 
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

	
	local options = {
						 text = "Alamat",
	                     x = 0 + 0.05 * display.contentWidth,
	                     y = garis3.y + display.contentHeight/15,
	                     font = used_font_bold,
	                     fontSize = 13  * (display.contentWidth / 320),
	                     height = display.contentHeight/10,
	                     align = "left",
	                     width = (0.9 * display.contentWidth)
                 	 }


 	 label_alamat = display.newText(options)
     label_alamat.anchorX = 0
     label_alamat.anchorY = 0
     label_alamat:setFillColor(0);
     scrollView:insert(label_alamat);


    local garis4 = display.newLine( 0 + 0.05 * display.contentWidth, label_alamat.y + label_alamat.height + 3, display.contentWidth - display.contentWidth*0.05, label_alamat.y + label_alamat.height + 3)
	garis4:setStrokeColor( 133/255,190/255,72/255)
	garis4.strokeWidth = 1
	scrollView:insert(garis4)


	local function on_label_alamat()

	hide_all()
	status_back = 1
	teksfield_alamat = native.newTextBox( display.contentCenterX, garis3.y + display.contentHeight/15, display.contentWidth * 0.9, display.contentHeight/10 )
	--teksfield_alamat.text = "Alamat"
	teksfield_alamat.isEditable = true
	teksfield_alamat.hasBackground = false
	teksfield_alamat.anchorY = 0
	teksfield_alamat.size = 12  * (display.contentWidth / 320)
	scrollView:insert(teksfield_alamat)
	native.setKeyboardFocus(teksfield_alamat)
	--defaultBox:addEventListener( "userInput", textListener )


		local function fieldHandler_t(event) 
               if ("began" == event.phase) then 
                  if name ~= nil then

                  	label_alamat.text = ""

                    --name:removeSelf()
                    --name = nil
                  end
               elseif ("ended" == event.phase) then 
                  label_alamat.text = teksfield_alamat.text
                  status_back = 0
                  teksfield_alamat:removeSelf()
                  teksfield_alamat = nil
                  native.setKeyboardFocus(nil) 
               elseif ("submitted" == event.phase) then  
               	  label_alamat.text = teksfield_alamat.text
                  composer.search = teksfield.text
                  native.setKeyboardFocus(nil) 
                elseif ( event.phase == "editing" ) then
                  	
                  label_alamat.text = teksfield_alamat.text


                end  
         end 
        
		
        teksfield_alamat:addEventListener( "userInput", fieldHandler_t ) 

	end
	label_alamat:addEventListener("tap", on_label_alamat)



	

	


	local options = {
						 text = "Pilih Provinsi",
	                     x = 0 + 0.05 * display.contentWidth,
	                     y = garis4.y + display.contentHeight/15,
	                     font = used_font_bold,
	                     fontSize = 13  * (display.contentWidth / 320),
	                     align = "left",
	                     width = (0.9 * display.contentWidth)
                 	 }


 	 label_provinsi = display.newText(options)
     label_provinsi.anchorX = 0
     label_provinsi.anchorY = 0
     label_provinsi:setFillColor(0);
     scrollView:insert(label_provinsi);

	local garis5 = display.newLine( 0 + 0.05 * display.contentWidth, label_provinsi.y + label_provinsi.height + 3, display.contentWidth - display.contentWidth*0.05, label_provinsi.y + label_provinsi.height + 3)
	garis5:setStrokeColor( 133/255,190/255,72/255)
	garis5.strokeWidth = 1
	scrollView:insert(garis5)

	local function on_label_provinsi()
		-- body


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

		composer.showOverlay("overlay_loading", options_overlay)


		hide_all()
		removeall()
		status_back = 1
		
		--scrollViewWarna.alpha = 1
		background_hitam.alpha = 0.5
		scrollView:setIsLocked( true )
		--end

		scrollViewProvinsi = widget.newScrollView(
		    {
		        top = background_hitam.y + display.contentHeight/20,
		        left = 0 + display.contentWidth * 0.05,
		        width = display.contentWidth - display.contentWidth * 0.1,
		        height = background_hitam.height - 2 * (display.contentHeight/20),
		        horizontalScrollDisabled = true,
		        verticalScrollDisabled = false,
		        backgroundColor = {0.99},
		        isBounceEnabled = false,
		        --scrollWidth = 600,
		        --scrollHeight = 2000,
		        listener = scrollListener

		    }
		)
		sceneGroup:insert(background_hitam)
		sceneGroup:insert(scrollViewProvinsi)
		scrollViewProvinsi.alpha = 1


		local function insert_data()
			local index
			composer.hideOverlay("fade", 100)
			local posisi_provinsi = 20
			for index = 1,data_max_provinsi do
				local data = listData_provinsi[index]

				
				local teks1 = display.newText( data.provinsi, 10 , posisi_provinsi, used_font_bold, 15  * (display.contentWidth / 320))
				teks1.anchorX = 0
				teks1.anchorY = 0.5
				teks1:setFillColor( 0 )
				scrollViewProvinsi:insert(teks1)

				local line = display.newLine( 0, teks1.y + teks1.height, display.contentWidth, teks1.y + teks1.height )
				line:setStrokeColor( 0.85)
				line.strokeWidth = 1
				scrollViewProvinsi:insert(line)

				posisi_provinsi = posisi_provinsi + teks1.height + display.contentWidth/20

				local function on_teks1()
					composer.provinsi = teks1.text
					composer.provinsi = composer.provinsi:gsub( " ", "%%20")
					print("sekarang "..composer.provinsi)
					status_back = 0
					background_hitam.alpha = 0
					scrollView:setIsLocked( false )
					label_provinsi.text = teks1.text
					label_kabupaten.text = "Pilih Kabupaten"
					label_kecamatan.text = "Ketik Kecamatan Disini"
					scrollViewProvinsi:removeSelf()
					scrollViewProvinsi = nil
					
					local function delay()
					addall()
					end
					timer.performWithDelay(500, delay)
				end
				teks1:addEventListener("tap", on_teks1)
			end
		end


		local function dataResponseListener( event )


          if ( event.isError ) then
            -- TODO Show error here
              print( "Network error!" )
              --loadIconListener()

          else

            listData_provinsi = json.decode( event.response )
            print(event.response)
            -- yang ini nerima data json dari server, gampangna mah data dari server d masukin ke array.
            --listData = listData.content;

            data_max_provinsi = table.getn(listData_provinsi);

            composer.data_max = data_max
            --print("deskripsi sebenarnya = "..listData2.deskripsi)
            insert_data()

           end
        end


		dl_id1 = network.request( "http://api.bursasajadah.com/api/bursasajadah/provinsi", "GET", dataResponseListener )
	end
	label_provinsi:addEventListener("tap", on_label_provinsi)

	local options = {
						 text = "Pilih Kabupaten",
	                     x = 0 + 0.05 * display.contentWidth,
	                     y = garis5.y + display.contentHeight/15,
	                     font = used_font_bold,
	                     fontSize = 13  * (display.contentWidth / 320),
	                     align = "left",
	                     width = (0.9 * display.contentWidth)
                 	 }


 	 label_kabupaten = display.newText(options)
     label_kabupaten.anchorX = 0
     label_kabupaten.anchorY = 0
     label_kabupaten:setFillColor(0);
     scrollView:insert(label_kabupaten);

    local garis6 = display.newLine( 0 + 0.05 * display.contentWidth, label_kabupaten.y + label_kabupaten.height + 3, display.contentWidth - display.contentWidth*0.05, label_kabupaten.y + label_kabupaten.height + 3)
	garis6:setStrokeColor( 133/255,190/255,72/255)
	garis6.strokeWidth = 1
	scrollView:insert(garis6)



	local function on_label_kabupaten()
		-- body

		hide_all()
		removeall()
		status_back = 1
		

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

		composer.showOverlay("overlay_loading", options_overlay)


		--scrollViewWarna.alpha = 1
		background_hitam.alpha = 0.5
		scrollView:setIsLocked( true )
		--end

		scrollViewkabupaten = widget.newScrollView(
		    {
		        top = background_hitam.y + display.contentHeight/20,
		        left = 0 + display.contentWidth * 0.05,
		        width = display.contentWidth - display.contentWidth * 0.1,
		        height = background_hitam.height - 2 * (display.contentHeight/20),
		        horizontalScrollDisabled = true,
		        verticalScrollDisabled = false,
		        backgroundColor = {0.99},
		        isBounceEnabled = false,
		        --scrollWidth = 600,
		        --scrollHeight = 2000,
		        listener = scrollListener

		    }
		)
		sceneGroup:insert(background_hitam)
		sceneGroup:insert(scrollViewkabupaten)
		scrollViewkabupaten.alpha = 1


		local function insert_data()
			local index
			composer.hideOverlay("fade", 100)
			local posisi_kabupaten = 20
			for index = 1,data_max_kabupaten do
				local data = listData_kabupaten[index]

				
				local teks1 = display.newText( data.kota, 10 , posisi_kabupaten, used_font_bold, 15  * (display.contentWidth / 320))
				teks1.anchorX = 0
				teks1.anchorY = 0.5
				teks1:setFillColor( 0 )
				scrollViewkabupaten:insert(teks1)

				local line = display.newLine( 0, teks1.y + teks1.height, display.contentWidth, teks1.y + teks1.height )
				line:setStrokeColor( 0.85)
				line.strokeWidth = 1
				scrollViewkabupaten:insert(line)

				posisi_kabupaten = posisi_kabupaten + teks1.height + display.contentWidth/20

				local function on_teks1()
					composer.kabupaten = teks1.text
					composer.kabupaten = composer.kabupaten:gsub( " ", "%%20")
					status_back = 0
					background_hitam.alpha = 0
					scrollView:setIsLocked( false )
					label_kabupaten.text = teks1.text
					label_kecamatan.text = "Ketik Kecamatan Disini"
					scrollViewkabupaten:removeSelf()
					scrollViewkabupaten = nil
					
					local function delay()
					addall()
					end
					timer.performWithDelay(500, delay)
				end
				teks1:addEventListener("tap", on_teks1)
			end
		end


		local function dataResponseListener( event )


          if ( event.isError ) then
            -- TODO Show error here
              print( "Network error!" )
              --loadIconListener()

          else

            listData_kabupaten = json.decode( event.response )
            print(event.response)
            -- yang ini nerima data json dari server, gampangna mah data dari server d masukin ke array.
            --listData = listData.content;

            data_max_kabupaten = table.getn(listData_kabupaten);

            composer.data_max = data_max
            --print("deskripsi sebenarnya = "..listData2.deskripsi)
            insert_data()

           end
        end


		dl_id1 = network.request( "http://api.bursasajadah.com/api/bursasajadah/kota?provinsi="..composer.provinsi, "GET", dataResponseListener )
	end
	label_kabupaten:addEventListener("tap", on_label_kabupaten)





	local options = {
						 text = "Ketik Kecamatan Disini",
	                     x = 0 + 0.05 * display.contentWidth,
	                     y = garis6.y + display.contentHeight/15,
	                     font = used_font_bold,
	                     fontSize = 13  * (display.contentWidth / 320),
	                     align = "left",
	                     width = (0.9 * display.contentWidth)
                 	 }


 	 label_kecamatan = display.newText(options)
     label_kecamatan.anchorX = 0
     label_kecamatan.anchorY = 0
     label_kecamatan:setFillColor(0);
     scrollView:insert(label_kecamatan);

    local garis7 = display.newLine( 0 + 0.05 * display.contentWidth, label_kecamatan.y + label_kecamatan.height + 3, display.contentWidth - display.contentWidth*0.05, label_kecamatan.y + label_kecamatan.height + 3)
	garis7:setStrokeColor( 133/255,190/255,72/255)
	garis7.strokeWidth = 1
	scrollView:insert(garis7)


	local function on_label_kecamatan()
		-- body
		hide_all()
		--removeall()
		status_back = 1
		
		teksfield_kecamatan = native.newTextField(0 + 0.05 * display.contentWidth, garis7.y -2, display.contentWidth*0.8, display.contentHeight/20)
		teksfield_kecamatan.anchorX = 0
		teksfield_kecamatan.anchorY = 1
		--teksfield_kecamatan.inputType = "number"
		teksfield_kecamatan.hasBackground = true
		--teksfield_kecamatan.placeholder = "kecamatan"
		scrollView:insert( teksfield_kecamatan )
		native.setKeyboardFocus(teksfield_kecamatan)

		local function fieldHandler_t(event) 
               if ("began" == event.phase) then 

               	label_kecamatan.text = teksfield_kecamatan.text
                  if name ~= nil then
                    --name:removeSelf()
                    --name = nil
                  end
               elseif ("ended" == event.phase) then 
                  label_kecamatan.text = teksfield_kecamatan.text
                  status_back = 0
                  composer.kecamatan = teksfield_kecamatan.text
                  if(teksfield_kecamatan.text ~= nil and teksfield_kecamatan.text ~= "")then
                  	  print("ended")
	                  --on_search_kecamatan()
	              end
                  if(teksfield_kecamatan~=nil)then
	                  teksfield_kecamatan:removeSelf()
	                  teksfield_kecamatan = nil 
              	  end



               elseif ("submitted" == event.phase) then  
               	  label_kecamatan.text = teksfield_kecamatan.text
                  composer.kecamatan = teksfield_kecamatan.text
                  if(teksfield_kecamatan.text ~= nil and teksfield_kecamatan.text ~= "")then
                  		print("submit")
	                  on_search_kecamatan()
	              end
                  native.setKeyboardFocus(nil)
                  if(teksfield_kecamatan~=nil)then
	                  teksfield_kecamatan:removeSelf()
	                  teksfield_kecamatan = nil 
              	  end


                elseif ( event.phase == "editing" ) then
                  	
                  label_kecamatan.text = teksfield_kecamatan.text


                  

                end  
         end 
        
		
        teksfield_kecamatan:addEventListener( "userInput", fieldHandler_t ) 
		--scrollViewWarna.alpha = 1

	end

	function on_search_kecamatan()
		
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

		composer.showOverlay("overlay_loading", options_overlay)


		local function insert_data()

			composer.hideOverlay("fade", 100)

			--print("data max adalah : "..data_max_kecamatan)
			if(data_max_kecamatan>0)then

				background_hitam.alpha = 0.5
				scrollView:setIsLocked( true )
				--end

				hide_all()
				removeall()
				status_back = 1

				scrollViewkecamatan = widget.newScrollView(
				    {
				        top = background_hitam.y + display.contentHeight/20,
				        left = 0 + display.contentWidth * 0.05,
				        width = display.contentWidth - display.contentWidth * 0.1,
				        height = background_hitam.height - 2 * (display.contentHeight/20),
				        horizontalScrollDisabled = true,
				        verticalScrollDisabled = false,
				        backgroundColor = {0.99},
				        isBounceEnabled = false,
				        --scrollWidth = 600,
				        --scrollHeight = 2000,
				        listener = scrollListener

				    }
				)
				sceneGroup:insert(background_hitam)
				sceneGroup:insert(scrollViewkecamatan)
				scrollViewkecamatan.alpha = 1

				local index
				hide_all()

				local posisi_kecamatan = 20
				for index = 1,data_max_kecamatan do
					local data = listData_kecamatan[index]

					local kode_kecamatan = data.code
					
					local teks1 = display.newText( data.label, 10 , posisi_kecamatan, used_font_bold, 15  * (display.contentWidth / 320))
					teks1.anchorX = 0
					teks1.anchorY = 0.5
					teks1:setFillColor( 0 )
					scrollViewkecamatan:insert(teks1)

					local line = display.newLine( 0, teks1.y + teks1.height, display.contentWidth, teks1.y + teks1.height )
					line:setStrokeColor( 0.85)
					line.strokeWidth = 1
					scrollViewkecamatan:insert(line)

					posisi_kecamatan = posisi_kecamatan + teks1.height + display.contentWidth/20

					local function on_teks1()
						status_kecamatan = 1
						composer.kecamatan = teks1.text
						composer.kode_kecamatan = kode_kecamatan
						composer.kecamatan = composer.kecamatan:gsub( " ", "%%20")
						status_back = 0
						background_hitam.alpha = 0
						scrollView:setIsLocked( false )
						label_kecamatan.text = teks1.text
						scrollViewkecamatan:removeSelf()
						scrollViewkecamatan = nil

						print("kode yang dilempar adalah : "..composer.kode_kecamatan)
						local function delay()
						addall()
						end
						timer.performWithDelay(500, delay)
					end
					teks1:addEventListener("tap", on_teks1)
				end
			else
				local alert = native.showAlert( "Error", "Kecamatan tidak ditemukan", { "OK"})
			end
		end


		local function dataResponseListener( event )


          if ( event.isError ) then
            -- TODO Show error here
              print( "Network error!" )
              --loadIconListener()


              local alert = native.showAlert( "Error", "Koneksi terganggu, coba beberapa saat lagi", { "OK"})
    		  composer.hideOverlay("fade", 100)

          else
          	
            listData = json.decode( event.response )
	            print(event.response)

            if(listData.status == nil)then
	            listData_kecamatan = listData.detail
	            -- yang ini nerima data json dari server, gampangna mah data dari server d masukin ke array.
	            --listData = listData.content;

	            data_max_kecamatan = table.getn(listData_kecamatan);

	            composer.data_max = data_max



	            if(listData.status == false)then
	    --         	status_back = 0
					-- background_hitam.alpha = 0
					-- scrollView:setIsLocked( false )
					-- scrollViewkecamatan:removeSelf()
					-- scrollViewkecamatan = nil
	            else
	            --print("deskripsi sebenarnya = "..listData2.deskripsi)
	            insert_data()
        		end
        	else
            	local alert = native.showAlert( "Error", "Kecamatan tidak ditemukan", { "OK"})
    			composer.hideOverlay("fade", 100)
            end
        	end
        end



            local headers = {
			}

			headers["Content-Type"] = "application/json"
			headers["X-API-Key"] = "13b6ac91a2"

			local lempar = {["kecamatan"] = label_kecamatan.text}

			local params = {}
			params.headers = headers
			params.body = json.encode( lempar)

            

            print("params.body : "..params.body)

		--dl_id1 = network.request( "http://api.bursasajadah.com/api/bursasajadah/kecamatan?kota="..composer.kabupaten, "GET", dataResponseListener )
		
			dl_id1 = network.request( "http://api.bursasajadah.com/api/bursasajadah/kode_kecamatan", "POST", dataResponseListener, params )
		
	end
	label_kecamatan:addEventListener("tap", on_label_kecamatan)



	--[[local back_search_kecamatan = display.newRect( display.contentWidth - 0.05 * display.contentWidth , garis7.y, 0.1 * display.contentWidth, 40 )
	back_search_kecamatan.strokeWidth = 0
	back_search_kecamatan.anchorX = 1
	back_search_kecamatan.anchorY = 1
	back_search_kecamatan:setFillColor( 244/255,209/255,66/255 )
	back_search_kecamatan:setStrokeColor( 1, 0, 0 )
	scrollView:insert(back_search_kecamatan)

	back_search_kecamatan:addEventListener("tap", on_search_kecamatan)--]]


	--[[local search_kecamatan = display.newImageRect( composer.imgDir.. "search.png", 1260, 916 ); 
	search_kecamatan.x = back_search_kecamatan.x - back_search_kecamatan.width / 2;
	search_kecamatan.y = back_search_kecamatan.y - back_search_kecamatan.height / 2;
	search_kecamatan.anchorY = 0.5
	--search_kecamatan:scale(0.5,0.5)
	search_kecamatan.xScale = (0.9 * back_search_kecamatan.height) / search_kecamatan.width 
	search_kecamatan.yScale = (0.9 * back_search_kecamatan.height) / search_kecamatan.width 
	scrollView:insert(search_kecamatan)--]]



	local options = {
						 text = "Kode Pos",
	                     x = 0 + 0.05 * display.contentWidth,
	                     y = garis7.y + display.contentHeight/15,
	                     font = used_font_bold,
	                     fontSize = 13  * (display.contentWidth / 320),
	                     align = "left",
	                     width = (0.9 * display.contentWidth)
                 	 }


 	 label_kode_pos = display.newText(options)
     label_kode_pos.anchorX = 0
     label_kode_pos.anchorY = 0
     label_kode_pos:setFillColor(0);
     scrollView:insert(label_kode_pos);

    local garis8 = display.newLine( 0 + 0.05 * display.contentWidth, label_kode_pos.y + label_kode_pos.height + 3, display.contentWidth - display.contentWidth*0.05, label_kode_pos.y + label_kode_pos.height + 3)
	garis8:setStrokeColor( 133/255,190/255,72/255)
	garis8.strokeWidth = 1
	scrollView:insert(garis8)

	


	local function on_label_kode_pos()
		hide_all()
		status_back = 1
		teksfield_kode_pos = native.newTextField(display.contentCenterX, garis8.y -2, display.contentWidth*0.9, display.contentHeight/20)
		teksfield_kode_pos.anchorX = 0.5
		teksfield_kode_pos.anchorY = 1
		teksfield_kode_pos.inputType = "number"
		teksfield_kode_pos.hasBackground = true
		--teksfield_kode_pos.placeholder = "kode_pos"
		scrollView:insert( teksfield_kode_pos )
		native.setKeyboardFocus(teksfield_kode_pos)

		local function fieldHandler_t(event) 
               if ("began" == event.phase) then 

               	label_kode_pos.text = teksfield_kode_pos.text
                  if name ~= nil then
                    --name:removeSelf()
                    --name = nil
                  end
               elseif ("ended" == event.phase) then 
                  label_kode_pos.text = teksfield_kode_pos.text
                  status_back = 0
                  teksfield_kode_pos:removeSelf()
                  teksfield_kode_pos = nil

               elseif ("submitted" == event.phase) then  
               	  label_kode_pos.text = teksfield_kode_pos.text
                  composer.search = teksfield.text
                  native.setKeyboardFocus(nil) 
                elseif ( event.phase == "editing" ) then
                  	
                  label_kode_pos.text = teksfield_kode_pos.text


                end  
         end 
        
		
        teksfield_kode_pos:addEventListener( "userInput", fieldHandler_t ) 

	end
	label_kode_pos:addEventListener("tap", on_label_kode_pos)




	function removeall()
		label_nama:removeEventListener("tap", on_label_nama)
		label_email:removeEventListener("tap", on_label_email)
		label_telepon:removeEventListener("tap", on_label_telepon)
		label_alamat:removeEventListener("tap", on_label_alamat)
		label_provinsi:removeEventListener("tap", on_label_provinsi)
		label_kabupaten:removeEventListener("tap", on_label_kabupaten)
		label_kecamatan:removeEventListener("tap", on_label_kecamatan)
		label_kode_pos:removeEventListener("tap", on_label_kode_pos)
	end

	function addall()
		label_nama:addEventListener("tap", on_label_nama)
		label_email:addEventListener("tap", on_label_email)
		label_telepon:addEventListener("tap", on_label_telepon)
		label_alamat:addEventListener("tap", on_label_alamat)
		label_provinsi:addEventListener("tap", on_label_provinsi)
		label_kabupaten:addEventListener("tap", on_label_kabupaten)
		label_kecamatan:addEventListener("tap", on_label_kecamatan)
		label_kode_pos:addEventListener("tap", on_label_kode_pos)
	end

	local function onCheckout()


		


		if(label_nama.text == "Nama Lengkap" or label_nama.text == "")then
			local alert = native.showAlert( "Data Belum lengkap", "Kolom nama belum dimasukan", { "OK"})
		elseif(label_email.text == "Email" or label_email.text == "")then
			local alert = native.showAlert( "Data Belum lengkap", "Kolom email belum dimasukan", { "OK"})
		elseif(label_telepon.text == "Telepon"  or label_telepon.text == "")then
			local alert = native.showAlert( "Data Belum lengkap", "Kolom telepon belum dimasukan", { "OK"})
		elseif(label_alamat.text == "Alamat"  or label_alamat.text == "")then
			local alert = native.showAlert( "Data Belum lengkap", "Kolom alamat belum dimasukan", { "OK"})
		elseif(label_provinsi.text == "Pilih Provinsi"  or label_provinsi.text == "")then
			local alert = native.showAlert( "Data Belum lengkap", "Kolom provinsi belum dipilih", { "OK"})
		elseif(label_kabupaten.text == "Pilih Kabupaten"  or label_kabupaten.text == "")then
			local alert = native.showAlert( "Data Belum lengkap", "Kolom kabupaten belum dipilih", { "OK"})
		elseif(label_kecamatan.text == "Ketik Kecamatan Disini"  or label_kecamatan.text == "")then
			local alert = native.showAlert( "Data Belum lengkap", "Kolom kecamatan belum dipilih", { "OK"})
		elseif(status_kecamatan == 0)then
			local alert = native.showAlert( "Data Belum lengkap", "Klik tombol cari kecamatan", { "OK"})
		else

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

		composer.showOverlay("overlay_loading", options_overlay)


		if(label_kode_pos.text == "Kode Pos")then
			label_kode_pos.text = ""
		end


		local berat = 0
		for row in db:nrows("select sum(weight*qty)as total from t_produk_cart limit 1") do
			berat = math.ceil(row.total)
		end

		local tablesetup = [[INSERT INTO t_checkout1 VALUES(NULL, ']]..label_alamat.text..[[', ']]..label_telepon.text..[[',']]..label_nama.text..[[',']]..label_email.text..[[',']]..label_provinsi.text..[[',']]..label_kabupaten.text..[[',']]..label_kecamatan.text..[[',']]..label_kode_pos.text..[[','', ']]..berat..[[');]]
		db:exec(tablesetup)

		composer.gotoScene("test_checkout2")

		end
	end

	local background_checkout = display.newRoundedRect( display.contentCenterX, garis8.y + display.contentHeight/10, display.contentWidth * 0.9, 50, 5)
	background_checkout.anchorY = 0.5
	background_checkout.anchorX = 0.5
	background_checkout:setFillColor( 133/255,190/255,72/255)
	scrollView:insert(background_checkout)

	local teks_email = display.newText( "SELANJUTNYA", background_checkout.x, background_checkout.y , used_font_bold, 12  * (display.contentWidth / 320))
	teks_email.anchorX = 0.5
	teks_email:setFillColor(1)
	scrollView:insert(teks_email)

	background_checkout:addEventListener("tap", onCheckout)
	--======================================================FOOTER======================================================--




	local footer_background = display.newRect( display.contentCenterX, background_checkout.y + display.contentHeight/4, display.contentWidth, display.contentHeight/7)
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

	
	
local function to_cart()
	if nil~= composer.getScene("test_cart") then composer.removeScene("test_cart", true) end  
	composer.gotoScene("test_cart")
end

	function getData()

		local data = listData[1]


		if(data.first_name ~= nil)then
       	label_nama.text = data.first_name
       	end
       	if(data.email ~= nil)then	
       	label_email.text = data.email
        end
        if(data.phone ~= nil)then
       	label_telepon.text = data.phone
       	end	
       	if(data.alamat~=nil)then
       	label_alamat.text = data.alamat
       	end	
       	if(data.provinsi~=nil)then
       	composer.provinsi = data.provinsi:gsub( " ", "%%20")
       	label_provinsi.text = data.provinsi
       	end
       	if(data.kota~=nil)then
       	composer.kabupaten = data.kota:gsub( " ", "%%20")
       	label_kabupaten.text = data.kota
       	end
       	if(data.kode_pos~=nil)then
       		label_kode_pos.text = data.kode_pos
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
	--================================================================================================================================



	dl_iddata = network.request("http://api.bursasajadah.com/api/bursasajadah/PQp8xrFkrBz3byU/"..user_id , get , dataResponse)










	-- all objects must be added to group (e.g. self.view)
	sceneGroup:insert( background )
	sceneGroup:insert( background2 )
	sceneGroup:insert(logo)
	sceneGroup:insert( menu )
	sceneGroup:insert( lingkaran_profile )
	
	sceneGroup:insert( scrollView )
	


	sceneGroup:insert(myRectangle1)
	sceneGroup:insert(teks_search)


	sceneGroup:insert(grup_menu)
	grup_menu.alpha = 0

	
end

function scene:show( event )
	
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then

	
	
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then

		composer.removeHidden()
       	
	-- local function loading()
 --       	local options_overlay =
	-- 	{
	-- 	    isModal = true,
	-- 	    effect = "fade",
	-- 	    time = 100,
	-- 	    params = {
	-- 	        sampleVar1 = "my sample variable",
	-- 	        sampleVar2 = "another sample variable"
	-- 	    }
	-- 	}

	-- composer.showOverlay("overlay_loading", options_overlay)

	-- end
	-- timer.performWithDelay(10, loading)


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
	                  	 
		                  began = began + 1
	                  	  

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
                    cancelbanner[index] = network.download( download, "GET", networkListener,params, "banner"..index..".jpg", system.TemporaryDirectory, 0, 0 )

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
			if(teksfield_telepon ~= nil)then
				print("email adaan")
				teksfield_telepon:removeSelf()
				teksfield_telepon = nil
			end
			if(teksfield_alamat ~= nil)then
				print("email adaan")
				teksfield_alamat:removeSelf()
				teksfield_alamat = nil
			end
			if(teksfield_kode_pos ~= nil)then
				print("email adaan")
				teksfield_kode_pos:removeSelf()
				teksfield_kode_pos = nil
			end
			

	      for i = 1 , 10 do
            
           
            network.cancel( cancelbanner[i])
           
          end

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