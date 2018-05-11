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
local glo = require("globals")


local x_mid = display.contentCenterX;
local y_mid = display.contentCenterY;
local x_quar1 = x_mid/2
local x_quar2 = x_mid + x_mid/2
local y_quar1 = y_mid/2
local y_quar2 = y_mid + y_mid/2
local lebar = display.contentWidth
local tinggi = display.contentHeight

function scene:create( event )
	--local sceneGroup = nil
	local sceneGroup = self.view
	

	print(lebar.." hemeh "..tinggi)
	local background = display.newRect(x_mid, y_mid, lebar, tinggi )
	background:setFillColor(1)
	sceneGroup:insert(background)

	--[[local logo = display.newImageRect( composer.imgDir.. "Overwatch.png", 128, 128 ); 
	logo.x = x_mid;
	logo.y =  y_mid
	logo.anchorY = 0.5
	logo.anchorX = 0.5
	--logo:scale(0.5,0.5)
	logo.xScale = (display.contentWidth* 0.5) / logo.width 
	logo.yScale = (display.contentWidth * 0.5) / logo.width 
	sceneGroup:insert(logo)--]]



	local options3 = {

		 text = "PERHATIAN",
         x = lebar * 0.05,
         y = tinggi/10,
         font = used_font,
         fontSize = 15  * (display.contentWidth / 320),
         align = "center",
         width = (0.9 * display.contentWidth)
 	 }


 	 local teks_perhatian = display.newText(options3)
     teks_perhatian.anchorX = 0
     teks_perhatian.anchorY = 0
     teks_perhatian:setFillColor(0);
     sceneGroup:insert(teks_perhatian);



     local options = {
						 text = "Nama Lengkap",
	                     x = 0 + 0.05 * display.contentWidth,
	                     y = teks_perhatian.y + display.contentHeight/15,
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
	garis1.strokeWidth = 2
	scrollView:insert(garis1)

	local function on_label_nama()	

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

	--[[local options3 = {

		 text = composer.text_disclaimer2,
         x = lebar * 0.05,
         y = teks_perhatian.y + y_quar1/4,
         font = used_font,
         fontSize = 12  * (display.contentWidth / 320),
         align = "center",
         width = (0.9 * display.contentWidth)
 	 }


 	 local teks_produk_diskon_desc = display.newText(options3)
     teks_produk_diskon_desc.anchorX = 0
     teks_produk_diskon_desc.anchorY = 0
     teks_produk_diskon_desc:setFillColor(0);
     sceneGroup:insert(teks_produk_diskon_desc);


     local function toHome()


     	composer.gotoScene("home", {
				effect="fromRight", 
				time=200
			})
     	
     end

     local button2 = widget.newButton(
    {
        label = "Mulai Simulasi",
        onEvent = toHome,
        --emboss = false,
        -- Properties for a rounded rectangle button
        shape = "roundedRect",
        --width = teks_masuk.width + 20,
        height = tinggi/15,
        cornerRadius = 5,
        fillColor = { default={155/255, 39/255, 21/255,1}, over={155/255, 39/255, 21/255,0.4} },
        labelColor = { default={ 1 }, over={ 0.4 } }
	    }
	)
	 
	-- Center the button
	button2.x = x_mid
	button2.y = teks_produk_diskon_desc.y + teks_produk_diskon_desc.height + 30

	sceneGroup:insert(button2)

	--]]
 
-- Change the button's label text

     --sceneGroup:insert(button1)
     --sceneGroup:insert(teks_masuk)

end

function scene:show( event )
	
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then

	print(composer.text123)


		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		composer.removeHidden()


		
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