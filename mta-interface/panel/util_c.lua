------------------------
-- DGS Click
------------------------
function dgs_click()
    if source == dgs.profile_border then 
        dgsSetVisible(profile_select_window,true)
    elseif source == dgs.close_selec_profile_btn then 
        dgsSetVisible(profile_select_window,false)
    else
        if dgsGetVisible(profile_select_window) then
            for k,v in ipairs(profile_img_table) do 
                if v == source then 
                    profile_chg(k)
                    break
                end
            end
        end
    end
end






-------------------------
--- Profile CHG
-------------------------

function profile_chg(id)
    for k,v in ipairs(profile_img) do 
        if k == id then
            dgsImageSetImage(dgs.profile_img,v)
            dgsSetVisible(profile_select_window,false)
            --triggerServerEvent("load_img_meta",localPlayer,v,player_account_name)
            break
        end
    end 
end

--------------------------------
--Click Games Button
---------------------------------
function games_click()
    for k,v in ipairs(games) do 
        if v.btn == source then 
            v.click()
            dgsZoomTo(v.btn,true,v.img,k)
            setTimer(function()
                dgsSetVisible(dgs.games_scroll_bar,false)
            end,300,1)
            break 
        end
    end
end



addEventHandler("onClientResourceStart",resourceRoot,function()
    for k,v in pairs(dgs) do 
        addEventHandler("onDgsMouseClickDown",v,dgs_click)
    end
    for k,v in ipairs(profile_img_table) do 
        addEventHandler("onDgsMouseClickDown",v,dgs_click)
    end
    
    for k,v in pairs(games) do 
        addEventHandler("onDgsMouseClickDown",v.btn,games_click)
    end
end)


function games1()
    -- print("bok")
end

function games2()
    -- print("kokina")
end



function dgsZoomTo(element,relative,path,index)
    if not element then return end
    local move_x = 0.1
    local move_y = 0.05
    if index %3 == 0 then
        move_x = 0.6
        move_y = 0.05
    elseif index % 2 == 0 and index %4 ~= 0 then 
        move_x = 0.35
        move_y = 0.05
    elseif index % 5 == 0 then 
        move_x = 0.3
        move_y = 0.05
    end
    local px,py = dgsGetPosition(dgs.games_scroll_bar,true)
    local pw,ph = dgsGetSize(dgs.games_scroll_bar,true)
    local rounded = dgsCreateRoundRect(15,false,tocolor(255,255,255,255))
    local img = dxCreateTexture(path)
    dgsRoundRectSetTexture(rounded, img)
    element = dgsCreateImage(px+move_x,py+move_y,0.05,0.15,rounded,relative,dgs.background_img)
    dgsSizeTo(element,1.1,1.1,relative,"Linear",500)
    dgsMoveTo(element,-0.01,-0.01,relative,"Linear",500)
    dgsAlphaTo(element,0,"Linear",500,1100)
    setTimer(function(elm) destroyElement(elm) end,1200,1,element)
end





