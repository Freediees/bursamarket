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
composer.halaman_page = 0
local cancelall
local began = 1
local loadall = 0
composer.page = 1
local looptimer = 0
local teksfield
cur_page = "berita"

composer.status_ceklis = 1

require "sqlite3"

local datab = "data.db"
local path = system.pathForFile(datab, system.DocumentsDirectory)
db = sqlite3.open( path )
 


function scene:create( event )

	--local sceneGroup = nil
	local sceneGroup = self.view


	
	
	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.
	
	-- create a white background to fill screen
	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 1 )	-- white
	

	local background2 = display.newRect( display.contentCenterX, 0, display.contentWidth, display.contentHeight/8)
	background2.anchorY = 0
	background2:setFillColor( 133/255,190/255,72/255)
	
	-- local under = display.newRect( display.contentWidth, background2.y + background2.height, display.contentWidth/2, 5)
	-- under.anchorY = 1
	-- under.anchorX = 1
	-- under:setFillColor(1)


	local function onMenu()
		
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

		composer.showOverlay("overlay_menu2", options_overlay)
	end


	local menu = display.newImageRect( composer.imgDir.. "menu.png", 110, 88 ); 
	menu.x = 0 + 20 ;
	menu.y =  background2.y + background2.height - display.contentHeight/25
	menu.anchorY = 0.5
	menu.anchorX = 0
	--menu:scale(0.5,0.5)
	menu.xScale = (background2.height/6) / menu.height
	menu.yScale = (background2.height/6) / menu.height

	menu:addEventListener("tap", onMenu)

	local teks_daftar_isi = display.newText( "Info Haji", menu.x + display.contentWidth/8 , menu.y , used_font_bold, 20  * (display.contentWidth / 320)  )
	teks_daftar_isi.anchorX = 0
	teks_daftar_isi.anchorY = 0.5
	teks_daftar_isi.alpha = 1

	-- local teks_umroh = display.newText( "Umroh", menu.x + display.contentWidth/8 , menu.y , used_font_bold, 15  * (display.contentWidth / 320)  )
	-- teks_umroh.x = 0.25 * display.contentWidth
	-- teks_umroh.anchorX = 0.5
	-- teks_umroh.y = background2.y + background2.height - 5
	-- teks_umroh.anchorY = 1
	-- teks_umroh.alpha = 1


	-- function onteks_umroh(self) 
 --            if nil~= composer.getScene("daftar_isi_umroh") then composer.removeScene("daftar_isi_umroh", true) end  
 --            if  self.type == "press" then 
 --                self:setEnabled(false) 
 --            else 
                
 --            end    
 --            composer.gotoScene( "daftar_isi_umroh" ) 
 --    end
 --    teks_umroh:addEventListener("tap", onteks_umroh) 

	-- local teks_haji = display.newText( "Haji", menu.x + display.contentWidth/8 , menu.y , used_font_bold, 15  * (display.contentWidth / 320)  )
	-- teks_haji.x = 0.75 * display.contentWidth
	-- teks_haji.anchorX = 0.5
	-- teks_haji.y = background2.y + background2.height - 5
	-- teks_haji.anchorY = 1
	-- teks_haji.alpha = 1

	-- local logo = display.newImageRect( composer.imgDir.. "logo.png", 125, 39 ); 
	-- logo.x = display.contentCenterX;
	-- logo.y =  0 + display.contentCenterY / 11
	-- logo.anchorY = 0.5
	-- --logo:scale(0.5,0.5)
	-- logo.xScale = (display.contentWidth/4) / logo.width 
	-- logo.yScale = (display.contentWidth/4) / logo.width 


	composer.tinggi_header = background2.height
	
	scrollView = widget.newScrollView(
	    {
	        top = 0 + composer.tinggi_header,
	        left = 0,
	        width = display.contentWidth,
	        height = display.contentHeight - composer.tinggi_header,
	        horizontalScrollDisabled = true,
	        isBounceEnabled = false,
	        --backgroundColor = {0,0.4, 0.1, 1}
	        --scrollWidth = 600,
	        --scrollHeight = 2000,
	        --listener = scrollListener

	    }
	)

	print("id_berita : "..composer.id_berita)

	local function tampilBerita()
		-- body

		local index
		local params = {}
        params.progress = true

        local x = display.contentWidth /20
        local y = 5

        print(data_max)
        
        	local data = listData[1]

        	--print(data)
        	local data_gambar = listData2
        	--print(data_gambar)
        	local data_konten = listData1

        	--print(data_konten[1].post_title)



        	

        	local function networkListener( event )
					  if ( event.isError ) then
		                      print( "Network error - download failed" )
		              elseif ( event.phase == "began" ) then
		                      cancelall = event.requestId
		                      print( "Progress Phase: began" )
		                      began = began + 1
		              elseif ( event.phase == "ended" ) then

		              local back_berita = display.newRect( display.contentCenterX, y, display.contentWidth * 0.95, display.contentHeight/7)
					  back_berita.anchorY = 0
				  	  back_berita:setFillColor( 1)
					  scrollView:insert(back_berita)
		             

                      local myImage = display.newImage( event.response.filename, event.response.baseDirectory, 20,  tes )
                      myImage.x = display.contentCenterX
              		  myImage.anchorX = 0.5
              		  myImage.anchorY = 0
                      myImage.y = 10
                      myImage.width = 1600
                      myImage.height = 1075
                      myImage.xScale = (0.9 * back_berita.width) / 1600
                      myImage.yScale = (0.9 * back_berita.width) / 1600
                      myImage.alpha = 1
                      --transition.to( layer.myImage, { alpha = 1.0 , delay = 0} )
                      scrollView:insert(myImage)

                     local options = {
				     text = data_konten[1].post_title,
	       		     x = myImage.x - myImage.width * myImage.yScale/2,
	     		     y = myImage.y + myImage.height * myImage.yScale + display.contentHeight/40,
	       			 font = "Roboto.ttf",
	        		 fontSize = 15  * (display.contentWidth / 320),
	        		 align = "left",
	        		 width = 0.9 * display.contentWidth
	 			 	 }


	 		  local teks1 = display.newText(options)
	   		  teks1.anchorX = 0
	   		  teks1.anchorY = 0
	    	  teks1:setFillColor(0);
	     	  scrollView:insert(teks1);



	     	  		local options = {
				     text = data_konten[1].post_content,
	       		     x = myImage.x - myImage.width * myImage.yScale/2,
	     		     y = teks1.y + teks1.height + display.contentHeight/40,
	       			 font = "Roboto.ttf",
	        		 fontSize = 12  * (display.contentWidth / 320),
	        		 align = "left",
	        		 width = 0.8 * display.contentWidth
	 			 	 }


	 		  local teks2 = display.newText(options)
	   		  teks2.anchorX = 0
	   		  teks2.anchorY = 0
	    	  teks2:setFillColor(0);
	     	  scrollView:insert(teks2);


  		 			  y = y + back_berita.height + 5



                  	  end
			end

  		   cancelall = network.download( data_gambar[1].guid, "GET", networkListener,params, "detai_berita.jpg", system.TemporaryDirectory, 0, 0 )



       
	end
	local function dataResponseListener( event )

          if ( event.isError ) then
            -- TODO Show error here
              print( "Network error!" )
              --loadIconListener()

          else
            print( "App data loaded" )
            listData = json.decode( event.response )
            -- yang ini nerima data json dari server, gampangna mah data dari server d masukin ke array.

            print(event.response)

         	listData1 = listData.content
         	listData2 = listData.image

            data_max = table.getn(listData2);
           
            --print("max: "..data_max)

            tampilBerita()

            end
    end

	print(composer.id_berita)
	dl_id1 = network.request( "http://api.infohaji.co.id/api/artikel/detail_artikel/"..composer.id_berita, "GET", dataResponseListener )


	


	-- all objects must be added to group (e.g. self.view)
	sceneGroup:insert( background )
	sceneGroup:insert( background2 )
	sceneGroup:insert(menu)
	sceneGroup:insert(teks_daftar_isi)
	-- sceneGroup:insert(teks_umroh)
	-- sceneGroup:insert(teks_haji)
	--sceneGroup:insert(under)
	sceneGroup:insert(scrollView)


end

function scene:show( event )
	composer.removeHidden()
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then

	
	
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then


   
               
    end


end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		

	
		
        network.cancel( cancelall)
        
	
		display.remove(scrollView)
		display.remove(scrollView2)

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