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
cur_page = "checkout3"

status_back = 0

local teks_search
local grup_menu = display.newGroup()


local total_harga = 0

local field_nama = ""
local field_email = ""
local field_telepon = ""
local field_alamat = ""
local field_provinsi = ""
local field_kabupaten = ""
local field_kecamatan = ""
local field_kodepos = ""
local field_ekspedisi = ""
local field_berat = ""
local field_ongkos = ""


require "sqlite3"

local datab = "data.db"
local path = system.pathForFile(datab, system.DocumentsDirectory)
db = sqlite3.open( path )


 
for row in db:nrows("SELECT * FROM t_checkout1") do
	--print("hasilnya "..row.kecamatan)
	 field_nama = row.nama
	 field_email = row.email
	 field_telepon = row.no_telp
	 field_alamat = row.alamat
	 field_provinsi = row.provinsi
	 field_kabupaten = row.kabupaten
	 field_kecamatan = row.kecamatan
	 field_kodepos = row.kodepos

end

for row in db:nrows("SELECT * FROM t_checkout2") do
	field_ekspedisi = row.service
	field_berat = row.berat
	field_ongkos = row.ongkos
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

	


	
	


	

		
	--composer.tinggi_teksfield = logo.y + logo.height + display.contentHeight / 100 
	--composer.tinggi_teksfield = scrollView2.y - scrollView2.height

	--local function hideover()

    --composer.hideOverlay("fade", 100)
    

	  local function createteksfield()

    	

    	teksfield = native.newTextField(  display.contentWidth/20 , composer.tinggi_teksfield , 0.9 * display.contentWidth, 30 )
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
		

    --composer.tinggi_teksfield = background2.height + display.contentHeight/30
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

	
	local teks_diskon = display.newText( "Invoice Pembayaran", display.contentCenterX, display.contentHeight/20, used_font, 15  * (display.contentWidth / 320))
	teks_diskon.anchorX = 0.5
	teks_diskon:setFillColor(0)
	scrollView:insert(teks_diskon)
	composer.tinggi_line2 = teks_diskon.y

	local line2 = display.newLine( 0 + 0.05 * display.contentWidth, teks_diskon.y + display.contentHeight/40, display.contentWidth - display.contentWidth*0.05, teks_diskon.y + display.contentHeight/40 )
	line2:setStrokeColor( 133/255,190/255,72/255)
	line2.strokeWidth = 2
	scrollView:insert(line2)
	composer.tinggi_line2 = line2.y

	local options = {
		 text = "No Order : ",
         x = 0 + 0.05 * display.contentWidth,
         y =  line2.y + display.contentHeight/20,
         font = used_font,
         fontSize = 13  * (display.contentWidth / 320),
         align = "left",
         --width = (0.9 * display.contentWidth)
 	 }


 	local  label_invoice = display.newText(options)
     label_invoice.anchorX = 0
     label_invoice.anchorY = 0
     label_invoice:setFillColor(0);
     scrollView:insert(label_invoice);


     local options = {
		 text = composer.nomor_invoice,
         x = label_invoice.x + label_invoice.width + 5,
         y =  line2.y + display.contentHeight/20,
         font = used_font,
         fontSize = 13  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	 local  label_no_invoice = display.newText(options)
     label_no_invoice.anchorX = 0
     label_no_invoice.anchorY = 0
     label_no_invoice:setFillColor(0);
     scrollView:insert(label_no_invoice);



     local options = {
		 text = "Tanggal Pemesanan : ",
         x = 0 + 0.05 * display.contentWidth,
         y =  label_invoice.y + display.contentHeight/20,
         font = used_font,
         fontSize = 13  * (display.contentWidth / 320),
         align = "left",
        -- width = (0.9 * display.contentWidth)
 	 }


 	local  label_tanggal = display.newText(options)
     label_tanggal.anchorX = 0
     label_tanggal.anchorY = 0
     label_tanggal:setFillColor(0);
     scrollView:insert(label_tanggal);


      local options = {
		 text = composer.tanggal,
         x = label_tanggal.x + label_tanggal.width + 5,
         y =  label_invoice.y + display.contentHeight/20,
         font = used_font,
         fontSize = 13  * (display.contentWidth / 320),
         align = "left",
        -- width = (0.9 * display.contentWidth)
 	 }


 	local  label_date = display.newText(options)
     label_date.anchorX = 0
     label_date.anchorY = 0
     label_date:setFillColor(0);
     scrollView:insert(label_date);


      local options = {
		 text = "Barang Yang Dipesan",
         x = 0 + 0.05 * display.contentWidth,
         y =  label_tanggal.y + display.contentHeight/20,
         font = used_font,
         fontSize = 13  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	local  label_barang = display.newText(options)
     label_barang.anchorX = 0
     label_barang.anchorY = 0
     label_barang:setFillColor(0);
     scrollView:insert(label_barang);

    local y = label_barang.y + display.contentHeight/20

    for row in db:nrows("SELECT * FROM t_produk_cart") do
		
		 local options = {
		 text = row.nama_produk,
         x = 0 + 0.1 * display.contentWidth,
         y =  y,
         font = used_font_bold,
         fontSize = 11  * (display.contentWidth / 320),
         align = "left",
         --width = (0.9 * display.contentWidth)
	 	 }


	 	local  label_nama_barang = display.newText(options)
	     label_nama_barang.anchorX = 0
	     label_nama_barang.anchorY = 0
	     label_nama_barang:setFillColor(0);
	     scrollView:insert(label_nama_barang);



	     local options = {
		 text = "| "..row.qty.."pcs",
         x = label_nama_barang.x + label_nama_barang.width + 5,
         y =  y,
         font = used_font_bold,
         fontSize = 11  * (display.contentWidth / 320),
         align = "left",
         --width = (0.9 * display.contentWidth)
	 	 }


	 	local  label_jumlah_barang = display.newText(options)
	     label_jumlah_barang.anchorX = 0
	     label_jumlah_barang.anchorY = 0
	     label_jumlah_barang:setFillColor(0);
	     scrollView:insert(label_jumlah_barang);


	     local options = {
		 text = "( "..row.qty*row.price.." )",
         x = label_jumlah_barang.x + label_jumlah_barang.width + 5,
         y =  y,
         font = used_font_bold,
         fontSize = 11  * (display.contentWidth / 320),
         align = "left",
         --width = (0.9 * display.contentWidth)
	 	 }

	 	total_harga = total_harga + row.qty*row.price

	 	local  label_harga_barang = display.newText(options)
	     label_harga_barang.anchorX = 0
	     label_harga_barang.anchorY = 0
	     label_harga_barang:setFillColor(0);
	     scrollView:insert(label_harga_barang);


	     y = label_nama_barang.y + display.contentHeight/20
	end


       local options = {
		 text = "Alamat Tujuan",
         x = 0 + 0.05 * display.contentWidth,
         y =  y,
         font = used_font,
         fontSize = 13  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	local  label_alamat_tujuan = display.newText(options)
     label_alamat_tujuan.anchorX = 0
     label_alamat_tujuan.anchorY = 0
     label_alamat_tujuan:setFillColor(0);
     scrollView:insert(label_alamat_tujuan);


     local options = {
		 text = "Nama Lengkap : "..field_nama,
         x = 0.1 * display.contentWidth,
         y =  label_alamat_tujuan.y + display.contentHeight/20,
         font = used_font_bold,
         fontSize = 11  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	local  label_nama_lengkap = display.newText(options)
     label_nama_lengkap.anchorX = 0
     label_nama_lengkap.anchorY = 0
     label_nama_lengkap:setFillColor(0);
     scrollView:insert(label_nama_lengkap);


     local options = {
		 text = "Email : "..field_email,
         x = 0.1 * display.contentWidth,
         y =  label_nama_lengkap.y + display.contentHeight/20,
         font = used_font_bold,
         fontSize = 11  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	local  label_email = display.newText(options)
     label_email.anchorX = 0
     label_email.anchorY = 0
     label_email:setFillColor(0);
     scrollView:insert(label_email);



     local options = {
		 text = "Nomor Handphone : "..field_telepon,
         x = 0.1 * display.contentWidth,
         y =  label_email.y + display.contentHeight/20,
         font = used_font_bold,
         fontSize = 11  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	local  label_telepon = display.newText(options)
     label_telepon.anchorX = 0
     label_telepon.anchorY = 0
     label_telepon:setFillColor(0);
     scrollView:insert(label_telepon);


     local options = {
		 text = "Alamat : "..field_alamat,
         x = 0.1 * display.contentWidth,
         y =  label_telepon.y + display.contentHeight/20,
         font = used_font_bold,
         fontSize = 11  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	local  label_alamat = display.newText(options)
     label_alamat.anchorX = 0
     label_alamat.anchorY = 0
     label_alamat:setFillColor(0);
     scrollView:insert(label_alamat);

     local options = {
		 text = "Provinsi : "..field_provinsi,
         x = 0.1 * display.contentWidth,
         y =  label_alamat.y + display.contentHeight/20,
         font = used_font_bold,
         fontSize = 11  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	local  label_provinsi = display.newText(options)
     label_provinsi.anchorX = 0
     label_provinsi.anchorY = 0
     label_provinsi:setFillColor(0);
     scrollView:insert(label_provinsi);


      local options = {
		 text = "Kota : "..field_kabupaten,
         x = 0.1 * display.contentWidth,
         y =  label_provinsi.y + display.contentHeight/20,
         font = used_font_bold,
         fontSize = 11  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	local  label_kabupaten = display.newText(options)
     label_kabupaten.anchorX = 0
     label_kabupaten.anchorY = 0
     label_kabupaten:setFillColor(0);
     scrollView:insert(label_kabupaten);


      local options = {
		 text = "Kecamatan : "..field_kecamatan,
         x = 0.1 * display.contentWidth,
         y =  label_kabupaten.y + display.contentHeight/20,
         font = used_font_bold,
         fontSize = 11  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	local  label_kecamatan = display.newText(options)
     label_kecamatan.anchorX = 0
     label_kecamatan.anchorY = 0
     label_kecamatan:setFillColor(0);
     scrollView:insert(label_kecamatan);


        local options = {
		 text = "Kode Pos : "..field_kodepos,
         x = 0.1 * display.contentWidth,
         y =  label_kecamatan.y + display.contentHeight/20,
         font = used_font_bold,
         fontSize = 11  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	local  label_kodepos = display.newText(options)
     label_kodepos.anchorX = 0
     label_kodepos.anchorY = 0
     label_kodepos:setFillColor(0);
     scrollView:insert(label_kodepos);


     local options = {
		 text = "Ekspedisi / Jasa Pengiriman ",
         x = 0.05 * display.contentWidth,
         y =  label_kodepos.y + display.contentHeight/20,
         font = used_font_bold,
         fontSize = 13  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	local  label_expedisi = display.newText(options)
     label_expedisi.anchorX = 0
     label_expedisi.anchorY = 0
     label_expedisi:setFillColor(0);
     scrollView:insert(label_expedisi);


     local options = {
		 text = "JNE "..field_ekspedisi,
         x = 0.1 * display.contentWidth,
         y =  label_expedisi.y + display.contentHeight/20,
         font = used_font_bold,
         fontSize = 11  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	local  label_service = display.newText(options)
     label_service.anchorX = 0
     label_service.anchorY = 0
     label_service:setFillColor(0);
     scrollView:insert(label_service);


      local options = {
		 text = "Berat Pengiriman : "..field_berat.." Kg",
         x = 0.1 * display.contentWidth,
         y =  label_service.y + display.contentHeight/20,
         font = used_font_bold,
         fontSize = 11  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	local  label_berat = display.newText(options)
     label_berat.anchorX = 0
     label_berat.anchorY = 0
     label_berat:setFillColor(0);
     scrollView:insert(label_berat);


     local options = {
		 text = "Ongkos Pengiriman : Rp."..field_ongkos,
         x = 0.1 * display.contentWidth,
         y =  label_berat.y + display.contentHeight/20,
         font = used_font_bold,
         fontSize = 11  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	local  label_ongkos = display.newText(options)
     label_ongkos.anchorX = 0
     label_ongkos.anchorY = 0
     label_ongkos:setFillColor(0);
     scrollView:insert(label_ongkos);




      local options = {
		 text = "Total yang harus dibayar",
         x = 0.05 * display.contentWidth,
         y =  label_ongkos.y + display.contentHeight/10,
         font = used_font_bold,
         fontSize = 13  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	local  label_yang_harus_dibayar = display.newText(options)
     label_yang_harus_dibayar.anchorX = 0
     label_yang_harus_dibayar.anchorY = 0
     label_yang_harus_dibayar:setFillColor(0);
     scrollView:insert(label_yang_harus_dibayar);



    local background_total = display.newRect( display.contentCenterX, label_yang_harus_dibayar.y + display.contentHeight/20, 0.9 * display.contentWidth, 50)
	background_total.anchorY = 0
	background_total:setFillColor( 133/255,190/255,72/255)
	scrollView:insert(background_total)


	local options = {
		 text = "Rp."..total_harga + field_ongkos,
         x = background_total.x - background_total.width/2 + 10,
         y =  background_total.y + background_total.height/2,
         font = used_font_bold,
         fontSize = 13  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	local  label_yang_harus_dibayar = display.newText(options)
     label_yang_harus_dibayar.anchorX = 0
     label_yang_harus_dibayar.anchorY = 0.5
     label_yang_harus_dibayar:setFillColor(1);
     scrollView:insert(label_yang_harus_dibayar);
     


     local options = {
		 text = "Untuk menyelesaikan pemesanan, silakan lakukan pembayaran kepada salah satu rekening dibawah ini,",
         x = 0.05 * display.contentWidth,
         y =  background_total.y + display.contentHeight/10,
         font = used_font_bold,
         fontSize = 13  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	local  label_teks1 = display.newText(options)
     label_teks1.anchorX = 0
     label_teks1.anchorY = 0
     label_teks1:setFillColor(0);
     scrollView:insert(label_teks1);


      local options = {
		 text = "Bank MANDIRI",
         x = 0.05 * display.contentWidth,
         y =  label_teks1.y + display.contentHeight/8,
         font = used_font_bold,
         fontSize = 13  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	local  label_teks2 = display.newText(options)
     label_teks2.anchorX = 0
     label_teks2.anchorY = 0
     label_teks2:setFillColor(0);
     scrollView:insert(label_teks2);


     local options = {
		 text = [[Nomor Rekening : 130.0031.300.315
Atas Nama : PT. Aarti Jaya
Cabang : Bina Citra]],
         x = 0.05 * display.contentWidth,
         y =  label_teks2.y + display.contentHeight/20,
         font = used_font_bold,
         fontSize = 13  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	local  label_teks3 = display.newText(options)
     label_teks3.anchorX = 0
     label_teks3.anchorY = 0
     label_teks3:setFillColor(0);
     scrollView:insert(label_teks3);



     local options = {
		 text = "Bank BCA",
         x = 0.05 * display.contentWidth,
         y =  label_teks3.y + display.contentHeight/8,
         font = used_font_bold,
         fontSize = 13  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	local  label_teks4 = display.newText(options)
     label_teks4.anchorX = 0
     label_teks4.anchorY = 0
     label_teks4:setFillColor(0);
     scrollView:insert(label_teks4);


     local options = {
		 text = [[Nomor Rekening : 008-9500-666
Atas Nama : PT. Aarti Jaya
Cabang : Bandung]],
         x = 0.05 * display.contentWidth,
         y =  label_teks4.y + display.contentHeight/20,
         font = used_font_bold,
         fontSize = 13  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	local  label_teks5 = display.newText(options)
     label_teks5.anchorX = 0
     label_teks5.anchorY = 0
     label_teks5:setFillColor(0);
     scrollView:insert(label_teks5);


     local options = {
		 text = "Bank BNI",
         x = 0.05 * display.contentWidth,
         y =  label_teks5.y + display.contentHeight/8,
         font = used_font_bold,
         fontSize = 13  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	local  label_teks6 = display.newText(options)
     label_teks6.anchorX = 0
     label_teks6.anchorY = 0
     label_teks6:setFillColor(0);
     scrollView:insert(label_teks6);


     local options = {
		 text = [[Nomor Rekening : 600.6700.774
Atas Nama : PT. Aarti Jaya
Cabang : Bandung]],
         x = 0.05 * display.contentWidth,
         y =  label_teks6.y + display.contentHeight/20,
         font = used_font_bold,
         fontSize = 13  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	local  label_teks7 = display.newText(options)
     label_teks7.anchorX = 0
     label_teks7.anchorY = 0
     label_teks7:setFillColor(0);
     scrollView:insert(label_teks7);



     local options = {
		 text = "Jika Anda telah melakukan pembayaran, silakan konfirmasikan pembayaran anda dengan menekan tombol dibawah ini",
         x = 0.05 * display.contentWidth,
         y =  label_teks7.y + display.contentHeight/8,
         font = used_font,
         fontSize = 13  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	local  label_teks8 = display.newText(options)
     label_teks8.anchorX = 0
     label_teks8.anchorY = 0
     label_teks8:setFillColor(0);
     scrollView:insert(label_teks8);



    local background_konfirmasi = display.newRect( display.contentCenterX, label_teks8.y +label_teks8.height + display.contentHeight/20, 0.9 * display.contentWidth, 50)
	background_konfirmasi.anchorY = 0
	background_konfirmasi:setFillColor( 133/255,190/255,72/255)
	scrollView:insert(background_konfirmasi)


	local options = {
		 text = "KONFIRMASI",
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

		local tablesetup = [[DELETE FROM t_produk_cart;]]
		db:exec(tablesetup)

		composer.showOverlay("overlay_loading", options_overlay)

     	composer.gotoScene("konfirmasi")
     end
     background_konfirmasi:addEventListener("tap", on_konfirmasi)


  --    local tablesetup = [[INSERT INTO is_login VALUES(NULL, '0', '0');]]
		-- db:exec(tablesetup)



	--======================================================FOOTER======================================================--




	local footer_background = display.newRect( display.contentCenterX, label_konfirmasi.y + display.contentHeight/10, display.contentWidth, display.contentHeight/7)
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
		                     -- began = began + 1
		                      
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
	                  	  if(began == composer.data_max_slider)then
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
            --timer.cancel(id_timer)
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
		
		tablesetup = [[DELETE FROM t_produk_cart;]]
		db:exec(tablesetup)
	
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
          
		--[[timer.cancel(id_timer)
        display.remove(scrollView_banner)  
	
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