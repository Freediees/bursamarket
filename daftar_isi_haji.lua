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
local cancelall = {}
local began = 1
local loadall = 0
composer.page = 1
local looptimer = 0
local teksfield
cur_page = "daftar_isi"

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
	

	local background2 = display.newRect( display.contentCenterX, 0, display.contentWidth, display.contentHeight/5)
	background2.anchorY = 0
	background2:setFillColor( 133/255,190/255,72/255)
	
	local under = display.newRect( display.contentWidth, background2.y + background2.height, display.contentWidth/2, 5)
	under.anchorY = 1
	under.anchorX = 1
	under:setFillColor(1)


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
	menu.y =  background2.y + background2.height/2
	menu.anchorY = 0.5
	menu.anchorX = 0
	--menu:scale(0.5,0.5)
	menu.xScale = (background2.height/6) / menu.height
	menu.yScale = (background2.height/6) / menu.height

	menu:addEventListener("tap", onMenu)

	local teks_daftar_isi = display.newText( "Daftar Isi", menu.x + display.contentWidth/8 , menu.y , used_font_bold, 20  * (display.contentWidth / 320)  )
	teks_daftar_isi.anchorX = 0
	teks_daftar_isi.anchorY = 0.5
	teks_daftar_isi.alpha = 1

	local teks_umroh = display.newText( "Umroh", menu.x + display.contentWidth/8 , menu.y , used_font_bold, 15  * (display.contentWidth / 320)  )
	teks_umroh.x = 0.25 * display.contentWidth
	teks_umroh.anchorX = 0.5
	teks_umroh.y = background2.y + background2.height - 5
	teks_umroh.anchorY = 1
	teks_umroh.alpha = 1


	function onteks_umroh(self) 
            if nil~= composer.getScene("daftar_isi_umroh") then composer.removeScene("daftar_isi_umroh", true) end  
            if  self.type == "press" then 
                self:setEnabled(false) 
            else 
                
            end    
            composer.gotoScene( "daftar_isi_umroh" ) 
    end
    teks_umroh:addEventListener("tap", onteks_umroh) 

	local teks_haji = display.newText( "Haji", menu.x + display.contentWidth/8 , menu.y , used_font_bold, 15  * (display.contentWidth / 320)  )
	teks_haji.x = 0.75 * display.contentWidth
	teks_haji.anchorX = 0.5
	teks_haji.y = background2.y + background2.height - 5
	teks_haji.anchorY = 1
	teks_haji.alpha = 1

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

	local tinggi_option = 20
	local option1 = display.newText( "Video Panduan Ibadah Haji Full", display.contentWidth/15 , tinggi_option , used_font_bold, 13  * (display.contentWidth / 320)  )
	option1.anchorX = 0
	option1.anchorY = 0
	option1:setFillColor(0)

	local option1_back = display.newRect( 0, option1.y + 10, display.contentWidth, display.contentHeight/20)
	option1_back.anchorX = 0
	option1_back.anchorY = 0.5
	option1_back:setFillColor( 1)
	
	scrollView:insert(option1_back)
	scrollView:insert(option1)

	function on_option1(self) 
            if nil~= composer.getScene("awal_haji") then composer.removeScene("awal_haji", true) end  
            if  self.type == "press" then 
                self:setEnabled(false) 
            else 
                
            end    
            composer.gotoScene( "awal_haji" ) 
    end
    option1_back:addEventListener("tap", on_option1)


    
	
	local option2 = display.newText( "Ihram", display.contentWidth/15 , option1.y + option1.height + display.contentHeight/35 , used_font_bold, 13  * (display.contentWidth / 320)  )
	option2.anchorX = 0
	option2.anchorY = 0
	option2:setFillColor(0)

	local option2_back = display.newRect( 0, option2.y + 10, display.contentWidth, display.contentHeight/20)
	option2_back.anchorX = 0
	option2_back.anchorY = 0.5
	option2_back:setFillColor( 1)
	
	scrollView:insert(option2_back)
	scrollView:insert(option2)

	function on_option2(self) 

			
		        if nil~= composer.getScene("ihram_haji") then composer.removeScene("ihram_haji", true) end  
		        if  self.type == "press" then 
		            self:setEnabled(false) 
		        else 
		            
		        end    
		        composer.gotoScene( "ihram_haji" ) 
       	

           
    end
    option2_back:addEventListener("tap", on_option2)


	local option3 = display.newText( "Berdiam diri di arafah (Wukuf)", display.contentWidth/15 , option2.y + option2.height + display.contentHeight/35 , used_font_bold, 13  * (display.contentWidth / 320)  )
	option3.anchorX = 0
	option3.anchorY = 0
	option3:setFillColor(0)

	local option3_back = display.newRect( 0, option3.y + 10, display.contentWidth, display.contentHeight/20)
	option3_back.anchorX = 0
	option3_back.anchorY = 0.5
	option3_back:setFillColor( 1)
	
	scrollView:insert(option3_back)
	scrollView:insert(option3)


	function on_option3(self) 

			
		        if nil~= composer.getScene("wukuf_haji") then composer.removeScene("wukuf_haji", true) end  
		        if  self.type == "press" then 
		            self:setEnabled(false) 
		        else 
		            
		        end    
		        composer.gotoScene( "wukuf_haji" ) 
       		


    end
    option3_back:addEventListener("tap", on_option3)



	local option4 = display.newText( "Mabit di Muzdalifah", display.contentWidth/15 , option3.y + option3.height + display.contentHeight/35 , used_font_bold, 13  * (display.contentWidth / 320)  )
	option4.anchorX = 0
	option4.anchorY = 0
	option4:setFillColor(0)

	local option4_back = display.newRect( 0, option4.y + 10, display.contentWidth, display.contentHeight/20)
	option4_back.anchorX = 0
	option4_back.anchorY = 0.5
	option4_back:setFillColor( 1)
	
	scrollView:insert(option4_back)
	scrollView:insert(option4)

	function on_option4(self) 


		
		        if nil~= composer.getScene("mabit_haji") then composer.removeScene("mabit_haji", true) end  
		        if  self.type == "press" then 
		            self:setEnabled(false) 
		        else 
		            
		        end    
		        composer.gotoScene( "mabit_haji" ) 
       		

           
    end
    option4_back:addEventListener("tap", on_option4)


	local option5 = display.newText( "Mina, Melempar Jumrah Aqobah/Kubro", display.contentWidth/15 , option4.y + option4.height + display.contentHeight/35 , used_font_bold, 13 * (display.contentWidth / 320)  )
	option5.anchorX = 0
	option5.anchorY = 0
	option5:setFillColor(0)

	local option5_back = display.newRect( 0, option5.y + 10, display.contentWidth, display.contentHeight/20)
	option5_back.anchorX = 0
	option5_back.anchorY = 0.5
	option5_back:setFillColor( 1)
	
	scrollView:insert(option5_back)
	scrollView:insert(option5)

	function on_option5(self) 

		        if nil~= composer.getScene("mina_haji") then composer.removeScene("mina_haji", true) end  
		        if  self.type == "press" then 
		            self:setEnabled(false) 
		        else 
		            
		        end    
		        composer.gotoScene( "mina_haji" ) 
       		

    end
    option5_back:addEventListener("tap", on_option5)



	local option3_0 = display.newText( "Thawaf", display.contentWidth/15 , option5.y + option5.height + display.contentHeight/35 , "Roboto.ttf", 13  * (display.contentWidth / 320)  )
	option3_0.anchorX = 0
	option3_0.anchorY = 0
	option3_0:setFillColor(0)

	local option3_0_back = display.newRect( 0, option3_0.y + 10, display.contentWidth, display.contentHeight/20)
	option3_0_back.anchorX = 0
	option3_0_back.anchorY = 0.5
	option3_0_back:setFillColor( 1)
	
	scrollView:insert(option3_0_back)
	scrollView:insert(option3_0)


	function on_option3_0(self) 

		
		        if nil~= composer.getScene("thawaf_umroh") then composer.removeScene("thawaf_umroh", true) end  
		        if  self.type == "press" then 
		            self:setEnabled(false) 
		        else 
		            
		        end    
		        composer.gotoScene( "thawaf_umroh" ) 
       	


           
    end
    option3_0_back:addEventListener("tap", on_option3_0)

	local doa1_thawaf = display.newText( "Doa Thawaf 1", display.contentWidth/15 , option3_0.y + option3_0.height + display.contentHeight/35 , "Roboto.ttf", 13  * (display.contentWidth / 320)  )
	doa1_thawaf.anchorX = 0
	doa1_thawaf.anchorY = 0
	doa1_thawaf:setFillColor(0)

	local doa1_thawaf_back = display.newRect( 0, doa1_thawaf.y + 10, display.contentWidth, display.contentHeight/20)
	doa1_thawaf_back.anchorX = 0
	doa1_thawaf_back.anchorY = 0.5
	doa1_thawaf_back:setFillColor( 1)
	
	scrollView:insert(doa1_thawaf_back)
	scrollView:insert(doa1_thawaf)


	function on_doa1_thawaf(self) 

		
		        if nil~= composer.getScene("doa1_thawaf_umroh") then composer.removeScene("doa1_thawaf_umroh", true) end  
		        if  self.type == "press" then 
		            self:setEnabled(false) 
		        else 
		            
		        end    
		        composer.gotoScene( "doa1_thawaf_umroh" ) 
       		

    end
    doa1_thawaf_back:addEventListener("tap", on_doa1_thawaf)


	local doa2_thawaf = display.newText( "Doa Thawaf 2", display.contentWidth/15 , doa1_thawaf.y + doa1_thawaf.height + display.contentHeight/35 , "Roboto.ttf", 13  * (display.contentWidth / 320)  )
	doa2_thawaf.anchorX = 0
	doa2_thawaf.anchorY = 0
	doa2_thawaf:setFillColor(0)

	local doa2_thawaf_back = display.newRect( 0, doa2_thawaf.y + 10, display.contentWidth, display.contentHeight/20)
	doa2_thawaf_back.anchorX = 0
	doa2_thawaf_back.anchorY = 0.5
	doa2_thawaf_back:setFillColor( 1)
	
	scrollView:insert(doa2_thawaf_back)
	scrollView:insert(doa2_thawaf)


	function on_doa2_thawaf(self) 
           
		        if nil~= composer.getScene("doa2_thawaf_umroh") then composer.removeScene("doa2_thawaf_umroh", true) end  
		        if  self.type == "press" then 
		            self:setEnabled(false) 
		        else 
		            
		        end    
		        composer.gotoScene( "doa2_thawaf_umroh" ) 
       		
    end
    doa2_thawaf_back:addEventListener("tap", on_doa2_thawaf)



	local doa3_thawaf = display.newText( "Doa Thawaf 3", display.contentWidth/15 , doa2_thawaf.y + doa2_thawaf.height + display.contentHeight/35 , "Roboto.ttf", 13  * (display.contentWidth / 320)  )
	doa3_thawaf.anchorX = 0
	doa3_thawaf.anchorY = 0
	doa3_thawaf:setFillColor(0)

	local doa3_thawaf_back = display.newRect( 0, doa3_thawaf.y + 10, display.contentWidth, display.contentHeight/20)
	doa3_thawaf_back.anchorX = 0
	doa3_thawaf_back.anchorY = 0.5
	doa3_thawaf_back:setFillColor( 1)
	
	scrollView:insert(doa3_thawaf_back)
	scrollView:insert(doa3_thawaf)


	function on_doa3_thawaf(self) 
           
		        if nil~= composer.getScene("doa3_thawaf_umroh") then composer.removeScene("doa3_thawaf_umroh", true) end  
		        if  self.type == "press" then 
		            self:setEnabled(false) 
		        else 
		            
		        end    
		        composer.gotoScene( "doa3_thawaf_umroh" ) 
       		
    end
    doa3_thawaf_back:addEventListener("tap", on_doa3_thawaf)


	local doa4_thawaf = display.newText( "Doa Thawaf 4", display.contentWidth/15 , doa3_thawaf.y + doa3_thawaf.height + display.contentHeight/35 , "Roboto.ttf", 13  * (display.contentWidth / 320)  )
	doa4_thawaf.anchorX = 0
	doa4_thawaf.anchorY = 0
	doa4_thawaf:setFillColor(0)

	local doa4_thawaf_back = display.newRect( 0, doa4_thawaf.y + 10, display.contentWidth, display.contentHeight/20)
	doa4_thawaf_back.anchorX = 0
	doa4_thawaf_back.anchorY = 0.5
	doa4_thawaf_back:setFillColor( 1)
	
	scrollView:insert(doa4_thawaf_back)
	scrollView:insert(doa4_thawaf)


	function on_doa4_thawaf(self) 
          
		        if nil~= composer.getScene("doa4_thawaf_umroh") then composer.removeScene("doa4_thawaf_umroh", true) end  
		        if  self.type == "press" then 
		            self:setEnabled(false) 
		        else 
		            
		        end    
		        composer.gotoScene( "doa4_thawaf_umroh" ) 
       		
    end
    doa4_thawaf_back:addEventListener("tap", on_doa4_thawaf)


	local doa5_thawaf = display.newText( "Doa Thawaf 5", display.contentWidth/15 , doa4_thawaf.y + doa4_thawaf.height + display.contentHeight/35 , "Roboto.ttf", 13  * (display.contentWidth / 320)  )
	doa5_thawaf.anchorX = 0
	doa5_thawaf.anchorY = 0
	doa5_thawaf:setFillColor(0)

	local doa5_thawaf_back = display.newRect( 0, doa5_thawaf.y + 10, display.contentWidth, display.contentHeight/20)
	doa5_thawaf_back.anchorX = 0
	doa5_thawaf_back.anchorY = 0.5
	doa5_thawaf_back:setFillColor( 1)
	
	scrollView:insert(doa5_thawaf_back)
	scrollView:insert(doa5_thawaf)


	function on_doa5_thawaf(self) 
          
		        if nil~= composer.getScene("doa5_thawaf_umroh") then composer.removeScene("doa5_thawaf_umroh", true) end  
		        if  self.type == "press" then 
		            self:setEnabled(false) 
		        else 
		            
		        end    
		        composer.gotoScene( "doa5_thawaf_umroh" ) 
       		
    end
    doa5_thawaf_back:addEventListener("tap", on_doa5_thawaf)


	



	local doa6_thawaf = display.newText( "Doa Thawaf 6", display.contentWidth/15 , doa5_thawaf.y + doa5_thawaf.height + display.contentHeight/35 , "Roboto.ttf", 13  * (display.contentWidth / 320)  )
	doa6_thawaf.anchorX = 0
	doa6_thawaf.anchorY = 0
	doa6_thawaf:setFillColor(0)

	local doa6_thawaf_back = display.newRect( 0, doa6_thawaf.y + 10, display.contentWidth, display.contentHeight/20)
	doa6_thawaf_back.anchorX = 0
	doa6_thawaf_back.anchorY = 0.5
	doa6_thawaf_back:setFillColor( 1)
	
	scrollView:insert(doa6_thawaf_back)
	scrollView:insert(doa6_thawaf)	


	function on_doa6_thawaf(self) 
       
		        if nil~= composer.getScene("doa6_thawaf_umroh") then composer.removeScene("doa6_thawaf_umroh", true) end  
		        if  self.type == "press" then 
		            self:setEnabled(false) 
		        else 
		            
		        end    
		        composer.gotoScene( "doa6_thawaf_umroh" ) 
       		
    end
    doa6_thawaf_back:addEventListener("tap", on_doa6_thawaf)

	local doa7_thawaf = display.newText( "Doa Thawaf 7", display.contentWidth/15 , doa6_thawaf.y + doa6_thawaf.height + display.contentHeight/35 , "Roboto.ttf", 13  * (display.contentWidth / 320)  )
	doa7_thawaf.anchorX = 0
	doa7_thawaf.anchorY = 0
	doa7_thawaf:setFillColor(0)

	local doa7_thawaf_back = display.newRect( 0, doa7_thawaf.y + 10, display.contentWidth, display.contentHeight/20)
	doa7_thawaf_back.anchorX = 0
	doa7_thawaf_back.anchorY = 0.5
	doa7_thawaf_back:setFillColor( 1)
	
	scrollView:insert(doa7_thawaf_back)
	scrollView:insert(doa7_thawaf)


	function on_doa7_thawaf(self) 
           
		        if nil~= composer.getScene("doa7_thawaf_umroh") then composer.removeScene("doa7_thawaf_umroh", true) end  
		        if  self.type == "press" then 
		            self:setEnabled(false) 
		        else 
		            
		        end    
		        composer.gotoScene( "doa7_thawaf_umroh" ) 
       		
    end
    doa7_thawaf_back:addEventListener("tap", on_doa7_thawaf)


    local thawaf_lanjutan = display.newText( "Thawaf Lanjutan", display.contentWidth/15 , doa7_thawaf.y + doa7_thawaf.height + display.contentHeight/35 , "Roboto.ttf", 13  * (display.contentWidth / 320)  )
	thawaf_lanjutan.anchorX = 0
	thawaf_lanjutan.anchorY = 0
	thawaf_lanjutan:setFillColor(0)

	local thawaf_lanjutan_back = display.newRect( 0, thawaf_lanjutan.y + 10, display.contentWidth, display.contentHeight/20)
	thawaf_lanjutan_back.anchorX = 0
	thawaf_lanjutan_back.anchorY = 0.5
	thawaf_lanjutan_back:setFillColor( 1)
	
	scrollView:insert(thawaf_lanjutan_back)
	scrollView:insert(thawaf_lanjutan)


	function on_thawaf_lanjutan(self) 

			
		        if nil~= composer.getScene("thawaf_umroh_lanjutan") then composer.removeScene("thawaf_umroh_lanjutan", true) end  
		        if  self.type == "press" then 
		            self:setEnabled(false) 
		        else 
		            
		        end    
		        composer.gotoScene( "thawaf_umroh_lanjutan" ) 
       		


    end
    thawaf_lanjutan_back:addEventListener("tap", on_thawaf_lanjutan)


	local option6 = display.newText( "Sa'i", display.contentWidth/15 , thawaf_lanjutan.y + thawaf_lanjutan.height + display.contentHeight/35 , "Roboto.ttf", 13  * (display.contentWidth / 320)  )
	option6.anchorX = 0
	option6.anchorY = 0
	option6:setFillColor(0)

	local option6_back = display.newRect( 0, option6.y + 10, display.contentWidth, display.contentHeight/20)
	option6_back.anchorX = 0
	option6_back.anchorY = 0.5
	option6_back:setFillColor( 1)
	
	scrollView:insert(option6_back)
	scrollView:insert(option6)


	function on_option6(self) 

		        if nil~= composer.getScene("sai_umroh") then composer.removeScene("sai_umroh", true) end  
		        if  self.type == "press" then 
		            self:setEnabled(false) 
		        else 
		            
		        end    
		        composer.gotoScene( "sai_umroh" ) 
       		

    end
    option6_back:addEventListener("tap", on_option6)

	local option7 = display.newText( "Tahallul", display.contentWidth/15 , option6.y + option6.height + display.contentHeight/35 , "Roboto.ttf", 13  * (display.contentWidth / 320)  )
	option7.anchorX = 0
	option7.anchorY = 0
	option7:setFillColor(0)

	local option7_back = display.newRect( 0, option7.y + 10, display.contentWidth, display.contentHeight/20)
	option7_back.anchorX = 0
	option7_back.anchorY = 0.5
	option7_back:setFillColor( 1)
	
	scrollView:insert(option7_back)
	scrollView:insert(option7)


	function on_option7(self) 


		
		        if nil~= composer.getScene("tahallul_umroh") then composer.removeScene("tahallul_umroh", true) end  
		        if  self.type == "press" then 
		            self:setEnabled(false) 
		        else 
		            
		        end    
		        composer.gotoScene( "tahallul_umroh" ) 
       		
    end
    option7_back:addEventListener("tap", on_option7)


	-- all objects must be added to group (e.g. self.view)
	sceneGroup:insert( background )
	sceneGroup:insert( background2 )
	sceneGroup:insert(menu)
	sceneGroup:insert(teks_daftar_isi)
	sceneGroup:insert(teks_umroh)
	sceneGroup:insert(teks_haji)
	sceneGroup:insert(under)
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
		

	

          
        display.remove(scrollView_banner)  
	
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