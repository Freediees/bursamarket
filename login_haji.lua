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
local data_loading = 0
local cancelall = {}
local began = 1
local teksfield_email

local status_back = 0

local teks_email
local teks_password



local loop = 0


local datab = "data.db"
local path = system.pathForFile(datab, system.DocumentsDirectory)
db = sqlite3.open( path )


local tablesetup = [[DELETE FROM t_checkout2;]]
db:exec(tablesetup)

local tablesetup = [[DELETE FROM t_produk_cart;]]
db:exec(tablesetup)



local lfs = require( "lfs" )
 
	local doc_path = system.pathForFile( "", system.TemporaryDirectory )
	 
	for file in lfs.dir( doc_path ) do
	    local destDir = system.TemporaryDirectory  -- Location where the file is stored
        os.remove( system.pathForFile( file , destDir ) )
	end

function scene:create( event )
	--local sceneGroup = nil
	local sceneGroup = self.view
	


end

function scene:show( event )
	
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then

	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 1 )
	sceneGroup:insert(background)

	local background2 = display.newImageRect( composer.imgDir.. "background_overlay.png", 1080, 1080); 
	background2.x = display.contentCenterX;
	background2.y =  display.contentCenterY - display.contentHeight/10
	background2.anchorY = 0.5
	background2.anchorX = 0.5
	--background2:scale(0.5,0.5)
	background2.xScale = (display.contentHeight) / background2.height
	background2.yScale = (display.contentHeight) / background2.height
	
	local logo = display.newImageRect( composer.imgDir.. "logo_overlay.png", 900, 560 ); 
	logo.x = display.contentCenterX;
	logo.y =  display.contentCenterY - display.contentHeight/10
	logo.anchorY = 0.5
	logo.anchorX = 0.5
	--logo:scale(0.5,0.5)
	logo.xScale = (display.contentWidth* 0.7) / logo.width 
	logo.yScale = (display.contentWidth * 0.7) / logo.width 

	sceneGroup:insert(background)
	sceneGroup:insert(background2)
	sceneGroup:insert(logo)


	


	

	 


	

	-- local function loading()
	-- 	-- body
	-- local options_overlay =
	-- 	{
	-- 	    isModal = true,
	-- 	    effect = "fade",
	-- 	    time = 100,
	-- 	    params = {
	-- 	        sampleVar1 = "my sample variable",
	-- 	        sampleVar2 = "another sample variable"
	-- 	    }
	-- 	}

	-- composer.showOverlay("overlay", options_overlay)

	-- end
	-- timer.performWithDelay(10, loading)







		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		composer.removeHidden()

     	local function hide_logo()
     	composer.hideOverlay("fade", 100)




     	local teksfield_email = native.newTextField( display.contentCenterX, display.contentCenterY + display.contentHeight/8 , 0.8 * display.contentWidth, 40 )
		teksfield_email.anchorX = 0.5
		teksfield_email.alpha = 1
		teksfield_email.placeholder = "Email"
		teksfield_email.inputType = "email"
		sceneGroup:insert( teksfield_email )

		local function fieldHandler_t(event) 
	               if ("began" == event.phase) then 
	                  if name ~= nil then
	                    --name:removeSelf()
	                    --name = nil
	                  end
	               elseif ("ended" == event.phase) then 
	                  teks_email = teksfield_email.text


	               elseif ("submitted" == event.phase) then  
	                  teks_email = teksfield_email.text
	                  native.setKeyboardFocus(nil) 
	                elseif ( event.phase == "editing" ) then
	                  
	                  teks_email = teksfield_email.text

	                end  
	         end 

	    teksfield_email:addEventListener( "userInput", fieldHandler_t ) 

		


		local teksfield_password = native.newTextField( display.contentCenterX, teksfield_email.y + display.contentHeight/12 , 0.8 * display.contentWidth, 40 )
		teksfield_password.anchorX = 0.5
		teksfield_password.alpha = 1
		teksfield_password.placeholder = "Password"
		teksfield_password.isSecure = true
		sceneGroup:insert( teksfield_password )


		local function fieldHandler_t(event) 
	               if ("began" == event.phase) then 
	                  if name ~= nil then
	                    --name:removeSelf()
	                    --name = nil
	                  end
	               elseif ("ended" == event.phase) then 
	                  teks_password = teksfield_password.text


	               elseif ("submitted" == event.phase) then  
	                  teks_password = teksfield_password.text
	                  native.setKeyboardFocus(nil) 
	                elseif ( event.phase == "editing" ) then
	                  
	                  teks_password = teksfield_password.text

	                end  
	         end 


		    teksfield_password:addEventListener( "userInput", fieldHandler_t ) 


		    local function networkListenerPost( event )

          if ( event.isError ) then
            -- TODO Show error here
              print( "Network error!" )
              --loadIconListener()

          else
            --print( "App data loaded" )
            listData = json.decode( event.response )
            -- yang ini nerima data json dari server, gampangna mah data dari server d masukin ke array.


            --data_max = table.getn(listData);
            --composer.data_max = data_max


            print(event.response)
            --print("data maksimal : "..data_max)
            local data = event.response
          	
          	data = tonumber(data)
            --print("data login "..data)

          	if(data ~= 0)then
          			if nil~= composer.getScene("daftar_isi_haji") then composer.removeScene("daftar_isi_haji", true) end  
		            composer.masuk = 1
		            composer.is_login = 1
		            composer.gotoScene( "daftar_isi_haji" ) 
		            local tablesetup = [[UPDATE is_login set status_login = '1';]]
					db:exec( tablesetup )
					local tablesetup = [[UPDATE is_login set id_user = ']]..listData..[[';]]
					db:exec( tablesetup )
			else
					native.showAlert( "Gagal", "Email atau Password tidak sesuai" )
          	end

            --tampilBusanaMuslim()

           end
        end


	local function onLoginView()

			local headers = {
			}

			headers["Content-Type"] = "application/json"
			headers["X-API-Key"] = "13b6ac91a2"

			local lempar = {["email"] = teks_email , ["password"] = teks_password}

			local params = {}
			params.headers = headers
			params.body = json.encode( lempar)

            

            print("params.body : "..params.body)

            network.request( "http://api.bursasajadah.com/api/bursasajadah/login", "POST", networkListenerPost, params)

	end


		    local background_login = display.newRect( display.contentCenterX, teksfield_password.y + display.contentHeight/12 , 0.8 * display.contentWidth, 40  )
			background_login:setFillColor( 133/255,190/255,72/255 )
			sceneGroup:insert(background_login)

			background_login:addEventListener("tap", onLoginView )

			local login = display.newText( "Login", display.contentCenterX , background_login.y, used_font_bold, 15  * (display.contentWidth / 320)  )
			login.anchorX = 0.5
			login.anchorY = 0.5
			login.alpha = 1
			sceneGroup:insert(login)


			-- local nologin = display.newText( "Tidak punya akun? daftar ", display.contentCenterX - display.contentWidth/20, background_login.y + background_login.height, used_font, 13  * (display.contentWidth / 320)  )
			-- nologin.anchorX = 0.5
			-- nologin.anchorY = 0.5
			-- nologin.alpha = 1
			-- nologin:setFillColor(0)
			-- sceneGroup:insert(nologin)

			-- local disini = display.newText( "Disini", nologin.x + nologin.width/2  , background_login.y + background_login.height, used_font_bold, 15  * (display.contentWidth / 320)  )
			-- disini.anchorX = 0
			-- disini.anchorY = 0.5
			-- disini.alpha = 1
			-- disini:setFillColor(0,0,1)
			-- sceneGroup:insert(disini)

			-- local function daftar()
			-- 	system.openURL("http://m.bursasajadah.com/register")
			-- end
			-- disini:addEventListener("tap", daftar)

			-- local atau = display.newText( "Atau", display.contentCenterX, nologin.y + nologin.height + 2, used_font_bold, 15  * (display.contentWidth / 320)  )
			-- atau.anchorX = 0.5
			-- atau.anchorY = 0.5
			-- atau.alpha = 1
			-- atau:setFillColor(0)
			-- sceneGroup:insert(atau)

			-- local tamu = display.newText( "Masuk sebagai Tamu", display.contentCenterX, atau.y + atau.height + 2, used_font_bold, 14  * (display.contentWidth / 320)  )
			-- tamu.anchorX = 0.5
			-- tamu.anchorY = 0.5
			-- tamu.alpha = 1
			-- tamu:setFillColor(133/255,190/255,72/255)
			-- sceneGroup:insert(tamu)

			-- local function login_tamu()
			-- 	composer.gotoScene("view1")
			-- 	composer.masuk = 1
			-- end

			-- tamu:addEventListener("tap", login_tamu)




     	end

     	timer.performWithDelay(100, hide_logo)

    
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then



	
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