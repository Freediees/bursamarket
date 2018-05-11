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
--composer."Roboto.ttf" = "Raleway-Bold.ttf"
composer.id_kategori = 0
composer.status_kategori= 1 
composer.halaman_page = 0
local cancelall = {}
local began = 1
local loadall = 0
composer.page = 1
local looptimer = 0
local teksfield
cur_page = "umroh"
local download
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
	


	local background2 = display.newRect( display.contentCenterX, 0, display.contentWidth, display.contentHeight/2.6)
	background2.anchorY = 0
	background2:setFillColor( 0)
	
	composer.tinggi_header = background2.height

	local logo = display.newImageRect( composer.imgDir.. "play.png", 1920, 1920 ); 
	logo.x = display.contentCenterX;
	logo.fill.effect = "filter.invert"
	logo.y =  background2.y + background2.height/2
	logo.anchorY = 0.5
	logo.anchorX = 0.5
	--logo:scale(0.5,0.5)
	logo.xScale = (display.contentWidth/3) / logo.width 
	logo.yScale = (display.contentWidth/3) / logo.width 


	 local transfered = display.newText("0", display.contentCenterX, logo.y, "Roboto.ttf", 13  * (display.contentWidth / 320) )
     transfered.anchorX = 0.5
     transfered.anchorY = 0
     transfered:setFillColor(1);
     transfered.alpha = 0

     
     local downloading = display.newText("Downloading", display.contentCenterX, transfered.y - 50, "Roboto.ttf", 25  * (display.contentWidth / 320) )
     downloading.anchorX = 0.5
     downloading.anchorY = 0
     downloading:setFillColor(1);
     downloading.alpha = 0
     
	
	scrollView = widget.newScrollView(
	    {
	        top = background2.y + background2.height,
	        left = 0,
	        width = display.contentWidth,
	        height = display.contentHeight - background2.height,
	        horizontalScrollDisabled = true,
	        isBounceEnabled = false
	        --backgroundColor = {0,0.4, 0.1, 1}
	        --scrollWidth = 600,
	        --scrollHeight = 2000,
	        --listener = scrollListener

	    }
	)





	local function on_play()

		logo:removeEventListener("tap", on_play)


		local full = display.newImageRect( composer.imgDir.. "fullscreen.png", 64, 64 ); 
		full.x = display.contentWidth - display.contentWidth/15;
		--full.fill.effect = "filter.invert"
		full.y =  background2.y + background2.height -10
		full.anchorY = 1
		full.anchorX = 0.5
		--full:scale(0.5,0.5)
		full.xScale = (display.contentWidth/23) / full.width 
		full.yScale = (display.contentWidth/23) / full.width
		sceneGroup:insert(full)




		for row in db:nrows("SELECT * FROM t_video") do
		  	if(row.video17 == '0')then

		  		print("hehehehehe")
				logo.alpha = 0
				logo:removeEventListener("tap", on_play)
				transfered.alpha = 1
				downloading.alpha = 1


				local function networkListener( event )
				    if ( event.isError ) then
				        print( "Network error: ", event.response )
				 
				    elseif ( event.phase == "began" ) then
				        if ( event.bytesEstimated <= 0 ) then
				            print( "Download starting, size unknown" )
				        else
				            print( "Download starting, estimated size: " .. event.bytesEstimated )
				        end
				 
				    elseif ( event.phase == "progress" ) then
				        if ( event.bytesEstimated <= 0 ) then
				        	transfered.text = event.bytesTransferred.."/15319966"
				            print( "Download progress: " .. event.bytesTransferred )

				        else
				        	transfered.text = event.bytesTransferred.."/15319966"
				            print( "Download progress: " .. event.bytesTransferred .. " of estimated: " .. event.bytesEstimated )
				        end
				         
				    elseif ( event.phase == "ended" ) then
				        print( "Download complete, total bytes transferred: " .. event.bytesTransferred )
				        transfered.text = event.bytesEstimated.."/15319966"


				         local tablesetup = [[UPDATE t_video set video17 = '1';]]
						 db:exec( tablesetup )


						background2.alpha = 0
						transfered.alpha = 0
						downloading.alpha = 0
						logo.alpha = 1

						video = native.newVideo( display.contentCenterX, 0, display.contentWidth,  display.contentHeight/3 )
				        video.anchorY = 0
				        video:load( "video17.mp4", system.DocumentsDirectory )
				        video:play()
				        sceneGroup:insert(video)
				        -- media.playVideo( "video1.mp4", system.TemporaryDirectory, true )

				        local function on_video()

				        	background2.alpha = 1
				        	video:pause()
							video:removeSelf()
							video = nil
							logo:addEventListener("tap", on_play)
				        	media.playVideo( "video17.mp4", system.DocumentsDirectory, true )
				        end
				        full:addEventListener("tap", on_video)
				    end
				end
				 
				local params = {}
				params.progress = true

				download = network.download(
				    "http://bursasajadah.com/video/pelaksanaan_ibadah_haji-doa_thawaf6.mp4",
				    "GET",
				    networkListener,
				    params,
				    "video17.mp4",
				    system.DocumentsDirectory
				)
			else
				print("masuk else")

				background2.alpha = 0
				transfered.alpha = 0
				downloading.alpha = 0
				video = native.newVideo( display.contentCenterX, 0, display.contentWidth,  display.contentHeight/3 )
		        video.anchorY = 0
		        video:load( "video17.mp4", system.DocumentsDirectory )
		        video:play()
		        sceneGroup:insert(video)

		        local function on_video()
		        	print("on video")
		        	background2.alpha = 1
		        	video:pause()
					video:removeSelf()
					video = nil
					logo:addEventListener("tap", on_play)
		        	media.playVideo( "video17.mp4", system.DocumentsDirectory, true )
		        end
		        full:addEventListener("tap", on_video)
				-- media.playVideo( "video1.mp4", system.TemporaryDirectory, true )
			end
		end
		
		-- local onComplete = function( event )
		--    print( "video session ended" )
		-- end
		-- media.playVideo( "http://bursasajadah.com/video/intro.mp4", media.RemoteSource, true )
	end
	logo:addEventListener("tap", on_play)





	local options = {
         text = "Doa Thawaf pada putaran keenam",
         x = display.contentWidth*0.05,
         y = 0 + display.contentHeight/20,
         font = "Roboto.ttf",
         fontSize = 20  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
     }



     local teks_judul = display.newText(options)
     teks_judul.anchorX = 0
     teks_judul.anchorY = 0
     teks_judul:setFillColor(205/255,176/255,48/255);
     scrollView:insert(teks_judul);

	


     local options = {
         text = "اللّهُمَّ إِنَّ لَكَ عَلَيَّ حُقُوْقًا كَثِيْرَةً فِيْمَا بَيْنِيْ وَبَيْنَكَ وَحُقُوْقًا كَثِيْرَةً فِيْمَا بَيْنِيْ وَبَيْنَ خَلْـقِكَ. اللّهُمَّ مَاكَانَ لَكَ مِنْهَا فَاغْفِرْهُ لِيْ وَمَاكَانَ لِخَلْقِكَ فَتَحَمَّلْهُ عَنِّيْ وَأَغْنِنِى بِحَلاَ لِكَ عَنْ حَرَامِكَ وَبِطَا عَتِكَ عَنْ مَعْصِيَتِكَ وَبِفَضْلِكَ عَمَّنْ سِوَاكَ يَاوَاسِعَ الْمَغْفِرَةِ. اَللّهُمَّ إِنَّ بَيْتَكَ عَظِيْمٌ وَوَجْهَكَ كِرَيْمٌ اَنْتَ يَااللهُ حَلِيْمٌ كَرِيْمٌ عَظِيْمٌ تُحِبُّ الْعَفْوَ فَاعْفُ عَنِّيْ",
         x = display.contentWidth*0.05,
         y = teks_judul.y + teks_judul.height + display.contentHeight/20,
         font = "Roboto.ttf",
         fontSize = 25  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
     }



     local teks1 = display.newText(options)
     teks1.anchorX = 0
     teks1.anchorY = 0
     teks1:setFillColor(0);
     scrollView:insert(teks1);



     local options = {
		 text = [[Allahumma inna laka 'alayya huquuqan katsiiratan fii maa bainii wa bainaka, wa huquuqan katsiiratan fii maa bainii wa baina khalqika. Allahumma maa kaana laka minhaa faghfirhu lii, wa maa kaana likhalqika fatahammalhu 'annii, wa aghninii bihalaalika 'an haraamika, wa bi thaa'atika 'an ma'shiyatika, wa bi fadhlika 'amman siwaaka, yaa waasi'a l-maghfirah. Allahumma inna baitaka azhiimun, wa wajhaka kariimun, wa anta ya Allahu kariimun, 'azhiimun, tuhibbu l'afwa fa'fu 'annii.]],
         x = display.contentWidth*0.05,
         y = teks1.y + teks1.height + display.contentHeight/25,
         font = "Raleway-Bold.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	 local teks2 = display.newText(options)
     teks2.anchorX = 0
     teks2.anchorY = 0
     teks2:setFillColor(0);
     scrollView:insert(teks2);

     local options = {
         text = [[Artinya:

“"Ya Allah, sesungguhnya Engkau mempunya hak yang banyak sekali atas diriku dalam hubungan antara aku dengan Mu. Dan Engkau juga mempunya hak yang banyak sekali dalam hubungan antara aku dengan makhlukMu. Ya Allah, apa yang menjadi hakMu atas diriku, maka ampunilah aku. Dan apa saja yang menjadi hak makhlukMu atas diriku, maka tanggungkanlah dariku. Cukupkanlah diriku dengan rizkiMu yang halal, terhindar dari yang haram. Dan dengan ta'at kepadaMu, terhindar dari kemaksiatan. Dan dengan anugerahMu terhindar daripada mengharap dari selain daripadaMu, wahai Tuhan Yang Maha Luas pengampunanNya. Ya Allah, sesungguhnya rumahMu ini agung, ZatMu pun sungguh mulia, dan Engkau ya Allah, Maha Penyabar, Maha Pemurah dan Maha Agung, Engkau suka memberi ampun, maka ampunilah aku"]],
         x = display.contentWidth*0.05,
         y = teks2.y + teks2.height + display.contentHeight/40,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.8 * display.contentWidth)
     }


     local teks3 = display.newText(options)
     teks3.anchorX = 0
     teks3.anchorY = 0
     teks3:setFillColor(0);
     scrollView:insert(teks3);


    


    
    local line = display.newLine( 0, teks3.y + teks3.height + display.contentHeight/20, display.contentWidth, teks3.y + teks3.height + display.contentHeight/20 )
	line:setStrokeColor( 133/255,190/255,72/255)
	line.strokeWidth = 2
	scrollView:insert(line)
     
	local back = display.newText( "Back", 20 , 0 + display.contentHeight / 20, used_font_bold, 15  * (display.contentWidth / 320)  )
    back.anchorX = 0
    back.anchorY = 0.5
    back.alpha = 1

    function onback(self) 
            if nil~= composer.getScene("daftar_isi_haji") then composer.removeScene("daftar_isi_haji", true) end    
            composer.gotoScene( "daftar_isi_haji" ) 
    end
    back:addEventListener("tap", onback)

	-- all objects must be added to group (e.g. self.view)
	sceneGroup:insert( background )
	sceneGroup:insert( background2 )
	sceneGroup:insert(logo)
	sceneGroup:insert(back)

	sceneGroup:insert(downloading);
    sceneGroup:insert(transfered);

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
		

		if(sceneGroup ~= nil )then
		sceneGroup:removeSelf()
		sceneGroup = nil
		end

          
        display.remove(scrollView_banner)  
	
		display.remove(scrollView)
		display.remove(scrollView2)

		network.cancel( download )
		
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