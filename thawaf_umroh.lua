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
            if(row.video21 == '0')then

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
                            transfered.text = event.bytesTransferred.."/30824672"
                            print( "Download progress: " .. event.bytesTransferred )

                        else
                            transfered.text = event.bytesTransferred.."/30824672"
                            print( "Download progress: " .. event.bytesTransferred .. " of estimated: " .. event.bytesEstimated )
                        end
                         
                    elseif ( event.phase == "ended" ) then
                        print( "Download complete, total bytes transferred: " .. event.bytesTransferred )
                        transfered.text = event.bytesEstimated.."/30824672"


                         local tablesetup = [[UPDATE t_video set video21 = '1';]]
                         db:exec( tablesetup )


                        background2.alpha = 0
                        transfered.alpha = 0
                        downloading.alpha = 0
                        logo.alpha = 1

                        video = native.newVideo( display.contentCenterX, 0, display.contentWidth,  display.contentHeight/3 )
                        video.anchorY = 0
                        video:load( "video21.mp4", system.DocumentsDirectory )
                        video:play()
                        sceneGroup:insert(video)
                        -- media.playVideo( "video1.mp4", system.TemporaryDirectory, true )

                        local function on_video()

                            background2.alpha = 1
                            video:pause()
                            video:removeSelf()
                            video = nil
                            logo:addEventListener("tap", on_play)
                            media.playVideo( "video21.mp4", system.DocumentsDirectory, true )
                        end
                        full:addEventListener("tap", on_video)
                    end
                end
                 
                local params = {}
                params.progress = true

                download = network.download(
                    "http://bursasajadah.com/video/pelaksanaan_ibadah_haji-thawaf_ifadhah.mp4",
                    "GET",
                    networkListener,
                    params,
                    "video21.mp4",
                    system.DocumentsDirectory
                )
            else
                print("masuk else")

                background2.alpha = 0
                transfered.alpha = 0
                downloading.alpha = 0
                video = native.newVideo( display.contentCenterX, 0, display.contentWidth,  display.contentHeight/3 )
                video.anchorY = 0
                video:load( "video21.mp4", system.DocumentsDirectory )
                video:play()
                sceneGroup:insert(video)

                local function on_video()
                    print("on video")
                    background2.alpha = 1
                    video:pause()
                    video:removeSelf()
                    video = nil
                    logo:addEventListener("tap", on_play)
                    media.playVideo( "video21.mp4", system.DocumentsDirectory, true )
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



	local teks_judul = display.newText("Thawaf",display.contentWidth*0.05 , 0 + display.contentHeight/20, "Roboto.ttf", 20  * (display.contentWidth / 320)  )
    teks_judul.anchorX = 0
    teks_judul.anchorY = 0
    teks_judul:setFillColor(205/255,176/255,48/255);
    scrollView:insert(teks_judul);


	local options = {
		 text = [[Orang yang sedang melaksanakan thawaf diharuskan untuk mengelilingi Ka’bah sebanyak tujuh kali putaran, sebagaimana Firman Allah SWT:]],
         x = display.contentWidth*0.05,
         y = teks_judul.y + teks_judul.height + display.contentHeight/25,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


      


 	 local teks1 = display.newText(options)
     teks1.anchorX = 0
     teks1.anchorY = 0
     teks1:setFillColor(0);
     scrollView:insert(teks1);


     local options = {
         text = "وَلْيَطَّوَّفُوا بِالْبَيْتِ الْعَتِيقِ",
         x = display.contentWidth*0.05,
         y = teks1.y + teks1.height + display.contentHeight/20,
         font = "Roboto.ttf",
         fontSize = 25  * (display.contentWidth / 320),
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

“Dan hendaklah mereka melakukan melakukan thawaf sekeliling rumah yang tua itu (Baitullah).” (QS. Al Hajj: 29).]],
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


     local options = {
         text = "1. Masuk Masjidil Haram",
         x = display.contentWidth*0.05,
         y = teks3.y + teks3.height + display.contentHeight/25,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
     }


     local teks3_1 = display.newText(options)
     teks3_1.anchorX = 0
     teks3_1.anchorY = 0
     teks3_1:setFillColor(205/255,176/255,48/255);
     scrollView:insert(teks3_1);



     local options = {
         text = [[Dahulukan kaki kanan saat memasuki Masjidil Haram dan berdoa:]],
         x = display.contentWidth*0.05,
         y = teks3_1.y + teks3_1.height + display.contentHeight/25,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
     }


      


     local teks3_2 = display.newText(options)
     teks3_2.anchorX = 0
     teks3_2.anchorY = 0
     teks3_2:setFillColor(0);
     scrollView:insert(teks3_2);



      local options = {
         text = "َللّهُمَّ افْتَحْ لِيْ اَبْوَابَ رَحْمَتِكَ",
         x = display.contentWidth*0.05,
         y = teks3_2.y + teks3_2.height + display.contentHeight/20,
         font = "Roboto.ttf",
         fontSize = 25  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
     }



     local teks3_3 = display.newText(options)
     teks3_3.anchorX = 0
     teks3_3.anchorY = 0
     teks3_3:setFillColor(0);
     scrollView:insert(teks3_3);



     local options = {
         text = [[“Allahummaf-tahlii abwaaba rahmatika”.]],
         x = display.contentWidth*0.05,
         y = teks3_3.y + teks3_3.height + display.contentHeight/25,
         font = "Raleway-Bold.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
     }


     local teks3_4 = display.newText(options)
     teks3_4.anchorX = 0
     teks3_4.anchorY = 0
     teks3_4:setFillColor(0);
     scrollView:insert(teks3_4);

     local options = {
         text = [[Artinya :

 “Wahai Tuhanku, bukakanlah untukku pintu-pintu rahmat-Mu”.
]],
         x = display.contentWidth*0.05,
         y = teks3_4.y + teks3_4.height + display.contentHeight/40,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.8 * display.contentWidth)
     }


     local teks3_5 = display.newText(options)
     teks3_5.anchorX = 0
     teks3_5.anchorY = 0
     teks3_5:setFillColor(0);
     scrollView:insert(teks3_5);





     local options = {
         text = [[Berjalan dengan tenang dan khusuk sambil terus membaca talbiyah;]],
         x = display.contentWidth*0.05,
         y = teks3_5.y + teks3_5.height + display.contentHeight/25,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
     }


      


     local teks3_6 = display.newText(options)
     teks3_6.anchorX = 0
     teks3_6.anchorY = 0
     teks3_6:setFillColor(0);
     scrollView:insert(teks3_6);



      local options = {
         text = "َبَّيْكَ اللّٰهُمَّ لَبَّيْكَ. لَبَّيْكَ لَا شَرِيْكَ لَكَ لَبَّيْكَ. اِنَّ الْحَمْدَ وَالنِّعْمَةَ لَكَ وَاْلمُلْكَ لَا شَرِيْكَ لَك",
         x = display.contentWidth*0.05,
         y = teks3_6.y + teks3_6.height + display.contentHeight/20,
         font = "Roboto.ttf",
         fontSize = 25  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
     }



     local teks3_7 = display.newText(options)
     teks3_7.anchorX = 0
     teks3_7.anchorY = 0
     teks3_7:setFillColor(0);
     scrollView:insert(teks3_7);



     local options = {
         text = [[Labbaik Allahumma labBaik, labBaik laa syariika laka labbaik, innalhamda wan ni’mata, laka wal mulk, la syarika lak]],
         x = display.contentWidth*0.05,
         y = teks3_7.y + teks3_7.height + display.contentHeight/25,
         font = "Raleway-Bold.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
     }


     local teks3_8 = display.newText(options)
     teks3_8.anchorX = 0
     teks3_8.anchorY = 0
     teks3_8:setFillColor(0);
     scrollView:insert(teks3_8);

     local options = {
         text = [[Artinya :

“Aku penuhi seruan-Mu Ya Allah, aku penuhi seruan-Mu tidak ada sekutu bagi-Mu. Sesungguhnya segala puji, nikmat dan seluruh  kerajaan milik-Mu dan tidak ada sekutu bagi-Mu.”


Ketika melihat Ka’bah berdoa sambil mengangkat kedua tangan:

]],
         x = display.contentWidth*0.05,
         y = teks3_8.y + teks3_8.height + display.contentHeight/40,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.8 * display.contentWidth)
     }


     local teks3_9 = display.newText(options)
     teks3_9.anchorX = 0
     teks3_9.anchorY = 0
     teks3_9:setFillColor(0);
     scrollView:insert(teks3_9);



      local options = {
         text = "اَللّٰهُمَّ زِدْ هٰذَا الْبَيْتَ تَشْرِيْفًا وَتَعْظِيْمًا وَتَكْرِيْمًا وَمَهَابَةً وَزِدْ مَنْ شَرَّفَّهُ وَكَرَّمَهُ مِمَّنْ حَجَّهُ أَوِاعْتَمَرَهُ تَشْرِيْفًا وَتَعْظِيْمًا وَتَكْرِيْمًا وَبِرًّا",
         x = display.contentWidth*0.05,
         y = teks3_9.y + teks3_9.height + display.contentHeight/20,
         font = "Roboto.ttf",
         fontSize = 25  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
     }



     local teks3_10 = display.newText(options)
     teks3_10.anchorX = 0
     teks3_10.anchorY = 0
     teks3_10:setFillColor(0);
     scrollView:insert(teks3_10);



     local options = {
         text = [[Allahumma zid haadzal baita tasyriifan wata’dziiman watakriiman wamahaabatan wazid man syarroffahu wa karramahu mimman hajjahu awi’tamarahu tasyriifan wata’dzhiiman watakriiman wabirran.]],
         x = display.contentWidth*0.05,
         y = teks3_10.y + teks3_10.height + display.contentHeight/25,
         font = "Raleway-Bold.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
     }


     local teks3_11 = display.newText(options)
     teks3_11.anchorX = 0
     teks3_11.anchorY = 0
     teks3_11:setFillColor(0);
     scrollView:insert(teks3_11);

     local options = {
         text = [[Artinya :

“Ya Allah, tambahkan lah kemuliaan, kehormatan, keagungan dan kehebatan pada Baitullah ini dan tambahkanlah pula pada orang-orang yang memuliakan, menghormati dan mengagungkannya diantara mereka yang berhaji atau yang berumroh padanya dengan kemuliaan, kehormatan, kebesaran dan kebaikan”.


Bacaan talbiyah dihentikan ketika melaksanakan thawaf.


]],
         x = display.contentWidth*0.05,
         y = teks3_11.y + teks3_11.height + display.contentHeight/40,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.8 * display.contentWidth)
     }


     local teks3_12 = display.newText(options)
     teks3_12.anchorX = 0
     teks3_12.anchorY = 0
     teks3_12:setFillColor(0);
     scrollView:insert(teks3_12);





     local options = {
		 text = "2. Tata Cara Thawaf:",
         x = display.contentWidth*0.05,
         y = teks3_12.y + teks3_12.height + display.contentHeight/25,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	 local teks4 = display.newText(options)
     teks4.anchorX = 0
     teks4.anchorY = 0
     teks4:setFillColor(205/255,176/255,48/255);
     scrollView:insert(teks4);


     local options = {
		 text = "1.	Niat Thawaf:",
         x = display.contentWidth*0.05,
         y = teks4.y + teks4.height + display.contentHeight/25,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	 local teks5 = display.newText(options)
     teks5.anchorX = 0
     teks5.anchorY = 0
     teks5:setFillColor(205/255,176/255,48/255);
     scrollView:insert(teks5);


     local options = {
         text = [[Niat thawaf didalam hati, disertai dengan ucapan :]],
         x = display.contentWidth*0.05,
         y = teks5.y + teks5.height + display.contentHeight/20,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	 local teks6 = display.newText(options)
     teks6.anchorX = 0
     teks6.anchorY = 0
     teks6:setFillColor(0);
     scrollView:insert(teks6);

     
      local options = {
         text = "نَوَيْتُ أَنْ أَطُوْ فَ بِهَذَا الْبَيْتِ لِلَّهِ تَعَالَى , بِسْم اللهِ اَللهُ أَكْبَرْ",
         x = display.contentWidth*0.05,
         y = teks6.y + teks6.height + display.contentHeight/20,
         font = "Roboto.ttf",
         fontSize = 25  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
     }



     local teks7 = display.newText(options)
     teks7.anchorX = 0
     teks7.anchorY = 0
     teks7:setFillColor(0);
     scrollView:insert(teks7);

     local options = {
		 text = [[“Nawaitu an athuufa bihadzal baiti lillahi ta’ala, bismilahi Allah akbar"]],
         x = display.contentWidth*0.05,
         y = teks7.y + teks7.height + display.contentHeight/25,
         font = "Raleway-Bold.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	 local teks8 = display.newText(options)
     teks8.anchorX = 0
     teks8.anchorY = 0
     teks8:setFillColor(0);
     scrollView:insert(teks8);

     local options = {
         text = [[Artinya : 

"Saya niat thawaf semata-mata karena Allah, dengan menyebut nama Allah. Maha besar Allah"
]],
         x = display.contentWidth*0.05,
         y = teks8.y + teks8.height + display.contentHeight/40,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.8 * display.contentWidth)
     }


     local teks9 = display.newText(options)
     teks9.anchorX = 0
     teks9.anchorY = 0
     teks9:setFillColor(0);
     scrollView:insert(teks9);

     
     local options = {
		 text = "2.	Idhthiba bagi Pria",
         x = display.contentWidth*0.05,
         y = teks9.y + teks9.height + display.contentHeight/25,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	 local teks10 = display.newText(options)
     teks10.anchorX = 0
     teks10.anchorY = 0
     teks10:setFillColor(205/255,176/255,48/255);
     scrollView:insert(teks10);

     local options = {
         text = [[Bagi pria kain ihramnya dirubah menjadi idhtiba, yaitu ujung baju ihram bagian kanan disimpan di pundak sebelah kiri. Sehingga pundak kanan terlihat dan pundak kiri tertutup dengan kain ihram bagian atas. ]],
         x = display.contentWidth*0.05,
         y = teks10.y + teks10.height + display.contentHeight/20,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	 local teks11 = display.newText(options)
     teks11.anchorX = 0
     teks11.anchorY = 0
     teks11:setFillColor(0);
     scrollView:insert(teks11);










     local options = {
		 text = "3.	Menuju ke Hajar Aswad",
         x = display.contentWidth*0.05,
         y = teks11.y + teks11.height + display.contentHeight/25,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	 local teks12 = display.newText(options)
     teks12.anchorX = 0
     teks12.anchorY = 0
     teks12:setFillColor(205/255,176/255,48/255);
     scrollView:insert(teks12);


     local options = {
         text = [[Berjalan hingga sejajar dengan Hajar Aswad, sambil bertakbir:]],
         x = display.contentWidth*0.05,
         y = teks12.y + teks12.height + display.contentHeight/20,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	 local teks13 = display.newText(options)
     teks13.anchorX = 0
     teks13.anchorY = 0
     teks13:setFillColor(0);
     scrollView:insert(teks13);

     
      local options = {
         text = "بِسْمِ اللهِ وَاللهُ أَكْبَرُ",
         x = display.contentWidth*0.05,
         y = teks13.y + teks13.height + display.contentHeight/20,
         font = "Roboto.ttf",
         fontSize = 25  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
     }



     local teks14 = display.newText(options)
     teks14.anchorX = 0
     teks14.anchorY = 0
     teks14:setFillColor(0);
     scrollView:insert(teks14);

     local options = {
		 text = [["Bismillahi  Wallahu-Akbar"]],
         x = display.contentWidth*0.05,
         y = teks14.y + teks14.height + display.contentHeight/25,
         font = "Raleway-Bold.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	 local teks15 = display.newText(options)
     teks15.anchorX = 0
     teks15.anchorY = 0
     teks15:setFillColor(0);
     scrollView:insert(teks15);

     local options = {
         text = [[Artinya : 

“Dengan menyebut nama Allah dan Allah Mahabesar”
]],
         x = display.contentWidth*0.05,
         y = teks15.y + teks15.height + display.contentHeight/40,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.8 * display.contentWidth)
     }


     local teks16 = display.newText(options)
     teks16.anchorX = 0
     teks16.anchorY = 0
     teks16:setFillColor(0);
     scrollView:insert(teks16);


      local options = {
         text = [[Lalu mengusapnya dengan tangan kanan dan menciumnya. Jika tidak memungkinkan untuk menciumnya, maka cukup dengan mengusapnya, lalu mencium tangan yang mengusap hajar Aswad. Jika tidak memungkinkan untuk mengusapnya, maka cukup dengan memberi isyarat kepadanya dengan tangan, namun tidak mencium tangan yang memberi isyarat.]],
         x = display.contentWidth*0.05,
         y = teks16.y + teks16.height + display.contentHeight/20,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	 local teks17 = display.newText(options)
     teks17.anchorX = 0
     teks17.anchorY = 0
     teks17:setFillColor(0);
     scrollView:insert(teks17);


     local options = {
		 text = "4.	Memulai thawaf umroh sebanyak tujuh putaran",
         x = display.contentWidth*0.05,
         y = teks17.y + teks17.height + display.contentHeight/25,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	 local teks18 = display.newText(options)
     teks18.anchorX = 0
     teks18.anchorY = 0
     teks18:setFillColor(205/255,176/255,48/255);
     scrollView:insert(teks18);


     local options = {
         text = [[Thawaf dimulai dan diakhiri di Hajar Aswad. Disunnahkan berlari-lari kecil pada tiga putaran pertama dan berjalan biasa pada putaran terakhir.

Berikut adalah beberapa doa yang bisa Anda baca pada setiap putaran thawaf;
]],
         x = display.contentWidth*0.05,
         y = teks18.y + teks18.height + display.contentHeight/20,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	 local teks19 = display.newText(options)
     teks19.anchorX = 0
     teks19.anchorY = 0
     teks19:setFillColor(0);
     scrollView:insert(teks19);

     local line = display.newLine( 0, teks19.y + teks19.height + display.contentHeight/20, display.contentWidth, teks19.y + teks19.height + display.contentHeight/20 )
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
		

	

          
        display.remove(scrollView_banner)  
	
		display.remove(scrollView)
		display.remove(scrollView2)

        network.cancel( download )
        
        if(video ~= nil)then
            video:pause()
            video:removeSelf()
            video = nil
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