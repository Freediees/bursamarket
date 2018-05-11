-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------
local widget = require( "widget" )
local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	-- Called when the scene's view does not exist.

	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 1 )	-- white
	

	local background2 = display.newRect( display.contentCenterX, 0+ display.contentCenterY / 12, display.contentWidth, display.contentHeight/12)
	background2:setFillColor( 133/255,190/255,72/255)
	
	local logo = display.newImageRect( composer.imgDir.. "logo.png", 125, 39 ); 
	logo.x = display.contentCenterX;
	logo.y =  0 + display.contentCenterY / 11
	logo.anchorY = 0.5
	--logo:scale(0.5,0.5)
	logo.xScale = (display.contentWidth/4) / logo.width 
	logo.yScale = (display.contentWidth/4) / logo.width 
	
	
	function onLogoView( event )
		composer.gotoScene( "view1" )
	end
	logo:addEventListener("tap", onLogoView )

	
	
	
	-- create some text
	local title = display.newText( "Menu", 10 , background2.height - display.contentCenterY / 20, "Roboto-Bold.ttf", 15  * (display.contentWidth / 320)  )
	title.anchorX = 0
	title.anchorY = 0.5
	title:setFillColor( 1 )


	local login = display.newText( "Login", display.contentWidth - 20 , background2.height - display.contentCenterY / 20, "Roboto-Bold.ttf", 15  * (display.contentWidth / 320)  )
	login.anchorX = 1
	login.anchorY = 0.5
	title:setFillColor( 1 )	-- black

	function onLoginView( event )
		composer.gotoScene( "login" )
	end
	login:addEventListener("tap", onLoginView )


	
	composer.tinggi_header = background2.height
	
	local scrollView = widget.newScrollView(
	    {
	        top = 0 + composer.tinggi_header,
	        left = 0,
	        width = display.contentWidth,
	        height = display.contentHeight - login.height -20,
	        --backgroundColor = {0,0.4, 0.1, 1}
	        --scrollWidth = 600,
	        --scrollHeight = 2000,
	        --listener = scrollListener

	    }
	)

	local teks1 = display.newText( "INFORMASI & PEMESANAN", display.contentCenterX , 0 + display.contentCenterY / 12, "Roboto-Bold.ttf", 15  * (display.contentWidth / 320))
	teks1.anchorX = 0.5
	teks1:setFillColor( 0 )
	scrollView:insert(teks1)

	local line = display.newLine( 0, composer.tinggi_header, display.contentWidth, composer.tinggi_header )
	line:setStrokeColor( 133/255,190/255,72/255)
	line.strokeWidth = 2
	scrollView:insert(line)

	composer.tinggi_line = line.y

	print(composer.tinggi_line)

	local teks_bbm = display.newText( "BBM : BSAJADAH / 2BA9262A", display.contentCenterX + display.contentWidth / 20, display.contentHeight/30 + composer.tinggi_header, "Roboto-Bold.ttf", 10 * (display.contentWidth / 320))
	teks_bbm.anchorX = 1
	teks_bbm:setFillColor(133/255,190/255,72/255)
	scrollView:insert(teks_bbm)
	composer.tinggi_teks_bbm = teks_bbm.y

	print("tinggi teks = "..composer.tinggi_teks_bbm)

	local teks_line = display.newText( "Line ID : @bursasajadah", display.contentCenterX + display.contentWidth / 20, composer.tinggi_teks_bbm + display.contentHeight/30 , "Roboto-Bold.ttf", 10  * (display.contentWidth / 320))
	teks_line.anchorX = 1
	teks_line:setFillColor(133/255,190/255,72/255)
	scrollView:insert(teks_line)
	composer.tinggi_teks_line = teks_line.y

	local teks_sms = display.newText( "Telp/SMS : 081322131666", display.contentCenterX + display.contentWidth / 20, composer.tinggi_teks_line + display.contentHeight/30 , "Roboto-Bold.ttf", 10  * (display.contentWidth / 320))
	teks_sms.anchorX = 1
	teks_sms:setFillColor(133/255,190/255,72/255)
	scrollView:insert(teks_sms)
	composer.tinggi_teks_sms = teks_sms.y

	local teks_whatsapp = display.newText( "Whatsapp : 081322131666", display.contentCenterX+ display.contentWidth / 20 , composer.tinggi_teks_sms + display.contentHeight/30 , "Roboto-Bold.ttf", 10 * (display.contentWidth / 320))
	teks_whatsapp.anchorX = 1
	teks_whatsapp:setFillColor(133/255,190/255,72/255)
	scrollView:insert(teks_whatsapp)
	composer.tinggi_teks_whatsapp = teks_whatsapp.y

	local teks_whatsapp2 = display.newText( "whatsapp2 : 085813152023", display.contentCenterX + display.contentWidth / 20, composer.tinggi_teks_whatsapp + display.contentHeight/30 , "Roboto-Bold.ttf", 10 * (display.contentWidth / 320))
	teks_whatsapp2.anchorX = 1
	teks_whatsapp2:setFillColor(133/255,190/255,72/255)
	scrollView:insert(teks_whatsapp2)
	composer.tinggi_teks_whatsapp2 = teks_whatsapp2.y

	local teks_email = display.newText( "email : admin@bursasajadah.com", display.contentCenterX + display.contentWidth / 20, composer.tinggi_teks_whatsapp2 + display.contentHeight/30 , "Roboto-Bold.ttf", 10  * (display.contentWidth / 320))
	teks_email.anchorX = 1
	teks_email:setFillColor(133/255,190/255,72/255)
	scrollView:insert(teks_email)
	composer.tinggi_teks_email = teks_email.y

	local line2 = display.newLine( 0, composer.tinggi_teks_email + display.contentHeight/30, display.contentWidth, composer.tinggi_teks_email + display.contentHeight/30 )
	line2:setStrokeColor( 133/255,190/255,72/255)
	line2.strokeWidth = 2
	scrollView:insert(line2)
	composer.tinggi_line2 = line2.y

	local gambar1 = display.newImageRect( composer.imgDir.. "DP.jpg", 808, 400 ); 
	gambar1.x = display.contentCenterX;
	gambar1.y = composer.tinggi_line2 + display.contentHeight/30
	gambar1.anchorY = 0
	--gambar1:scale(0.5,0.5)
	gambar1.xScale = display.contentWidth / gambar1.width 
	gambar1.yScale = display.contentWidth / gambar1.width 
	scrollView:insert(gambar1)


	local gambar_item = display.newRect( display.contentCenterX, gambar1.y + gambar1.height * gambar1.xScale + display.contentHeight/20, display.contentWidth - display.contentWidth / 10, 200)
	gambar_item:setFillColor( 133/255,190/255,72/255)
	gambar_item.anchorY = 0
	scrollView:insert(gambar_item)


	local teks_maintenance = display.newText( "Detail Barang", display.contentCenterX, gambar_item.y + gambar_item.height +  display.contentHeight/20, "Roboto-Bold.ttf", 20 * (display.contentWidth / 320))
	teks_maintenance.anchorX = 0.5
	teks_maintenance:setFillColor(133/255,190/255,72/255)
	scrollView:insert(teks_maintenance)
	composer.tinggi_teks_maintenance = teks_maintenance.y


	local string teks = [[Sajadah PM 309 - Sajadah berukuran normal dengan perpaduan motif Ka'bah dan gates unik khas Timur Tengah. Sajadah berbahan polyester ini cocok dijadikan sebagai souvenir atau oleh-oleh haji dan umroh untuk dibagaikan kepada kerabat dan keluarga Anda. Tersedia dalam beberapa pilihan warna; pink, hijau, coklat dan kuning.


Informasi Produk
SKU: 1010802716053
Kategori: Normal | Sajadah & Karpet |
Tags: Normal | Sajadah & Karpet |
Berat Pengiriman: 0.300 kg
Varian: Pink | Coklat | Hijau | Kuning |]]
    teks_definisi = display.newText (teks , display.contentCenterX, teks_maintenance.y + teks_maintenance.height + display.contentHeight/20 , display.contentWidth - display.contentWidth/10 , 0, "Roboto-Regular.ttf", 10 * (display.contentWidth / 320));     
    teks_definisi.anchorX = 0.5
    teks_definisi.anchorY = 0
    teks_definisi:setFillColor(0);
    scrollView:insert(teks_definisi);


	-- local line_footer = display.newLine( 0, gambar7.y + gambar7.height * gambar7.xScale + display.contentHeight/40, display.contentWidth, gambar7.y + gambar7.height * gambar7.xScale + display.contentHeight/40 )
	-- line_footer:setStrokeColor( 1)
	-- line_footer.strokeWidth = 0
	-- scrollView:insert(line_footer)

	-- local footer = display.newRect( display.contentCenterX, line_footer.y + display.contentHeight/20 , display.contentWidth, display.contentHeight/12)
	-- footer:setFillColor( 133/255,190/255,72/255)
	-- scrollView:insert(footer)



	--composer.tinggi_line2 = line2.y
	
	-- all objects must be added to group (e.g. self.view)
	sceneGroup:insert( background )
	sceneGroup:insert( background2 )
	sceneGroup:insert( logo )
	sceneGroup:insert( title )
	sceneGroup:insert( login )
	sceneGroup:insert( scrollView )
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.
	
	-- create a white background to fill screen
	
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
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
