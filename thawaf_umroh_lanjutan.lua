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
            if(row.video20 == '0')then

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
                            transfered.text = event.bytesTransferred.."/36336665"
                            print( "Download progress: " .. event.bytesTransferred )

                        else
                            transfered.text = event.bytesTransferred.."/36336665"
                            print( "Download progress: " .. event.bytesTransferred .. " of estimated: " .. event.bytesEstimated )
                        end
                         
                    elseif ( event.phase == "ended" ) then
                        print( "Download complete, total bytes transferred: " .. event.bytesTransferred )
                        transfered.text = event.bytesEstimated.."/36336665"


                         local tablesetup = [[UPDATE t_video set video20 = '1';]]
                         db:exec( tablesetup )


                        background2.alpha = 0
                        transfered.alpha = 0
                        downloading.alpha = 0
                        logo.alpha = 1

                        video = native.newVideo( display.contentCenterX, 0, display.contentWidth,  display.contentHeight/3 )
                        video.anchorY = 0
                        video:load( "video20.mp4", system.DocumentsDirectory )
                        video:play()
                        sceneGroup:insert(video)
                        -- media.playVideo( "video1.mp4", system.TemporaryDirectory, true )

                        local function on_video()

                            background2.alpha = 1
                            video:pause()
                            video:removeSelf()
                            video = nil
                            logo:addEventListener("tap", on_play)
                            media.playVideo( "video20.mp4", system.DocumentsDirectory, true )
                        end
                        full:addEventListener("tap", on_video)
                    end
                end
                 
                local params = {}
                params.progress = true

                download = network.download(
                    "http://bursasajadah.com/video/pelaksanaan_ibadah_haji-sesudah_thawaf.mp4",
                    "GET",
                    networkListener,
                    params,
                    "video20.mp4",
                    system.DocumentsDirectory
                )
            else
                print("masuk else")

                background2.alpha = 0
                transfered.alpha = 0
                downloading.alpha = 0
                video = native.newVideo( display.contentCenterX, 0, display.contentWidth,  display.contentHeight/3 )
                video.anchorY = 0
                video:load( "video20.mp4", system.DocumentsDirectory )
                video:play()
                sceneGroup:insert(video)

                local function on_video()
                    print("on video")
                    background2.alpha = 1
                    video:pause()
                    video:removeSelf()
                    video = nil
                    logo:addEventListener("tap", on_play)
                    media.playVideo( "video20.mp4", system.DocumentsDirectory, true )
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



	local teks_judul = display.newText("Thawaf Lanjutan",display.contentWidth*0.05 , 0 + display.contentHeight/20, "Roboto.ttf", 20  * (display.contentWidth / 320)  )
    teks_judul.anchorX = 0
    teks_judul.anchorY = 0
    teks_judul:setFillColor(205/255,176/255,48/255);
    scrollView:insert(teks_judul);


	local options = {
         text = "3. Disunnahkan mengusap Rukun Yamani disetiap putaran thawaf (tidak dianjurkan untuk menciumnya atau memberi isyarat kepadanya)",
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
     teks1:setFillColor(205/255,176/255,48/255);
     scrollView:insert(teks1);


     local options = {
         text = "4. Ketika berada diantara Rukun Yamani dan Hajar Aswad disunnahkan membaca;",
         x = display.contentWidth*0.05,
         y = teks1.y + teks1.height + display.contentHeight/25,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
     }


     local teks2 = display.newText(options)
     teks2.anchorX = 0
     teks2.anchorY = 0
     teks2:setFillColor(205/255,176/255,48/255);
     scrollView:insert(teks2);


     local options = {
         text = [[رَبَّنَا اَتِنَا فِى الدُّنْيَا حَسَنَةً وَفِى الْأَخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ
وَاَدْ خِلْنَا الْجَنَّةَ مَعَ الْأَبْرَارِ. يَاعَزِيْزُيَا غَفَّارُيَا رَبَّ الْعَالَمِيْنَ
]],
         x = display.contentWidth*0.05,
         y = teks2.y + teks2.height + display.contentHeight/20,
         font = "Roboto.ttf",
         fontSize = 25  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
     }



     local teks3 = display.newText(options)
     teks3.anchorX = 0
     teks3.anchorY = 0
     teks3:setFillColor(0);
     scrollView:insert(teks3);

     local options = {
         text = [[Robbanaa aatinaa fid-dunyaa hasanatan wa fil-aakhirti hasanatan wa qinaa 'adzaaban-naar. Wa-adkhilnal-jannata ma'al-abroor, yaa 'aziiz yaa ghoffaar yaa robbal-'aalamiin.]],
         x = display.contentWidth*0.05,
         y = teks3.y + teks3.height + display.contentHeight/25,
         font = "Raleway-Bold.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
     }


     local teks4 = display.newText(options)
     teks4.anchorX = 0
     teks4.anchorY = 0
     teks4:setFillColor(0);
     scrollView:insert(teks4);



     local options = {
         text = [[Artinya:

"Wahai Tuhan kami, berilah kami kebaikan di dunia dan kebaikan di akhirat dan hindarkanlah kami dari siksa neraka". "Dan masukkanlah kami ke dalam surga bersama orang-orang yang berbuat baik, wahai Tuhan Yang Maha Perkasa, Maha Pengampun dan Tuhan yang menguasai seluruh alam".]],
         x = display.contentWidth*0.05,
         y = teks4.y + teks4.height + display.contentHeight/40,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.8 * display.contentWidth)
     }


     local teks5 = display.newText(options)
     teks5.anchorX = 0
     teks5.anchorY = 0
     teks5:setFillColor(0);
     scrollView:insert(teks5);



     local options = {
         text = "5. Usai melaksankan thawaf, bergeserlah sedikit ke kanan dari arah sudut Hajar Aswad mengahadap dinding Ka’bah yang disebut Multazam, dan berdoa sesuai harapan. ",
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
     teks6:setFillColor(205/255,176/255,48/255);
     scrollView:insert(teks6);



     local options = {
         text = [[Salah satu doa di Multazam yang dianjurkan;]],
         x = display.contentWidth*0.05,
         y = teks6.y + teks6.height + display.contentHeight/40,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.8 * display.contentWidth)
     }


     local teks7 = display.newText(options)
     teks7.anchorX = 0
     teks7.anchorY = 0
     teks7:setFillColor(0);
     scrollView:insert(teks7);
 


     local options = {
         text = [[اللّهُمَّ يَارَبَّ الْبَيْتِ الْعَتِيْقِ اَعْتِقِ رِقَابَنَا وَرِقَابَ ابَائِنَا وَأُمَّهَاتِنَا وَإِخْوَانِنَا وَأَوْلاَدِنَا مِنَ النَّارِ يَاذَا الْجُوْدِ وَالْكَرَمِ وَالْفَضْلِ وَالْمَنِّ وَالْعَطَاءِ وَالْاِحْسَانِ. اَللَّهُمَّ اَحْسِنْ عَاقِبَتَنَا فِى الْأُمُوْرِ كُلِّهَا وَاَجِرْنَامِنْ خِزْيِ الدُّنْيَا وَعَذَابِ الاَْخِرَةِ. اَللَّهُمَّ اِنِّيْ عَبْدُكَ وَابْنُ عَبْدِكَ وَاقِفٌ تَحْتَ بَابِكَ مُلْتَزِمٌ بِأَعْتَابِكَ مُتَذَلِّلُ بَيْنَ يَدَيْكَ أَرْجُوْ رَحْمَتَكَ وَاَخْشَى عَدَابَكَ ياَقَدِيْمَ اْلِإحْسَانِ. اَللَّهُمَّ اِنِّيْ أَسْأَلُكَ اَنْ تَرْفَعَ ذِكْرِيْ وَتَضَعَ وِزْرِيْ
وَتُصْلِحَ اَمْرِيْ وَتُطَهِّرُ قَلْبِيْ وَتُنَوِّرَ لِيْ فِيْ قَبْرِيْ وَتَغْفِرَلِيْ ذَنْبِيْ وَأَسْأَلُكَ الدَّرَجَاتِ اْلعُلىَ مِنَ اْلجَنَّةِ
]],
         x = display.contentWidth*0.05,
         y = teks7.y + teks7.height + display.contentHeight/20,
         font = "Roboto.ttf",
         fontSize = 25  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
     }



     local teks8 = display.newText(options)
     teks8.anchorX = 0
     teks8.anchorY = 0
     teks8:setFillColor(0);
     scrollView:insert(teks8);


     local options = {
         text = [[Allahumma yaa robbal-baitil-'atiiq, a'tiq riqaabanaa wa riqaaba aabaainaa wa ummahaatinaa wa ikhwaaninaa wa-aulaadinaa minan-naar, yaa dzal-juudi wal-karami wal-fadhli wal-manni wal-'athaai wal-ihsaani. Allahumma ahsin 'aaqibatanaa fil-umuuri kullihaa, wa ajirnaa min khizyi d-dunyaa wa adzaabi l-aakhirati. Allahumma inni 'abduka wa bnu 'abdika, waaqifun tahta baabika, multazimun bi a'taabika, mutadzallilun baina yadaika arjuu rahmataka wa akhsyaa adzabaka, yaa qadiimal-ihsaan. Allahumma innii as'aluka an tarfa'a dzikrii wa tadha'a wizrii wa tushliha amrii wa tuthahhira qalbii wa tunawwira lii fii qabrii wa taghfira lii dzanbii wa as'alukad-darajaatil-'ulaa minal-jannah.]],
         x = display.contentWidth*0.05,
         y = teks8.y + teks8.height + display.contentHeight/25,
         font = "Raleway-Bold.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
     }


     local teks9 = display.newText(options)
     teks9.anchorX = 0
     teks9.anchorY = 0
     teks9:setFillColor(0);
     scrollView:insert(teks9);




     local options = {
         text = [[Artinya:

"Ya Allah, yang memelihara Ka'bah ini, bebaskan diri kami, bapak-bapak dan ibu-ibu kami, saudara-saudara dan anak-anak kami dari siksa neraka, wahai Tuhan yang maha Pemurah, Dermawan, dan yang mempunyai keutamaan, kemuliaan, kelebihan, anugerah, pemberian dan kebaikan. Ya Allah, perbaikilah kesudahan segenap urusan kami dan jauhkanlah dari kehinaan dunia dan siksa akhirat. Ya Allah, sesungguhnya aku adalah hambaMu, anak hambaMu, berdiri dibawah pintuMu, menundukkan diri di hadapanMu sambil mengharapkan rahmatMu, kasih-sayangMu, dan takut akan siksaMu. Wahai Tuhan pemilik kebaikan abadi, aku mohon kepadaMu agar Engkau tinggikan namaku, hapuskan dosaku, perbaiki segala urusanku, bersihkan hatiku, berilah cahaya didalam kuburku. Ampunilah dosaku dan aku mohon padaMu martabat yang tinggi didalam surga".]],
         x = display.contentWidth*0.05,
         y = teks9.y + teks9.height + display.contentHeight/40,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.8 * display.contentWidth)
     }


     local teks10 = display.newText(options)
     teks10.anchorX = 0
     teks10.anchorY = 0
     teks10:setFillColor(0);
     scrollView:insert(teks10);



     local options = {
         text = "6. Menuju ke maqam ibrahim sambil membaca",
         x = display.contentWidth*0.05,
         y = teks10.y + teks10.height + display.contentHeight/25,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
     }


     local teks11 = display.newText(options)
     teks11.anchorX = 0
     teks11.anchorY = 0
     teks11:setFillColor(205/255,176/255,48/255);
     scrollView:insert(teks11);



     local options = {
         text = [[وَاتَّخِذُوا مِنْ مَقَامِ إِبْرَاهِيمَ مُصَلًّى ]],
         x = display.contentWidth*0.05,
         y = teks11.y + teks11.height + display.contentHeight/20,
         font = "Roboto.ttf",
         fontSize = 25  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
     }



     local teks12 = display.newText(options)
     teks12.anchorX = 0
     teks12.anchorY = 0
     teks12:setFillColor(0);
     scrollView:insert(teks12);


     local options = {
         text = [[Waattakhidzuu min maqaami ibraahiima mushallan]],
         x = display.contentWidth*0.05,
         y = teks12.y + teks12.height + display.contentHeight/25,
         font = "Raleway-Bold.ttf",
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
         text = [[Artinya:

Dan jadikanlah Maqom Ibrahim sebagai tempat sholat”. (Al-Baqarah: 125)]],
         x = display.contentWidth*0.05,
         y = teks13.y + teks13.height + display.contentHeight/40,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.8 * display.contentWidth)
     }


     local teks14 = display.newText(options)
     teks14.anchorX = 0
     teks14.anchorY = 0
     teks14:setFillColor(0);
     scrollView:insert(teks14);



      local options = {
         text = "7. Shalat sunnah Thawaf dua raka’at di belakang Maqam Ibrahim",
         x = display.contentWidth*0.05,
         y = teks14.y + teks14.height + display.contentHeight/25,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
     }


     local teks15 = display.newText(options)
     teks15.anchorX = 0
     teks15.anchorY = 0
     teks15:setFillColor(205/255,176/255,48/255);
     scrollView:insert(teks15);




      local options = {
         text = [[وَاتَّخِذُوا مِنْ مَقَامِ إِبْرَاهِيمَ مُصَلًّى ]],
         x = display.contentWidth*0.05,
         y = teks11.y + teks11.height + display.contentHeight/20,
         font = "Roboto.ttf",
         fontSize = 25  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
     }



     local teks12 = display.newText(options)
     teks12.anchorX = 0
     teks12.anchorY = 0
     teks12:setFillColor(0);
     scrollView:insert(teks12);


     local options = {
         text = [[Waattakhidzuu min maqaami ibraahiima mushallan]],
         x = display.contentWidth*0.05,
         y = teks12.y + teks12.height + display.contentHeight/25,
         font = "Raleway-Bold.ttf",
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
         text = [[Artinya:

Dan jadikanlah Maqom Ibrahim sebagai tempat sholat”. (Al-Baqarah: 125)]],
         x = display.contentWidth*0.05,
         y = teks13.y + teks13.height + display.contentHeight/40,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.8 * display.contentWidth)
     }


     local teks14 = display.newText(options)
     teks14.anchorX = 0
     teks14.anchorY = 0
     teks14:setFillColor(0);
     scrollView:insert(teks14);

     local options = {
         text = [[Raka’at pertama setelah membaca Al-Fatihah dianjurkan membaca surat Al-Kafirun dan membaca surat Al-Ikhlas pada raka’at kedua setelah Al-Fatihah.
Usai melaksanakan shalat tersebut, dianjurkan untuk membaca doa berikut ini:
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
         text = [[اللّهُمَّ إِنَكَ تَعْلَمُ سِرِّيْ وَعَلَا نِيَتِيْ فَاقْبَلْ مَعْذِرَتِيْ وَتَعْلَمُ حَاجَتِيْ فَاعْطِنِيْ سُؤْلِيْ وَتَعْلَمُ مَا فِيْ نَفْسِيْ فَاغْفِرْلِيْ ذُنُوْبِيْ اَللَّهُمَّ إِنِّيْ أَسْأَلُكَ اِيْمَانًا دَائِمًا يُبَاشِرُ قَلْبِيْ إِلَّامَا كَتَبْتَ لِيْ وَرَضِّنِيْ بِمَا قَسَمْتَهُ لِيْ يَاأَرْحَمَ الرَّا حِمِيْنَ. اَنْتَ وَلِيِّيْ فِى الدُّيْيَا وَالْاَخِرَةِ تَوَفَّنِيْ مُسْلِمًا وَأَلْحِقْنِيْ بِالصَّا لِحِيْنَ اللَّهُمَّ لاَ تَدَعْ لَنَا فِيْ مَقَامِنَا هَذَا ذَنْبًا اِلَّا غَفَرْتَهُ وَلَاهَمًّا اِلَّا فَرّّجْتَهُ وَلَا حَاجَةً إِلاَّ قَضَيْتَهَا وَيَسَّرْتَهَا فَيَسِّرْ أُمُوْرَنَا وَاشْرَحْ صُدُوْرَنَا وَنَوِّرْ قُلُوْبَنَا وَاخْتِمْ بِالصَّا لِحَاتِ أَعْمَالَنَا. اللَّهُمَّ تَوُفَّنَا مُسْلِمِيْنَ وَاَحْيِنَا مُسْلِمِيْنَ وَأَلْحِقْنَا بِالصَّا لِحِيْنَ غَيْرَ خَزَايَا وَلاَ مَفْتُوْنِيْنَ]],
         x = display.contentWidth*0.05,
         y = teks16.y + teks16.height + display.contentHeight/20,
         font = "Roboto.ttf",
         fontSize = 25  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
     }



     local teks17 = display.newText(options)
     teks17.anchorX = 0
     teks17.anchorY = 0
     teks17:setFillColor(0);
     scrollView:insert(teks17);


     local options = {
         text = [[Allahumma innaka ta'lamu sirri wa 'alaaniyatii faqbal ma'dziratii wa ta'lamu haajatii fa'thinii su'lii wa ta'lamu maa fii nafsii faghfir lii dzunuubii. Allahumma inii as'aluka iimaanan daa'iman yubasyiru qalbii, wa yaqiinan shaadiqan hattaa a'lamu annahuu laa yushiibunii illaa maa katabta lii waraddlinii bimaa qosamtahulii yaa-arhamarrohimin, Anta waliyyii fid-dunyaa wal-aakhirah, tawaffanii musliman wa alhiqnii bish-sholihiin. Allahumma laa tada' lanaa fii maqaaminaa haadzaa dzanban illaa ghafartahu wa laa hamman illaa farrajtahu, wa laa haajatan  illaa qadhaitahaa wa yassartahaa, fa yassir umuuranaa, wasyrah shuduuranaa, wa nawwir quluubana, wakhtim bish-shoolihaati a'maalanaa. Allahumma tawaffanaa muslimiina wa-ahyinaa muslimiinaa  wa alhiqnaa bish-shoolihiina ghaira khazaayaa wa laa maftuuniin"]],
         x = display.contentWidth*0.05,
         y = teks17.y + teks17.height + display.contentHeight/25,
         font = "Raleway-Bold.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
     }


     local teks18 = display.newText(options)
     teks18.anchorX = 0
     teks18.anchorY = 0
     teks18:setFillColor(0);
     scrollView:insert(teks18);

     local options = {
         text = [[Artinya:

“Ya Allah, sesungguhnya Engkau Maha Mengetahui rahasiaku yang tersebunyi dan amal perbuatanku yang nyata, maka terimalah ratapanku. Engkau Maha Mengetahui keperluanku, maka kabulkanlah permintaanku. Engkau Maha Mengetahui apapun yang terkandung dalam hatiku, maka ampunilah dosaku. Ya Allah, aku mohon padaMu iman yang tetap melekat terus di hati, keyakinan yang sungguh-sungguh sehingga aku mengetahui bahwa tiada suatu yang menimpaku kecuali yang telah Engkau tetapkan bagiku, rela menerima apa yang telah Engkau bagikan kepadaku. Engkaulah Pelindungku di dunia dan akhirat, wafatkanlah aku dalam keadaan muslim dan masukkanlah kedalam orang-orang yang saleh. Ya Allah, janganlah Engkau biarkan di tempat kami ini suatu dosa kecuali Engkau ampuni, tiada kesusahan hati kecuali Engkau lapangkan, tiada suatu hajat kecuali Engkau penuhi dan mudahkan, maka mudahkanlah segenap urusan kami dan lapangkanlah dada kami, terangilah hati kami dan sudahilah semua amal kami dengan amal yang saleh. Ya Allah, matikan kami dalam keadaan muslim, hidupkanlah kami dalam keadaan muslim dan masukkanlah kami kedalam golongan orang-orang yang saleh, tanpa kenistaan dan fitnah”.]],
         x = display.contentWidth*0.05,
         y = teks18.y + teks18.height + display.contentHeight/40,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.8 * display.contentWidth)
     }


     local teks19 = display.newText(options)
     teks19.anchorX = 0
     teks19.anchorY = 0
     teks19:setFillColor(0);
     scrollView:insert(teks19);



      local options = {
         text = "8. Setelah shalat, disunnahkan minum air zam-zam  dan menyirami kepala dengannya",
         x = display.contentWidth*0.05,
         y = teks19.y + teks19.height + display.contentHeight/25,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
     }


     local teks20 = display.newText(options)
     teks20.anchorX = 0
     teks20.anchorY = 0
     teks20:setFillColor(205/255,176/255,48/255);
     scrollView:insert(teks20);


      local options = {
         text = "9. Kembali ke Hajar Aswad, lakukan seperti sebelumnya",
         x = display.contentWidth*0.05,
         y = teks20.y + teks20.height + display.contentHeight/25,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
     }


     local teks21 = display.newText(options)
     teks21.anchorX = 0
     teks21.anchorY = 0
     teks21:setFillColor(205/255,176/255,48/255);
     scrollView:insert(teks21);





     local options = {
         text = [[Berjalan hingga sejajar dengan Hajar Aswad, sambil bertakbir:]],
         x = display.contentWidth*0.05,
         y = teks21.y + teks21.height + display.contentHeight/40,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.8 * display.contentWidth)
     }


     local teks22 = display.newText(options)
     teks22.anchorX = 0
     teks22.anchorY = 0
     teks22:setFillColor(0);
     scrollView:insert(teks22);





      local options = {
         text = [[بِسْمِ اللهِ وَاللهُ أَكْبَرُ]],
         x = display.contentWidth*0.05,
         y = teks22.y + teks22.height + display.contentHeight/20,
         font = "Roboto.ttf",
         fontSize = 25  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
     }



     local teks23 = display.newText(options)
     teks23.anchorX = 0
     teks23.anchorY = 0
     teks23:setFillColor(0);
     scrollView:insert(teks23);


     local options = {
         text = [[Bismillahi  Wallahu-Akbar]],
         x = display.contentWidth*0.05,
         y = teks23.y + teks23.height + display.contentHeight/25,
         font = "Raleway-Bold.ttf",
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
         text = [[Artinya:
“Dengan menyebut nama Allah dan Allah Mahabesar”


Lalu mengusapnya dengan tangan kanan dan menciumnya. Jika tidak memungkinkan untuk menciumnya, maka cukup dengan mengusapnya, lalu mencium tangan yang mengusap hajar Aswad. Jika tidak memungkinkan untuk mengusapnya, maka cukup dengan memberi isyarat kepadanya dengan tangan, namun tidak mencium tangan yang memberi isyarat.
]],
         x = display.contentWidth*0.05,
         y = teks24.y + teks24.height + display.contentHeight/40,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.8 * display.contentWidth)
     }


     local teks25 = display.newText(options)
     teks25.anchorX = 0
     teks25.anchorY = 0
     teks25:setFillColor(0);
     scrollView:insert(teks25);

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
		

	   if(video ~= nil)then
            video:pause()
            video:removeSelf()
            video = nil
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