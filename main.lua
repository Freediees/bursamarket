-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- show default status bar (iOS)
display.setStatusBar( display.HiddenStatusBar )

-- Book created by Kwik for Adobe Photoshop  - Developed by Kwiksher 
-- Copyright (C) 2013 kwiksher.com. All Rights Reserved. 
-- Created using Kwik 3.3. 
-- uses DMC classes, by David McCuskey 
-- Exported on Thu Aug 27 2015 09:19:30 GMT+0700 

local composer = require("composer") 

-- =====================================aktifkan untuk notifikasi=====================================================================

-- local notifications = require( "plugin.notifications.v2" )

-- notifications.registerForPushNotifications( { useFCM=true } )
-- notifications.subscribe( "bursasajadah" )

-- local launchArgs = ...
 
-- if ( launchArgs and launchArgs.notification ) then
--     --notificationListener( launchArgs.notification )
--     media.playSound( "notification.wav" )
-- end

--====================================================================================================================================

--composer.Gesture = require("dmc_gesture") 
--composer.MultiTouch = require("dmc_multitouch") 
--system.activate("multitouch") 
local json = require("json") 

-- check if current SDK version is the latest compatible with Kwik 
local function versionCheck(event) if "clicked" == event.action then if event.index == 2 then system.openURL( "https://developer.coronalabs.com/downloads/coronasdk" ) end end end 
if ( system.getInfo("environment") == "simulator" and string.sub(system.getInfo("build"),6) < string.sub("2014.2393a",6) ) then native.showAlert("Corona SDK Incompatible Version","Your Corona SDK version is different than the certified one with Kwik. Install build 2014.2393a or you may have issues in your project.",{"OK", "Download"}, versionCheck) end 





composer.kwk_readMe = 0 

display.setStatusBar( display.HiddenStatusBar ) 
composer.imgDir = "images/" 
composer.audioDir = "audio/" 
composer.videoDir = "video/" 
composer.spriteDir = "sprites/" 
composer.thumbDir = "thumbnails/" 

composer.lang = "" 

composer.kBidi = false 
composer.kAutoPlay = 0 
composer.goPage = 1 

cur_page = "main"
status_back = 0



--print(pindah)

-- Handles physical buttons on Android devices 
local function onKeyEventExit( event ) 
   print("halaman: "..cur_page)
   print("status_back: "..status_back)
   local phase = event.phase 
   local keyName = event.keyName 
   if ( "back" == keyName and phase == "up" ) then 	
   	if(cur_page == "home") then
   		native.requestExit()
   	elseif(cur_page == "umroh" or cur_page == "haji")then
   		if nil~= composer.getScene("daftar_isi_umroh") then composer.removeScene("daftar_isi_umroh", true) end  	

		
			composer.gotoScene("daftar_isi_umroh")
		

	elseif(cur_page == "berita")then
   		if nil~= composer.getScene("daftar_berita") then composer.removeScene("daftar_berita", true) end  		            
		
			composer.gotoScene("daftar_berita")
		

	elseif(cur_page == "daftar_isi" or cur_page == "view1")then
   		if nil~= composer.getScene("home") then composer.removeScene("home", true) end  		            
		
			composer.gotoScene("home")

   	elseif(cur_page == "checkout1" or cur_page == "checkout2") then
   		if(status_back == 0)then
	      	  if nil~= composer.getScene("test_cart") then composer.removeScene("test_cart", true) end  		            
			  
					composer.gotoScene("test_cart")
				
	      elseif(status_back == 1)then
	    --   	  status_back = 0
	    --   	  if nil~= composer.getScene("checkout1") then composer.removeScene("checkout1", true) end  		            
			  -- composer.gotoScene( "checkout1" )

	      end
   	else

   		if(status_back == 0)then
	      	  --Runtime:removeEventListener( "key", onKeyEventExit )
	   		  if nil~= composer.getScene("test_home") then composer.removeScene("test_home", true) end  		            
			  

			
				composer.gotoScene("test_home")
			
	      	  
	    elseif(status_back == 1)then
	      	  scrollViewWarna.alpha = 0
		      scrollViewUkuran.alpha = 0
		      back_rounded.alpha = 0
		      background_hitam.alpha = 0
		      scrollView:setIsLocked( false )
		      status_back = 0
	    end

      
   	end
      
      
   end 
   return true
end 
Runtime:addEventListener( "key", onKeyEventExit )

-- Json code for external variable loading 
local jsonFile = function(filename ) 
   local path = system.pathForFile(filename, system.DocumentsDirectory ) 
   local contents 
   local file = io.open( path, "r" ) 
   if file then 
      contents = file:read("*a") 
      io.close(file) 
   end 
   return contents 
end 
-- Variable saving function 
local path = system.pathForFile( "kwkVars.json", system.DocumentsDirectory ) 
local file = io.open( path, "r" ) 
if file then 
else 
   local file = io.open( path, "w+" ) 
   file:write("{{}}") 
   io.close(file) 
end 

-- Loads vars 
kwkVar = json.decode( jsonFile("kwkVars.json") ) 
-- Check for saved variables 
function kwkVarCheck(variable) 
   kwkVar = json.decode( jsonFile("kwkVars.json") ) 
   local found = nil 
   if kwkVar ~= nil then 
      for i = 1, #kwkVar do 
         if (variable == kwkVar[i].name) then 
            found = kwkVar[i].value; break 
         end 
      end 
   end
   return (found) 
end 



--Create a main group
local mainGroup = display.newGroup()

-- Main function
local function main()
	local loop = 0
	local loop2 = 0
	local loop3 = 0
	composer.is_login = '0'
	composer.data_max_slider = 0
	local pindah = ""
    composer.masuk = 0

	require "sqlite3"

	local datab = "data.db"
	local path = system.pathForFile(datab, system.DocumentsDirectory)
	db = sqlite3.open( path )

	local tablesetup = [[CREATE TABLE IF NOT EXISTS is_login (id INTEGER PRIMARY KEY , status_login, id_user);]]
	db:exec(tablesetup)

	for row in db:nrows("SELECT * FROM is_login") do
	  loop3 = loop3 + 1
	  composer.is_login = row.status_login
	end
	print(composer.is_login)
	if(loop3 == 0 )then
		local tablesetup = [[INSERT INTO is_login VALUES(NULL, '0', '0');]]
		db:exec(tablesetup)
	end


	local tablesetup = [[CREATE TABLE IF NOT EXISTS t_status (id INTEGER PRIMARY KEY , status_member, version);]]
	db:exec(tablesetup)

	for row in db:nrows("SELECT * FROM t_status") do
	  loop = loop + 1
	end

	if(loop == 0 )then
		local tablesetup = [[INSERT INTO t_status VALUES(NULL, '0', '0');]]
		db:exec(tablesetup)
	end

	loop = 0

	-- local tablesetup = [[CREATE TABLE IF NOT EXISTS t_invoice (id INTEGER PRIMARY KEY , nomor_invoice, tanggal, status);]]
	-- db:exec(tablesetup)


	local tablesetup = [[CREATE TABLE IF NOT EXISTS t_produk_cart (t_produk_id INTEGER PRIMARY KEY , sku, produk_id INTEGER, nama_produk, price INTEGER, qty INTEGER, weight INTEGER, color, size);]]
	db:exec(tablesetup)

	local tablesetup = [[CREATE TABLE IF NOT EXISTS t_checkout1 (t_checkout_id INTEGER PRIMARY KEY , alamat, no_telp, nama, email, provinsi, kabupaten, kecamatan, kodepos, kupon, total_berat);]]
	db:exec(tablesetup)

	local tablesetup = [[CREATE TABLE IF NOT EXISTS t_checkout2 (t_checkout_id INTEGER PRIMARY KEY , service, berat, ongkos);]]
	db:exec(tablesetup)


	local tablesetup = [[CREATE TABLE IF NOT EXISTS t_ceklis1 (t_ceklis1 INTEGER PRIMARY KEY , value, status);]]
	db:exec(tablesetup)

	for row in db:nrows("SELECT * FROM t_ceklis1") do
	  loop = loop + 1
	end

	if(loop == 0)then
		print("masuk woy")
		local tablesetup = [[INSERT INTO t_ceklis1 VALUES(NULL, 'Baju Ihrom', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis1 VALUES(NULL, 'Sarung Lengan, Masker, Kantong Batu', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis1 VALUES(NULL, 'Sepatu Ihrom', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis1 VALUES(NULL, 'Kaos Dalam Ihrom', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis1 VALUES(NULL, 'Kaos Tangan Jari', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis1 VALUES(NULL, 'Bergo/ Malaya Panjang', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis1 VALUES(NULL, 'Topi Haji', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis1 VALUES(NULL, 'Daster', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis1 VALUES(NULL, 'Mukena', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis1 VALUES(NULL, 'Sajadah', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis1 VALUES(NULL, 'Celana Dalam Disposible/Kertas', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis1 VALUES(NULL, 'Handuk Kecil', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis1 VALUES(NULL, 'Tas Transparan', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis1 VALUES(NULL, 'Pashmina', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis1 VALUES(NULL, 'Tambang Koper', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis1 VALUES(NULL, 'Tambang Aqua', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis1 VALUES(NULL, 'Bantal Tiup', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis1 VALUES(NULL, 'Sarung Tangan Sholat', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis1 VALUES(NULL, 'Manset Tangan', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis1 VALUES(NULL, 'Kaos Kaki Wudhu', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis1 VALUES(NULL, 'Baju Muslim & Abaya', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis1 VALUES(NULL, 'Celana Legging', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis1 VALUES(NULL, 'Sepatu Haji Wanita', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis1 VALUES(NULL, 'Kaos Kaki Tawaf', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis1 VALUES(NULL, 'Setelan Pakai Dalam Wanita', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis1 VALUES(NULL, 'Kantong Peepis (Urine Bag)', '0');]]
		db:exec(tablesetup)
		-- local tablesetup = [[INSERT INTO t_ceklis1 VALUES(NULL, 'Baju Ihrom', '0');]]
		-- db:exec(tablesetup)
	end

	loop = 0

	local tablesetup = [[CREATE TABLE IF NOT EXISTS t_ceklis2 (t_ceklis2 INTEGER PRIMARY KEY , value, status);]]
	db:exec(tablesetup)

	for row in db:nrows("SELECT * FROM t_ceklis2") do
	  loop = loop + 1
	end

	if(loop == 0)then
		local tablesetup = [[INSERT INTO t_ceklis2 VALUES(NULL, 'Ihrom Handuk (Kain Ihrom)', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis2 VALUES(NULL, 'Sabuk Haji', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis2 VALUES(NULL, 'Sandal Haji', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis2 VALUES(NULL, 'Celana Dalam Ihrom', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis2 VALUES(NULL, 'Baju Stelan Pakistan', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis2 VALUES(NULL, 'Kaos Dalam Ihrom/ Kaos Haji', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis2 VALUES(NULL, 'Tas Transparan', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis2 VALUES(NULL, 'Kaos Kaki Jari', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis2 VALUES(NULL, 'Celana Dalam Disposible/Kertas', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis2 VALUES(NULL, 'Masker', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis2 VALUES(NULL, 'Kantong Batu', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis2 VALUES(NULL, 'Handuk Kecil', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis2 VALUES(NULL, 'Sarung', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis2 VALUES(NULL, 'Sorban', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis2 VALUES(NULL, 'Kopiah Haji', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis2 VALUES(NULL, 'Sajadah', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis2 VALUES(NULL, 'Tambang Aqua', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis2 VALUES(NULL, 'Tambang Koper', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis2 VALUES(NULL, 'Bantal Tiup', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis2 VALUES(NULL, 'Aneka Baju Koko', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis2 VALUES(NULL, 'Aneka Celana Haji', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis2 VALUES(NULL, 'Setelan Pakaian Dalam Pria', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis2 VALUES(NULL, 'Kantong Peepis (Urine Bag)', '0');]]
		db:exec(tablesetup)
	end



	loop = 0

	local tablesetup = [[CREATE TABLE IF NOT EXISTS t_ceklis3 (t_ceklis3 INTEGER PRIMARY KEY , value, status);]]
	db:exec(tablesetup)

	for row in db:nrows("SELECT * FROM t_ceklis3") do
	  loop = loop + 1
	end

	if(loop == 0)then
		local tablesetup = [[INSERT INTO t_ceklis3 VALUES(NULL, 'Sabun Non Parfum', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis3 VALUES(NULL, 'Pasta Gigi Non Parfum', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis3 VALUES(NULL, 'Siwak', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis3 VALUES(NULL, 'Shampo Non Parfum', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis3 VALUES(NULL, 'Kunci Gembok', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis3 VALUES(NULL, 'Tikar Wukuf', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis3 VALUES(NULL, 'Cream 21/Vaseline/Glysolid', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis3 VALUES(NULL, 'Labello (Lipbalm)', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis3 VALUES(NULL, 'Gunting Tahallul', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis3 VALUES(NULL, 'Gunting Kuku', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis3 VALUES(NULL, 'Peniti', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis3 VALUES(NULL, 'Spray Haji', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis3 VALUES(NULL, 'Tasbih Digital/Counter', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis3 VALUES(NULL, 'Senter', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis3 VALUES(NULL, 'Jepitan Jemuran', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis3 VALUES(NULL, 'Tambang Jemuran', '0');]]
		db:exec(tablesetup)
	end



	loop = 0

	local tablesetup = [[CREATE TABLE IF NOT EXISTS t_ceklis4 (t_ceklis4 INTEGER PRIMARY KEY , value, status);]]
	db:exec(tablesetup)

	for row in db:nrows("SELECT * FROM t_ceklis4") do
	  loop = loop + 1
	end

	if(loop == 0)then
		local tablesetup = [[INSERT INTO t_ceklis4 VALUES(NULL, 'Habbatussauda Arofah', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis4 VALUES(NULL, 'Sari Kurma Arofah', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis4 VALUES(NULL, 'Madu Arofah', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis4 VALUES(NULL, 'Minyak Zaitun Arofah', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis4 VALUES(NULL, 'Minyak Angin Aroma Therapy', '0');]]
		db:exec(tablesetup)
		local tablesetup = [[INSERT INTO t_ceklis4 VALUES(NULL, 'P3K', '0');]]
		db:exec(tablesetup)
	end



	loop = 0

	local tablesetup = [[CREATE TABLE IF NOT EXISTS t_video (t_checkout_id INTEGER PRIMARY KEY , video1, video2, video3, video4, video5, video6, video7, video8, video9, video10, video11, video12, video13, video14, video15, video16, video17, video18, video19, video20, video21);]]
	db:exec(tablesetup)

	for row in db:nrows("SELECT * FROM t_video") do
	  loop = loop + 1
	end

	if(loop == 0)then
		print("masuk woy")
		local tablesetup = [[INSERT INTO t_video VALUES(NULL, '0', '0' , '0', '0', '0' , '0', '0', '0' , '0', '0', '0' , '0', '0', '0' , '0', '0', '0' , '0', '0', '0' ,'0');]]
		db:exec(tablesetup)
	end
-- 	for row in db:nrows("SELECT * FROM is_login") do
-- 	  loop = loop + 1
-- 	end

-- 	if(loop == 0)then
-- 		local tablesetup = [[INSERT INTO is_login VALUES(NULL, '0', '0');]]
-- 		db:exec(tablesetup)
-- 	else
-- 		for row in db:nrows("SELECT * FROM is_login where status_login = '1'") do
-- 		  loop2 = loop2 + 1
-- 		end


-- 		print("loop = "..loop2.." composer login = "..composer.is_login)

-- 		if(loop2 == 0)then
-- 			composer.is_login = 0
-- 			pindah = "login_fix"
-- 			--pindah = "informasi_akun"
-- 		else


-- 			composer.is_login = 1
-- 			pindah = "view1"
-- 			--pindah = "informasi_akun"

-- 		end
-- end

	
	
	--composer.gotoScene( "test_home", options )
	composer.gotoScene( "home", options )
    
	
   return true
end




--Clear timers and transitions
composer.timerStash = {}
composer.trans = {}
composer.gt = {}

composer.cancelAllTimers = function()
    local k, v

    for k,v in pairs(composer.timerStash) do
        timer.cancel( v )
        v = nil; k = nil
    end

    composer.timerStash = nil
    composer.timerStash = {}
end

--

composer.cancelAllTransitions = function()
    local k, v

    for k,v in pairs(composer.trans) do
        transition.cancel( v )
        v = nil; k = nil
    end

    composer.trans = nil
    composer.trans = {}
end

--cancel all gtweens
composer.cancelAllTweens = function()
    local k, v

    for k,v in pairs(composer.gt) do
        v:pause();
        v = nil; k = nil
    end

    composer.gt = nil
    composer.gt = {}
end

--save all permanent variables
function zeroesKwikVars() --restart the file to save variable content
	local path = system.pathForFile( "kwkVars.json", system.DocumentsDirectory )
	local contents
	local file = io.open( path, "w+b" )
	if file then
	   contents = file:write( "{{}}" )
	   io.close( file )	-- close the file after using it
	end
end

function saveKwikVars(toSave) --toSave is a table with contents
    local varTab={}
	--loop current kwkVar content (contains ALL variables saved)
	local found = nil
	local jsonString
	
	--checks if current file is empty or not
	local path = system.pathForFile( "kwkVars.json", system.DocumentsDirectory )
	local contents
	--check if file exists
	local file = io.open( path, "r" )
	if file then
	    --reads to check if original content is empty == {{}}
	    local test = file:read("*l") 

	    if (test=="{{}}") then
	        -- kwkVar.json is empty. Recreates the file with the new content
	        io.close( file )
	    	local file = io.open( path, "w+" )
	    	varTab[1] = {["name"] = toSave[1],["value"] = toSave[2]}
			jsonString = json.encode( varTab )

			contents = file:write( jsonString )
			io.close( file )
	    else
	        --there are already variables saved in the kwkVars.json file
	        io.close( file )
	    	local file = io.open( path, "w" )
	    	local ts = 0

		    for i = 1,#kwkVar do
		      if (toSave[1] == kwkVar[i].name) then
				kwkVar[i].value = toSave[2]
				varTab[i] = {["name"] = kwkVar[i].name,["value"] = kwkVar[i].value}
				ts = 1
			  else
				varTab[i] = {["name"] = kwkVar[i].name,["value"] = kwkVar[i].value}
			  end
		    end
		    if (ts == 0) then --variable not in the file yet
		    	local x = #kwkVar
		    	x = x + 1
			    varTab[x] = {["name"] = toSave[1],["value"] = toSave[2]}
			end

		    jsonString = json.encode( varTab )
	    	contents = file:write( jsonString )
			io.close( file )
	    end
	    
	    
	else
	    --re-creation scenario
	    zeroesKwikVars()
	end
	kwkVar = json.decode( jsonFile( "kwkVars.json" ) )	
	
end

local function myUnhandledErrorListener( event )
 
    local iHandledTheError = true
 
    if iHandledTheError then
        print( "Handling the unhandled error", event.errorMessage )
    else
        print( "Not handling the unhandled error", event.errorMessage )
    end
    
    return iHandledTheError
end
 
Runtime:addEventListener("unhandledError", myUnhandledErrorListener)


-- Begin
main()