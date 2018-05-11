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
local cancelall = {}
local began = 1

composer.page = 1

function scene:create( event )

	local lfs = require( "lfs" )
 	
 	local sceneGroup = self.view

	local doc_path = system.pathForFile( "", system.TemporaryDirectory )
	 
	for file in lfs.dir( doc_path ) do
	    local destDir = system.TemporaryDirectory  -- Location where the file is stored
        os.remove( system.pathForFile( file , destDir ) )
	end

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.
	
	-- create a white background to fill screen
	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 0 )
	background.alpha = 0.2	-- white
	

	

	local popup1 = display.newRoundedRect( display.contentCenterX, display.contentCenterY, display.contentWidth * 0.9, display.contentHeight/3, 12)
	popup1.anchorY = 0.5
	popup1.anchorX = 0.5
	popup1:setFillColor( 133/255,190/255,72/255)
	

	local popup2 = display.newText( "Tambah Perlengkapan Baru", popup1.x, popup1.y - popup1.height/2 + 20, used_font_bold, 12  * (display.contentWidth / 320))
	popup2.anchorX = 0.5
	popup2.anchorY = 0
	popup2:setFillColor(1)


	local options = {
						 text = "Nama Perlengkapan",
	                     x = popup1.x,
	                     y = popup2.y + display.contentHeight/10,
	                     font = used_font_bold,
	                     fontSize = 13  * (display.contentWidth / 320),
	                     align = "center",
	                     width = (0.9 * display.contentWidth)
                 	 }


 	 label_popup3 = display.newText(options)
     label_popup3.anchorX = 0.5
     label_popup3.anchorY = 0
     label_popup3:setFillColor(1);

    local garis3 = display.newLine( 0 + 0.05 * display.contentWidth, label_popup3.y + label_popup3.height + 3, display.contentWidth - display.contentWidth*0.05, label_popup3.y + label_popup3.height + 3)
	garis3:setStrokeColor( 1)
	garis3.strokeWidth = 2


	local function on_label_popup3()	

		
		teksfield_popup3 = native.newTextField(display.contentCenterX, garis3.y -2, display.contentWidth*0.9, display.contentHeight/20)
		teksfield_popup3.anchorX = 0.5
		teksfield_popup3.anchorY = 1
		--teksfield_popup3.inputType = "number"
		teksfield_popup3.hasBackground = true
		--teksfield_popup3.placeholder = "popup3"
		--scrollView:insert( teksfield_popup3 )


		local function fieldHandler_t(event) 

				label_popup3.text = teksfield_popup3.text

               if ("began" == event.phase) then 
                  if name ~= nil then
                    --name:removeSelf()
                    --name = nil
                  end
               elseif ("ended" == event.phase) then 
                  label_popup3.text = teksfield_popup3.text
                  
                  teksfield_popup3:removeSelf()
                  teksfield_popup3 = nil

               elseif ("submitted" == event.phase) then  
               	  label_popup3.text = teksfield_popup3.text
                 
                  native.setKeyboardFocus(nil) 
                elseif ( event.phase == "editing" ) then
                  	
                  label_popup3.text = teksfield_popup3.text


                end  
         end 
        
		
        teksfield_popup3:addEventListener( "userInput", fieldHandler_t ) 

	end
	label_popup3:addEventListener("tap", on_label_popup3)
	
	local popup4 = display.newRect( display.contentCenterX - display.contentWidth/4 + 20, label_popup3.y + display.contentHeight/10, display.contentWidth * 0.4, 50)
	popup4.anchorY = 0.5
	popup4.anchorX = 0.5
	popup4:setFillColor( 1)
	scrollView:insert(popup4)



	local popup5 = display.newText( "Tambah", popup4.x, popup4.y , used_font_bold, 12  * (display.contentWidth / 320))
	popup5.anchorX = 0.5
	popup5:setFillColor(133/255,190/255,72/255)
	scrollView:insert(popup5)

	local function on_tambah( )
	   popup4:removeEventListener("tap", on_tambah)
		

		local tablesetup = [[INSERT INTO t_ceklis2 VALUES(NULL, ']]..label_popup3.text..[[', '0');]]
		db:exec(tablesetup)

       if nil~= composer.getScene("ceklis2") then composer.removeScene("ceklis2", true) end  
       
	   composer.gotoScene( "ceklis2" ) 

	  
	end
	popup4:addEventListener("tap", on_tambah)


	local popup6 = display.newRect( display.contentCenterX + display.contentWidth/4 -20, label_popup3.y + display.contentHeight/10, display.contentWidth * 0.4, 50)
	popup6.anchorY = 0.5
	popup6.anchorX = 0.5
	popup6:setFillColor( 1)
	scrollView:insert(popup6)

	local popup7 = display.newText( "Batal", popup6.x, popup6.y , used_font_bold, 12  * (display.contentWidth / 320))
	popup7.anchorX = 0.5
	popup7:setFillColor(133/255,190/255,72/255)
	scrollView:insert(popup7)

	local function on_cancel( )
	   popup4:removeEventListener("tap", on_cancel)

       if nil~= composer.getScene("ceklis2") then composer.removeScene("ceklis2", true) end  
       
	   composer.gotoScene( "ceklis2" ) 

	  
	end
	popup6:addEventListener("tap", on_cancel)

	sceneGroup:insert(background)
	sceneGroup:insert(popup1)
	sceneGroup:insert(popup2)
	sceneGroup:insert(label_popup3)
	sceneGroup:insert(popup4)
	sceneGroup:insert(popup5)
	sceneGroup:insert(popup6)
	sceneGroup:insert(popup7)
	sceneGroup:insert(garis3)

end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then


	elseif phase == "did" then

     --composer.removeHidden()
  
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
		
	if(teksfield_popup3 ~= nil)then
		
		teksfield_popup3:removeSelf()
		teksfield_popup3 = nil
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