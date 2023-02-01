loadstring(exports.dgs:dgsImportFunction())()
dgs = {}
games_btn = {}
function createButton(x, y, g, u, text, relative, parent)

    local button_round = dgsCreateRoundRect(15,false,tocolor(255,255,255,255))
    local gradient = dgsCreateGradient(tocolor(107,0,153),tocolor(88,101,242),10)
    dgsGradientSetColorOverwritten(gradient,false)

    local canvas = dgsCreateCanvas(gradient,100,50)
    dgsRoundRectSetTexture(button_round, canvas)


    local canvas = dgsCreateCanvas(gradient,100,50)
    dgsRoundRectSetTexture(button_round, canvas)
    
    local button_1 = dgsCreateButton(x, y, g, u,text, relative,parent)
    dgsSetProperty(button_1, "image",{button_round,button_round,button_round})
    dgsSetProperty(button_1, "functions",[[
        dgsCanvasRender(dgsElementData[self].renderCanvas)
    ]])
    dgsSetProperty(button_1, "renderCanvas", canvas)
    dgsSetFont(button_1, "default-bold")
    dgsSetProperty(button_1, "clickType", 1)

    return button_1
end


function createColorButton(x, y, g, u, text, relative, parent,r,g,b)
    local button_round = dgsCreateRoundRect(15,false,tocolor(r,g,b,255))
    local hover_round = dgsCreateRoundRect(15,false,tocolor(r,g,b,120))
    local button_1 = dgsCreateButton(x, y, g, u,text,relative,parent)
    dgsSetProperty(button_1, "image",{button_round,hover_round,button_round})
    return button_1
end


local sx,sy = guiGetScreenSize()

function dxDrawRoundedRectangle(x, y, w, h, borderColor, bgColor, postGUI)
	if (x) and (y) and (w) and (h) then
		borderColor = borderColor or tocolor(0, 0, 0, 200)
		bgColor = bgColor or borderColor
	
		--> Background
		dxDrawRectangle(x, y, w, h, bgColor, postGUI);
		
		--> Border
		dxDrawRectangle(x - 1, y + 1, 1, h - 2, borderColor, postGUI)-- left
		dxDrawRectangle(x + w, y + 1, 1, h - 2, borderColor, postGUI)-- right
		dxDrawRectangle(x + 1, y - 1, w - 2, 1, borderColor, postGUI)-- top
		dxDrawRectangle(x + 1, y + h, w - 2, 1, borderColor, postGUI)-- bottom
		dxDrawRectangle(x, y, 1, 1, borderColor, postGUI)
		dxDrawRectangle(x + w - 1, y, 1, 1, borderColor, postGUI)
		dxDrawRectangle(x, y + h - 1, 1, 1, borderColor, postGUI)
		dxDrawRectangle(x + w - 1, y + h - 1, 1, 1, borderColor, postGUI)
	end
end

function createGameButton(x, y, g, u,path, relative, parent,game_name)

    local button_round = dgsCreateRoundRect(15,false,tocolor(255,255,255,255))
    local button_hover = dgsCreateRoundRect(15,false,tocolor(255,255,255,255))

    local img = dxCreateTexture(path)
    dgsRoundRectSetTexture(button_round, img)

    --hover image 
    local blur_effect = dxCreateRenderTarget(sx/12,sy/12,true)
    dxSetRenderTarget(blur_effect)
    dxDrawImage(0,0,sx/12,sy/12,path)
    dxSetRenderTarget()

    local hover_texture = dxCreateRenderTarget( 1920,1080,true)     -- Create a render target texture which is 80 x 100 pixels
    dxSetRenderTarget( hover_texture )
    dxDrawImage(0,0,1920,1080,blur_effect)
    dxDrawImage(0,700,1920,480,"panel/imgs/test.png",0,0,0,tocolor(12,12,12,120))
    dxDrawText(game_name,0,780,1920,80,tocolor(255,255,255),14,"default-bold","center")
    dxSetRenderTarget() 
    dgsRoundRectSetTexture(button_hover,hover_texture)




    local button_1 = dgsCreateButton(x, y, g, u,"", relative,parent)
    dgsSetProperty(button_1, "image",{button_round,button_hover,button_round})

    return button_1
end

function createBackGround(x, y, g, u, path, relative, parent)

    local bottom_img_rect = dgsCreateRoundRect(15,false,tocolor(12,12,12,120))

    local img = dgsCreateImage(x,y,g,u,bottom_img_rect,relative,parent,tocolor(255,166,38))

    dgsSetProperty(img, "renderCanvas", canvas_title)

    return img
end


--PANELS

    dgs.background_img = dgsCreateImage(0,0,1,1,"panel/imgs/background.png",true)
    --dgsSetEnabled(dgs.background_img,false)
    ------------------------------------------------
    -- window profile
    ------------------------------------------------ 
    local gradient_title = dgsCreateGradient(tocolor(0,0,0,105),tocolor(0,0,0,255),90)
    dgsGradientSetColorOverwritten(gradient_title,false)
    local panel_rect = dgsCreateRoundRect({
                                        {15,false},
                                        {15,false},
                                        {15,false},
                                        {15,false},
                                    })
                                    
    local canvas_title = dgsCreateCanvas(gradient_title,100,50)
    dgsRoundRectSetTexture(panel_rect, canvas_title)

    
    profile_panel = dgsCreateWindow(0.79,0.02,0.2,0.2,"",true,tocolor(255,255,255),0,false,false,panel_rect,tocolor(255,255,255,255),false,true)
    dgsWindowSetSizable(profile_panel,false)
    dgsWindowSetMovable(profile_panel,false)
    dgsSetProperty(profile_panel, "functions",[[
        dgsCanvasRender(dgsElementData[self].renderCanvas)
    ]])
    dgsSetProperty(profile_panel, "renderCanvas", canvas_title)
    dgsSetFont(profile_panel, "default-bold")
    
    -----------------------------------------
    --Profile IMG 
    -----------------------------------------
    dgs.profile_img = dgsCreateImage(0.62,0.19,0.32,0.33,standart_profile,true,profile_panel)
    local pp_circle = dgsCreateCircle(0.5,0.42,360,tocolor(88,101,242,255))
    dgs.profile_border = dgsCreateImage(0.62,0.1,0.33,0.52,pp_circle,true,profile_panel)
    dgs.profile_name = dgsCreateLabel(0.62,0.64,0.33,0.2,"Beyonder",true,profile_panel,tocolor(255,255,255,255),1.2,1.2,nil,nil,nil,"center")
    dgsSetFont(dgs.profile_name,"default-bold")

    
    
    profile_select_window = dgsCreateWindow(0.22,0.26,0.6,0.45,"",true,tocolor(255,255,255),0,false,false,panel_rect,tocolor(255,255,255,255),false,true)
    dgsWindowSetSizable(profile_select_window,false)
    dgsWindowSetMovable(profile_select_window,false)
    dgsSetProperty(profile_select_window, "functions",[[
        dgsCanvasRender(dgsElementData[self].renderCanvas)
    ]])
    dgsSetProperty(profile_select_window, "renderCanvas", canvas_title)
    dgsSetFont(profile_select_window, "default-bold")
    ---------------------------
    --message edit
    ---------------------------
    dgs.close_selec_profile_btn = createButton(0.15,0.88,0.7,0.08,language[selected_language].close,true,profile_select_window)
    profile_img_scroll_pane = dgsCreateScrollPane(0,0,1,0.8,true,profile_select_window)
    dgsSetProperty(profile_img_scroll_pane,"scrollBarThick",0)
    local px,py = 0.02,0.05
    profile_img_table = {}
    for k,v in ipairs(profile_img) do 
        dgsCreateImage(px+0.03,py+0.05,0.1,0.3,v,true,profile_img_scroll_pane)
        local pp_circle = dgsCreateCircle(0.5,0.42,360,tocolor(88,101,242,255))
        profile_img_table[k]= dgsCreateImage(px,py,0.16,0.4,pp_circle,true,profile_img_scroll_pane)
        px = px + 0.2
        if px > 0.9 then 
            px = 0.02
            py = py + 0.45
        end
    end


    ---------------------------------------------------------------------
    -- Games 
    ---------------------------------------------------------------------
    dgs.games_scroll_bar = dgsCreateScrollPane(0.1,0.4,0.8,0.4,true,dgs.background_img)
    dgsSetProperty(dgs.games_scroll_bar ,"scrollBarThick",0)
    local startx,starty = 0,0.1
    for k,v in ipairs(games) do 
        games_btn["background"..tostring(k)] = createBackGround(startx,starty,0.3,0.6,"",true,dgs.games_scroll_bar)
        local bg = dxCreateRenderTarget(sx/222,sy/222,true)
        dxSetRenderTarget(bg)
        --dxDrawImage(0,0,sx/222,sy/222,"panel/imgs/test.png",0,0,0,tocolor(12,12,12,220))
        dxDrawRoundedRectangle(0,0,sx/322,sy/322,tocolor(12,12,12,220))
        dxSetRenderTarget()
        local bg_round = dgsCreateRoundRect(15,false,tocolor(255,255,255,255))
        dgsRoundRectSetTexture(bg_round,bg)
        dgsSetProperty(games_btn["background"..tostring(k)], "image",bg_round)
        local btn = createGameButton(0.03,0.03,0.94,0.94,v.img,true,games_btn["background"..tostring(k)],v.game_name)
        v.btn = btn 
        --games_btn["button"..tostring(k)] = btn
        startx = startx + 0.35
        if startx >= 0.8 then 
            startx = 0
            starty = starty + 0.9
        end
    end


    dgsSetVisible(dgs.games_scroll_bar,false)




    ------------------------------------------------------
    -- Game İnterFace
    ------------------------------------------------------
    dgs.return_lobby = createColorButton(0.2,0.6,0.4,0.35,"Close",true,dgs.background_img,255,0,0)


    dgsSetVisible(profile_select_window,false)

    showCursor(true)
    showChat(false)
