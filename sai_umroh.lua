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
            if(row.video19 == '0')then

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
                            transfered.text = event.bytesTransferred.."/29574902"
                            print( "Download progress: " .. event.bytesTransferred )

                        else
                            transfered.text = event.bytesTransferred.."/29574902"
                            print( "Download progress: " .. event.bytesTransferred .. " of estimated: " .. event.bytesEstimated )
                        end
                         
                    elseif ( event.phase == "ended" ) then
                        print( "Download complete, total bytes transferred: " .. event.bytesTransferred )
                        transfered.text = event.bytesEstimated.."/29574902"


                         local tablesetup = [[UPDATE t_video set video19 = '1';]]
                         db:exec( tablesetup )


                        background2.alpha = 0
                        transfered.alpha = 0
                        downloading.alpha = 0
                        logo.alpha = 1

                        video = native.newVideo( display.contentCenterX, 0, display.contentWidth,  display.contentHeight/3 )
                        video.anchorY = 0
                        video:load( "video19.mp4", system.DocumentsDirectory )
                        video:play()
                        sceneGroup:insert(video)
                        -- media.playVideo( "video1.mp4", system.TemporaryDirectory, true )

                        local function on_video()

                            background2.alpha = 1
                            video:pause()
                            video:removeSelf()
                            video = nil
                            logo:addEventListener("tap", on_play)
                            media.playVideo( "video19.mp4", system.DocumentsDirectory, true )
                        end
                        full:addEventListener("tap", on_video)
                    end
                end
                 
                local params = {}
                params.progress = true

                download = network.download(
                    "http://bursasajadah.com/video/pelaksanaan_ibadah_haji-sai.mp4",
                    "GET",
                    networkListener,
                    params,
                    "video19.mp4",
                    system.DocumentsDirectory
                )
            else
                print("masuk else")

                background2.alpha = 0
                transfered.alpha = 0
                downloading.alpha = 0
                video = native.newVideo( display.contentCenterX, 0, display.contentWidth,  display.contentHeight/3 )
                video.anchorY = 0
                video:load( "video19.mp4", system.DocumentsDirectory )
                video:play()
                sceneGroup:insert(video)

                local function on_video()
                    print("on video")
                    background2.alpha = 1
                    video:pause()
                    video:removeSelf()
                    video = nil
                    logo:addEventListener("tap", on_play)
                    media.playVideo( "video19.mp4", system.DocumentsDirectory, true )
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
         text = "Sa'i",
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
		 text = "Sa’i adalah berlari-lari kecil diantara bukit Safa dan Marwah sebanyak tujuh kali putaran.",
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
         text = "قَالَ رَسُوْلُ اللهِ صَلَّى اللهُ عَلَيْهِ وَآلِهِ وَسَلَّمَ : اسْعَوْا فَإِنَّ اللَّهَ كَتَبَ عَلَيْكُمُ السَّعْيَ  (وروى الدارقطني ، البيهقي حديث حسن)",
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

“Wahai manusia bersa’ilah kamu, sesungguhnya Allah telah mewajibkan sa’i atas kamu” (HR Ad-Dar qutni, Al-Baihaqi, hadits hasan).]],
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
		 text = "Tata Cara Sa'i:",
         x = display.contentWidth*0.05,
         y = teks3.y + teks3.height + display.contentHeight/25,
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
		 text = "1.	Menuju ke bukit Safa untuk memulai sa’i",
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
		 text = "Jika sudah mendakati bukit Shafa, membaca;",
         x = display.contentWidth*0.05,
         y = teks5.y + teks5.height + display.contentHeight/25,
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
         text = "إِنَّ الصَّفاَ وَالمَرْوَةَ مِنْ شَعَآئِرِ اللهِ",
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
		 text = [[“Innash shafaa wal marwata min sya’airillah”]],
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
         text = [[Artinya:

“Sesungguhnya Shafa dan Marwa adalah sebagian dari syi’ar-syi’ar Allah.” (Al-Baqarah:158)

Kemudian mengucapkan;
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
         text = "نَبْدَأُ بِمَا بَدَأَ اللَّهُ بِهِ",
         x = display.contentWidth*0.05,
         y = teks9.y + teks9.height + display.contentHeight/20,
         font = "Roboto.ttf",
         fontSize = 25  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
     }



     local teks10 = display.newText(options)
     teks10.anchorX = 0
     teks10.anchorY = 0
     teks10:setFillColor(0);
     scrollView:insert(teks10);
     

     local options = {
		 text = [[“Nabda-u bimaa bada-allah bih”.]],
         x = display.contentWidth*0.05,
         y = teks10.y + teks10.height + display.contentHeight/25,
         font = "Raleway-Bold.ttf",
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
		 text = "2.	Menaiki bukit Shafa, lalu menghadap ke arah Ka’bah hingga melihatnya, kemudian membaca:",
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
         text = "أَللهُ أَكْبَرُ أَللهُ أَكْبَرُ أَللهُ أَكْبَرُ وَِللهِ الحَمْدُ , أَللهُ أَكْبَرُ عَلَى ماَ هَداَناَ وَالحَمْدُ ِللهِ عَلَى ماَ أَوْلاَناَ . لاَإِلَهَ إِلاَّ اللهُ وَحْدَهُ لاَشَرِيْكَ لَهُ , لَهُ المُلْكُ وَلَهُ الحَمْدُ يُحْيِى وَيُمِيْتُ بِيَدِهِ الخَيْرُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ . لاَإِلَهَ إِلاَّ اللهُ وَحْدَهُ لاَ شَرِيْكَ لَهُ أَنْجَزَ وَعْدَهُ وَنَصَرَ عَبْدَهُ وَهَزَمَ الأَحْزاَبَ وَحْدَهُ لاَ إِلَهَ إِلاَّ اللهُ وَلاَ نَعْبُدُ إِلاَّ إِياَهُ مُخْلِصِيْنَ لَهُ الدِّيْنَ وَلَوْ كَرِهَ الكاَفِرُوْنَ",
         x = display.contentWidth*0.05,
         y = teks12.y + teks12.height + display.contentHeight/20,
         font = "Roboto.ttf",
         fontSize = 25  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
     }


     local teks13 = display.newText(options)
     teks13.anchorX = 0
     teks13.anchorY = 0
     teks13:setFillColor(0);
     scrollView:insert(teks13);



     local options = {
		 text = [[Allahu Akbar, Allahu Akbar, Allahu Akbar walillahil hamdu. Allahu Akbar 'alama hadana walhamdulillahi 'alama aulana la ilaha illalahu wahdahu la syarika lahu, lahul mulku walahul hamdu yuhyi wayumitu biyadihil khairu wahuwa 'ala kulli syai inqadir. La ilaha illallahu wahdahu lasyarika lah, anjaza wa'dahu wanasara 'abdahu wahazamal ahzaba wahdah, la ilaha illallahu wala na' buduilla iyyahu mukhilisina lahuddina walau karihal kafirun]],
         x = display.contentWidth*0.05,
         y = teks13.y + teks13.height + display.contentHeight/25,
         font = "Raleway-Bold.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	 local teks14 = display.newText(options)
     teks14.anchorX = 0
     teks14.anchorY = 0
     teks14:setFillColor(0);
     scrollView:insert(teks14);



     local options = {
         text = [[Artinya:

“Allah Mahabesar, Allah Mahabesar, Allah Mahabesar. Segala puji bagi Allah, Allah Mahabesar, atas petunjuk yang diberikan-Nya kepada kami, segala puji bagi Alloh atas karunia yang telah dianugerahkan-Nya kepada kami, tidak ada Tuhan selain Alloh Yang Maha Esa, tidak ada sekutu bagi Nya. Bagi-Nya kerajaan dan pujian. Dialah yang menghidupkan dan mematikan, pada kekuasaan-Nya lah segala kebaikan dan Dia berkuasa atas segala sesuatu, Tiada Tuhan Selain Alloh Yang Maha Esa, tidak ada sekutu bagi-Nya, yang telah menepati janji-Nya, menolong hamba-Nya dan menghancurkan sendiri musuh-musuh-Nya, Tidak ada Tuhan selain Alloh dan kami tidak menyembah kecuali kepada-Nya dengan memurnikan (ikhlas) kepatuhan semata kepada-Nya,  walaupun orang- orang kafir membenci.”
Bacaan diatas diulang sebanyak tiga kali dan berdoa diantara pengulangan-pengulangan itu dengan doa apa saja yang dikehendaki.

]],
         x = display.contentWidth*0.05,
         y = teks14.y + teks14.height + display.contentHeight/40,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.8 * display.contentWidth)
     }


     local teks15 = display.newText(options)
     teks15.anchorX = 0
     teks15.anchorY = 0
     teks15:setFillColor(0);
     scrollView:insert(teks15);



     local options = {
		 text = "2.	Turun dari Shafa menuju ke Marwah",
         x = display.contentWidth*0.05,
         y = teks15.y + teks15.height + display.contentHeight/25,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	 local teks16 = display.newText(options)
     teks16.anchorX = 0
     teks16.anchorY = 0
     teks16:setFillColor(205/255,176/255,48/255);
     scrollView:insert(teks16);




      local options = {
		 text = "Disunnahkan berlari-lari kecil dengan cepat di antara dua tanda lampu hijau bagi laki-laki, lalu berjalan biasa menuju Marwah dan menaikinya. (Dilakukan juga saat perjalanan dari Marwah ke Shafa).",
         x = display.contentWidth*0.05,
         y = teks16.y + teks16.height + display.contentHeight/25,
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
		 text = "3.	Sesampainya di Marwah, lakukan amalan-amalan yang dikerjakan di Shafa; menghadap ke arah Ka’bah dan membaca;",
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
         text = "َللهُ أَكْبَرُ أَللهُ أَكْبَرُ أَللهُ أَكْبَرُ وَِللهِ الحَمْدُ , أَللهُ أَكْبَرُ عَلَى ماَ هَداَناَ وَالحَمْدُ ِللهِ عَلَى ماَ أَوْلاَناَ . لاَإِلَهَ إِلاَّ اللهُ وَحْدَهُ لاَشَرِيْكَ لَهُ , لَهُ المُلْكُ وَلَهُ الحَمْدُ يُحْيِى وَيُمِيْتُ بِيَدِهِ الخَيْرُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ . لاَإِلَهَ إِلاَّ اللهُ وَحْدَهُ لاَ شَرِيْكَ لَهُ أَنْجَزَ وَعْدَهُ وَنَصَرَ عَبْدَهُ وَهَزَمَ الأَحْزاَبَ وَحْدَهُ لاَ إِلَهَ إِلاَّ اللهُ وَلاَ نَعْبُدُ إِلاَّ إِياَهُ مُخْلِصِيْنَ لَهُ الدِّيْنَ وَلَوْ كَرِهَ الكاَفِرُوْنَ",
         x = display.contentWidth*0.05,
         y = teks18.y + teks18.height + display.contentHeight/20,
         font = "Roboto.ttf",
         fontSize = 25  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
     }


     local teks19 = display.newText(options)
     teks19.anchorX = 0
     teks19.anchorY = 0
     teks19:setFillColor(0);
     scrollView:insert(teks19);



     local options = {
		 text = [[Allahu Akbar, Allahu Akbar, Allahu Akbar walillahil hamdu. Allahu Akbar 'alama hadana walhamdulillahi 'alama aulana la ilaha illalahu wahdahu la syarika lahu, lahul mulku walahul hamdu yuhyi wayumitu biyadihil khairu wahuwa 'ala kulli syai inqadir. La ilaha illallahu wahdahu lasyarika lah, anjaza wa'dahu wanasara 'abdahu wahazamal ahzaba wahdah, la ilaha illallahu wala na' buduilla iyyahu mukhilisina lahuddina walau karihal kafirun]],
         x = display.contentWidth*0.05,
         y = teks19.y + teks19.height + display.contentHeight/25,
         font = "Raleway-Bold.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	 local teks20 = display.newText(options)
     teks20.anchorX = 0
     teks20.anchorY = 0
     teks20:setFillColor(0);
     scrollView:insert(teks20);



     local options = {
         text = [[Artinya:

“Allah Mahabesar, Allah Mahabesar, Allah Mahabesar. Segala puji bagi Allah, Allah Mahabesar, atas petunjuk yang diberikan-Nya kepada kami, segala puji bagi Alloh atas karunia yang telah dianugerahkan-Nya kepada kami, tidak ada Tuhan selain Alloh Yang Maha Esa, tidak ada sekutu bagi Nya. Bagi-Nya kerajaan dan pujian. Dialah yang menghidupkan dan mematikan, pada kekuasaan-Nya lah segala kebaikan dan Dia berkuasa atas segala sesuatu, Tiada Tuhan Selain Alloh Yang Maha Esa, tidak ada sekutu bagi-Nya, yang telah menepati janji-Nya, menolong hamba-Nya dan menghancurkan sendiri musuh-musuh-Nya, Tidak ada Tuhan selain Alloh dan kami tidak menyembah kecuali kepada-Nya dengan memurnikan (ikhlas) kepatuhan semata kepada-Nya,  walaupun orang- orang kafir membenci.”

]],
         x = display.contentWidth*0.05,
         y = teks20.y + teks20.height + display.contentHeight/40,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.8 * display.contentWidth)
     }

     local teks21 = display.newText(options)
     teks21.anchorX = 0
     teks21.anchorY = 0
     teks21:setFillColor(0);
     scrollView:insert(teks21);



      local options = {
		 text = "4.	Lakukan hal ini sampai tujuh kali hingga berakhir di Marwah",
         x = display.contentWidth*0.05,
         y = teks21.y + teks21.height + display.contentHeight/25,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	 local teks22 = display.newText(options)
     teks22.anchorX = 0
     teks22.anchorY = 0
     teks22:setFillColor(205/255,176/255,48/255);
     scrollView:insert(teks22);


     local options = {
		 text = "5.	Ketika sa’i tidak ada dzikir-dzikir tertentu, maka boleh berdzikir, berdoa, atau membaca bacaan-bacaan yang dikenhendaki.",
         x = display.contentWidth*0.05,
         y = teks22.y + teks22.height + display.contentHeight/25,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	 local teks23 = display.newText(options)
     teks23.anchorX = 0
     teks23.anchorY = 0
     teks23:setFillColor(205/255,176/255,48/255);
     scrollView:insert(teks23);






     local options = {
		 text = "Atau bisa juga mengamalkan doa ini:",
         x = display.contentWidth*0.05,
         y = teks23.y + teks23.height + display.contentHeight/25,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	 local teks24 = display.newText(options)
     teks24.anchorX = 0
     teks24.anchorY = 0
     teks24:setFillColor(0);
     scrollView:insert(teks24);
    


     local options = {
         text = "اللَّهُمَّ اغْفِرْ وَارْحَمْ وَأَنْتَ الأَعَزُّ الأَكْرَمُ",
         x = display.contentWidth*0.05,
         y = teks24.y + teks24.height + display.contentHeight/20,
         font = "Roboto.ttf",
         fontSize = 25  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
     }



     local teks25 = display.newText(options)
     teks25.anchorX = 0
     teks25.anchorY = 0
     teks25:setFillColor(0);
     scrollView:insert(teks25);


     local options = {
		 text = [[Allahummaghfirli warham wa antal a’azzul akrom]],
         x = display.contentWidth*0.05,
         y = teks25.y + teks25.height + display.contentHeight/25,
         font = "Raleway-Bold.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	 local teks26 = display.newText(options)
     teks26.anchorX = 0
     teks26.anchorY = 0
     teks26:setFillColor(0);
     scrollView:insert(teks26);



     local options = {
         text = [[Artinya:

“Ya Rabbku, ampuni dan rahmatilah aku. Sesungguhnya Engkaulah Yang Maha Perkasa dan Maha Pemurah”
]],
         x = display.contentWidth*0.05,
         y = teks26.y + teks26.height + display.contentHeight/40,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.8 * display.contentWidth)
     }


     local teks27 = display.newText(options)
     teks27.anchorX = 0
     teks27.anchorY = 0
     teks27:setFillColor(0);
     scrollView:insert(teks27);


     local line = display.newLine( 0, teks27.y + teks27.height + display.contentHeight/20, display.contentWidth, teks27.y + teks27.height + display.contentHeight/20 )
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


        if(video ~= nil)then
            video:pause()
            video:removeSelf()
            video = nil
        end

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