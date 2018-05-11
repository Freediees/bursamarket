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
            if(row.video4 == '0')then

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
                            transfered.text = event.bytesTransferred.."/"..event.bytesEstimated
                            print( "Download progress: " .. event.bytesTransferred )

                        else
                            transfered.text = event.bytesTransferred.."/"..event.bytesEstimated
                            print( "Download progress: " .. event.bytesTransferred .. " of estimated: " .. event.bytesEstimated )
                        end
                         
                    elseif ( event.phase == "ended" ) then
                        print( "Download complete, total bytes transferred: " .. event.bytesTransferred )
                        transfered.text = event.bytesEstimated.."/"..event.bytesEstimated


                         local tablesetup = [[UPDATE t_video set video4 = '1';]]
                         db:exec( tablesetup )


                        background2.alpha = 0
                        transfered.alpha = 0
                        downloading.alpha = 0
                        logo.alpha = 1

                        video = native.newVideo( display.contentCenterX, 0, display.contentWidth,  display.contentHeight/3 )
                        video.anchorY = 0
                        video:load( "video4.mp4", system.DocumentsDirectory )
                        video:play()
                        sceneGroup:insert(video)
                        -- media.playVideo( "video1.mp4", system.TemporaryDirectory, true )

                        local function on_video()

                            background2.alpha = 1
                            video:pause()
                            video:removeSelf()
                            video = nil
                            logo:addEventListener("tap", on_play)
                            media.playVideo( "video4.mp4", system.DocumentsDirectory, true )
                        end
                        full:addEventListener("tap", on_video)
                    end
                end
                 
                local params = {}
                params.progress = true

               download =  network.download(
                    "http://bursasajadah.com/video/pelaksanaan_ibadah_haji-ihram.mp4",
                    "GET",
                    networkListener,
                    params,
                    "video4.mp4",
                    system.DocumentsDirectory
                )
            else
                print("masuk else")

                background2.alpha = 0
                transfered.alpha = 0
                downloading.alpha = 0
                video = native.newVideo( display.contentCenterX, 0, display.contentWidth,  display.contentHeight/3 )
                video.anchorY = 0
                video:load( "video4.mp4", system.DocumentsDirectory )
                video:play()
                sceneGroup:insert(video)

                local function on_video()
                    print("on video")
                    background2.alpha = 1
                    video:pause()
                    video:removeSelf()
                    video = nil
                    logo:addEventListener("tap", on_play)
                    media.playVideo( "video4.mp4", system.DocumentsDirectory, true )
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

	local teks_judul = display.newText("Ihram",display.contentWidth*0.05 , 0 + display.contentHeight/20, "Roboto.ttf", 20  * (display.contentWidth / 320)  )
    teks_judul.anchorX = 0
    teks_judul.anchorY = 0
    teks_judul:setFillColor(205/255,176/255,48/255);
    scrollView:insert(teks_judul);


	local options = {
		 text = "Ihram adalah niat memulai manasik ibadah haji atau umroh.",
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
		 text = "1. Bersiap-siap sebelum berihram;",
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
		 text = [[1) Mandi
2) Memakai wewangian]],
         x = display.contentWidth*0.15,
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
		 text = [[Menggunakan wewangian disunnahkan dan diperbolehkan pada anggota badan, bukan pada pakaian]],
         x = display.contentWidth*0.05,
         y = teks3.y + teks3.height + display.contentHeight/20,
         font = "Roboto.ttf",
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
		 text = "كُنْتُ أُطَيِّبُ النَّبِيَّ لإِحْرَامِهِ قَبْلَ أَنْ يُحْرِمَ وَلِحِلِّهِ قَبْلَ أَنْ يَطُوْفَ بِاْلبَيْتِ",
         x = display.contentWidth*0.05,
         y = teks4.y + teks4.height + display.contentHeight/20,
         font = "Roboto.ttf",
         fontSize = 25  * (display.contentWidth / 320),
         align = "right",
         width = (0.9 * display.contentWidth)
 	 }


 	 local teks5 = display.newText(options)
     teks5.anchorX = 0
     teks5.anchorY = 0
     teks5:setFillColor(0);
     scrollView:insert(teks5);
     

     local options = {
		 text = [[Artinya:

Aku memakaikan wangi-wangian kepada nabi untuk ihramnya sebelum berihram dan ketika halalnya sebelum thawaf di Ka’bah” [HR. Bukhary no.1539 dan Muslim no. 1189]]..']',
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
		 text = [[3) Mencukur kumis atau jenggot, merapihan rambut, mencabut bulu ketiak dan bulu kemaluan
4) Menggunakan pakaian ihram]],
         x = display.contentWidth*0.15,
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
		 text = "1) Laki-Laki",
         x = display.contentWidth*0.05,
         y = teks7.y + teks7.height + display.contentHeight/25,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	 local teks8 = display.newText(options)
     teks8.anchorX = 0
     teks8.anchorY = 0
     teks8:setFillColor(205/255,176/255,48/255);
     scrollView:insert(teks8);


     local options = {
		 text = [[Pakaian ihram yang harus dikenakan oleh laki-laki yaitu berupa dua helai kain ihram berwarna putih
dan tidak berjahit, yaitu untuk menutup bagian bawah atau dikenakan sebagai sarung disebut Izzar,
dan satu helai kain lainnya digunakan sebagai selendang yang disebut Ridaa’. Tidak diperbolehkan
memakai sandal yang menutupi mata kaki dan memakai penutup kepala yang langsung melekat di
kepala, seperti sorban atau peci. Berikut adalah tata cara memakai kain ihram:

Step 1; 
pilihlah satu helai kain untuk digunakan di bagian bawah badan, yang akan digunakan sebagai
sarung. Kain yang digunakan merupakan kain yang lebih panjang.

Step 2; 
kemudian bentangkan kaki dan mulai sarungkan kain yang lebih panjang tadi ke badan.

Step 3; 
bentangkan tangan kanan sambil menggenggam dua ujung kain ihram yang disatukan, dan
tangan kiri diletakkan dibawah ketiak kanan untuk menahan lipatan kain.

Step 4; 
ujung kain ihram yang disatukan ditarik ke arah kiri, sedangkan tangan kanan bergantian
menahan lipatan dibawah ketiak.

Step 5; 
ujung kain ihram yang disatukan dilipat kedalam sehingga tidak kelihatan dari depan dan
nampak rapi.

Step 6; 
lipatan kain ihram digulung kebawah seperti saat Anda hendak mengenakan sarung untuk
sholat.

Step 7; 
gunakan kain satunya lagi untuk digunakan sebagai selendang di bagian atas tubuh, dengan
cara sebagai berikut; selipkan ujung kain ihram sebelah kiri pada gulungan kain ihram di bagian
pinggang sebelah kanan, kemudian selendangkan ujung kanannya untuk menutupi bagian atas badan.
Posisi kain ihram seperti ini hanya digunakan ketika hendak sholat dan sa’i. Sedangkan ketika Anda
hendak melakukan thawaf umrah atau qudum (thawaf ketika tiba di Mekkah), posisikan kain ihram
bagian atas dengan cara diselempangkan dibawah ketiak kanan dan dilampirkan di bahu kiri. Posisi
ini disebut dengan Idhthibaa’.]],
         x = display.contentWidth*0.1,
         y = teks8.y + teks8.height + display.contentHeight/40,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.85 * display.contentWidth)
 	 }

 	 local teks9 = display.newText(options)
     teks9.anchorX = 0
     teks9.anchorY = 0
     teks9:setFillColor(0);
     scrollView:insert(teks9)


     local options = {
		 text = "2) Wanita",
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
	     text = [[Pakaian ihram yang digunakan oleh perempuan sangatlah mudah, seperti pakaian yang digunakan
untuk sholat. Sebagaimana yang telah kita ketahui bahwa aurat wanita ketika sholat adalah seluruh
tubuh, kecuali wajah dan telapak tangan. Begitu juga ketika ihram, kaum perempuan diharuskan
memakai pakaian yang menutup aurat, kecuali wajah dan telapak tangan. Dan pakaian yang
digunakan, disunahkan berwarna putih.]],
         x = display.contentWidth*0.1,
         y = teks10.y + teks10.height + display.contentHeight/40,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.85 * display.contentWidth)
 	 }

 	 local teks11 = display.newText(options)
     teks11.anchorX = 0
     teks11.anchorY = 0
     teks11:setFillColor(0);
     scrollView:insert(teks11)



      local options = {
		 text = "2. Berihram/berniat dari miqat",
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
		 text = "لَبَّيْكَ اللَّـهُمَّ عُمْرَةً",
         x = display.contentWidth*0.05,
         y = teks12.y + teks12.height + display.contentHeight/20,
         font = "Roboto.ttf",
         fontSize = 25  * (display.contentWidth / 320),
         align = "right",
         width = (0.9 * display.contentWidth)
 	 }


 	 local teks13 = display.newText(options)
     teks13.anchorX = 0
     teks13.anchorY = 0
     teks13:setFillColor(0);
     scrollView:insert(teks13);


     local options = {
		 text = "Labbaik Allaahumma Umratan",
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
	     text = [[Artinya :

“Aku sambut panggilan-Mu ya Allah untuk berumrah.” Setelah berihram perbanyaklah membaca
talbiyah:]],
         x = display.contentWidth*0.05,
         y = teks14.y + teks14.height + display.contentHeight/40,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.85 * display.contentWidth)
 	 }

 	 local teks15 = display.newText(options)
     teks15.anchorX = 0
     teks15.anchorY = 0
     teks15:setFillColor(0);
     scrollView:insert(teks15)



     local options = {
		 text = "لَبَّيْكَ اللّٰهُمَّ لَبَّيْكَ. لَبَّيْكَ لَا شَرِيْكَ لَكَ لَبَّيْكَ. اِنَّ الْحَمْدَ وَالنِّعْمَةَ لَكَ وَاْلمُلْكَ لَا شَرِيْكَ لَك",
         x = display.contentWidth*0.05,
         y = teks15.y + teks15.height + display.contentHeight/20,
         font = "Roboto.ttf",
         fontSize = 25  * (display.contentWidth / 320),
         align = "right",
         width = (0.9 * display.contentWidth)
 	 }


 	 local teks16 = display.newText(options)
     teks16.anchorX = 0
     teks16.anchorY = 0
     teks16:setFillColor(0);
     scrollView:insert(teks16);


     local options = {
		 text = [[Labbaik Allahumma labBaik, labBaik laa syariika laka labbaik, innalhamda wan ni’mata, lakawal mulk, la syarika lak]],
         x = display.contentWidth*0.05,
         y = teks16.y + teks16.height + display.contentHeight/25,
         font = "Raleway-Bold.ttf",
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
	     text = [[Artinya:

“Aku penuhi seruan-Mu Ya Allah, aku penuhi seruan-Mu tidak ada sekutu bagi-Mu. Sesungguhnya
segala puji, nikmat dan seluruh kerajaan milik-Mu dan tidak ada sekutu bagi-Mu.”]],
         x = display.contentWidth*0.05,
         y = teks17.y + teks17.height + display.contentHeight/40,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.85 * display.contentWidth)
 	 }

 	 local teks18 = display.newText(options)
     teks18.anchorX = 0
     teks18.anchorY = 0
     teks18:setFillColor(0);
     scrollView:insert(teks18)



     local options = {
		 text = [[Hal-hal yang dilarang ketika berihram:]],
         x = display.contentWidth*0.05,
         y = teks18.y + teks18.height + display.contentHeight/25,
         font = "Raleway-Bold.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	 local teks19 = display.newText(options)
     teks19.anchorX = 0
     teks19.anchorY = 0
     teks19:setFillColor(205/255,176/255,48/255);
     scrollView:insert(teks19);


     local options = {
	     text = [[- Mencukur rambut (QS. Al-Baqarah: 196)
- Memotong kuku &amp; bulu badan (QS. Al-Hajj: 29)
- Berburu binatang darat (QS. Al-Ma’idah: 95)
- Menikah, menikahkan, dan meminang (HR Muslim)
- Bercumbu atau berjima’ (QS. Al-Baqarah: 197)
- Memakai wewangian di pakaian atau badan (HR. Bukhari &amp; Muslim)
- (Pria) memakai baju, celana, kaos kaki, sarung tangan, dan penutup kepala (HR. Bukhari no.1542)
- (Perempuan) Tidak mengenakan cadar dan sarung tangan (HR. Bukhari no. 1838)]],
         x = display.contentWidth*0.05,
         y = teks19.y + teks19.height + display.contentHeight/40,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.85 * display.contentWidth)
 	 }

 	 local teks20 = display.newText(options)
     teks20.anchorX = 0
     teks20.anchorY = 0
     teks20:setFillColor(0);
     scrollView:insert(teks20)



      local options = {
		 text = [[Hal-hal yang diperbolehkan ketika berihram:]],
         x = display.contentWidth*0.05,
         y = teks20.y + teks20.height + display.contentHeight/25,
         font = "Raleway-Bold.ttf",
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
	     text = [[- Mandi dengan air dan sabun yang tidak berbau harum
- Mencuci pakaian ihram dan mengganti dengan lainnya
- Mengikat izar (pakaian bawah atau sarung ihram)
- Berbekam
- Menyembelih hewan ternak (bukan hewan buruan)
- Bersiwak atau menggosok gigi walau ada bau harum dalam pasta giginya selama bukan maksud digunakan untuk parfum
- Memakai kacamata
- Menyisir rambut]],
         x = display.contentWidth*0.05,
         y = teks21.y + teks21.height + display.contentHeight/40,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.85 * display.contentWidth)
 	 }

 	 local teks22 = display.newText(options)
     teks22.anchorX = 0
     teks22.anchorY = 0
     teks22:setFillColor(0);
     scrollView:insert(teks22)



     local options = {
		 text = [[3. Jika khawatir tidak dapat menyelesaikan umrah karena sakit atau ada halangan lain,
maka diperbolehkan mengucapkan persyaratan ini:]],
         x = display.contentWidth*0.05,
         y = teks22.y + teks22.height + display.contentHeight/25,
         font = "Raleway-Bold.ttf",
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
		 text = [[“Allahumma inn habasanii haabisun famahillii haitsu habastanii”]],
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
	     text = [[Ya Allah, jika ada halangan yang menghalangiku maka tempat tahallulku adalah dimana Engkau menahan aku. (HR Bukhari &amp; Muslim)]],
         x = display.contentWidth*0.05,
         y = teks24.y + teks24.height + display.contentHeight/40,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.85 * display.contentWidth)
 	 }

 	 local teks25 = display.newText(options)
     teks25.anchorX = 0
     teks25.anchorY = 0
     teks25:setFillColor(0);
     scrollView:insert(teks25)




     local options = {
		 text = [[4. Jika bertepatan dengan waktu shalat wajib, maka shalat lah terlebih dahulu sebelum berihram]],
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
     teks26:setFillColor(205/255,176/255,48/255);
     scrollView:insert(teks26);



     local options = {
		 text = [[5. Memperbanyak bacaan talbiyah berikut;]],
         x = display.contentWidth*0.05,
         y = teks26.y + teks26.height + display.contentHeight/25,
         font = "Raleway-Bold.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	 local teks27 = display.newText(options)
     teks27.anchorX = 0
     teks27.anchorY = 0
     teks27:setFillColor(205/255,176/255,48/255);
     scrollView:insert(teks27);




      local options = {
		 text = "لَبَّيْكَ اللّٰهُمَّ لَبَّيْكَ. لَبَّيْكَ لَا شَرِيْكَ لَكَ لَبَّيْكَ. اِنَّ الْحَمْدَ وَالنِّعْمَةَ لَكَ وَاْلمُلْكَ لَا شَرِيْكَ لَك",
         x = display.contentWidth*0.05,
         y = teks27.y + teks27.height + display.contentHeight/20,
         font = "Roboto.ttf",
         fontSize = 25  * (display.contentWidth / 320),
         align = "right",
         width = (0.9 * display.contentWidth)
 	 }


 	 local teks28 = display.newText(options)
     teks28.anchorX = 0
     teks28.anchorY = 0
     teks28:setFillColor(0);
     scrollView:insert(teks28);


     local options = {
		 text = [[Labbaik Allahumma labBaik, labBaik laa syariika laka labbaik, innalhamda wan ni’mata, lakawal mulk, la syarika lak]],
         x = display.contentWidth*0.05,
         y = teks28.y + teks28.height + display.contentHeight/25,
         font = "Raleway-Bold.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	 local teks29 = display.newText(options)
     teks29.anchorX = 0
     teks29.anchorY = 0
     teks29:setFillColor(0);
     scrollView:insert(teks29);



     local options = {
	     text = [[Artinya:

“Aku penuhi seruan-Mu Ya Allah, aku penuhi seruan-Mu tidak ada sekutu bagi-Mu. Sesungguhnya segala puji, nikmat dan seluruh kerajaan milik-Mu dan tidak ada sekutu bagi-Mu.”]],
         x = display.contentWidth*0.05,
         y = teks29.y + teks29.height + display.contentHeight/40,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.85 * display.contentWidth)
 	 }

 	 local teks30 = display.newText(options)
     teks30.anchorX = 0
     teks30.anchorY = 0
     teks30:setFillColor(0);
     scrollView:insert(teks30)


     local options = {
		 text = [[6. Bertolak ke Kota Mekkah]],
         x = display.contentWidth*0.05,
         y = teks30.y + teks30.height + display.contentHeight/25,
         font = "Raleway-Bold.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.9 * display.contentWidth)
 	 }


 	 local teks31 = display.newText(options)
     teks31.anchorX = 0
     teks31.anchorY = 0
     teks31:setFillColor(205/255,176/255,48/255);
     scrollView:insert(teks31);


     local options = {
	     text = [[Sesampainya di kota Mekkah langsung menuju hotel dan setelah proses administrasi selesai, masuk kamar masing-masing.

Ingat! Anda masih dalam keadaan berihram. Tidak boleh mengganti pakaian ihram dengan kaos atau pakaian berjahit lainnya.]],
         x = display.contentWidth*0.05,
         y = teks31.y + teks31.height + display.contentHeight/40,
         font = "Roboto.ttf",
         fontSize = 15  * (display.contentWidth / 320),
         align = "left",
         width = (0.85 * display.contentWidth)
 	 }

 	 local teks32 = display.newText(options)
     teks32.anchorX = 0
     teks32.anchorY = 0
     teks32:setFillColor(0);
     scrollView:insert(teks32)

     local line = display.newLine( 0, teks32.y + teks32.height + display.contentHeight/20, display.contentWidth, teks32.y + teks32.height + display.contentHeight/20 )
    line:setStrokeColor( 133/255,190/255,72/255)
    line.strokeWidth = 2
    scrollView:insert(line)
    
	local back = display.newText( "Back", 20 , 0 + display.contentHeight / 20, used_font_bold, 15  * (display.contentWidth / 320)  )
    back.anchorX = 0
    back.anchorY = 0.5
    back.alpha = 1

    function onback(self) 
            if nil~= composer.getScene("daftar_isi_umroh") then composer.removeScene("daftar_isi_umroh", true) end    
            composer.gotoScene( "daftar_isi_umroh" ) 
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