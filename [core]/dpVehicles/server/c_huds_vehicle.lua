--载具HUD


vehicleIcon = dgsCreateImage(0.0125, 0.901,0.012,0.02,":X_UI/images/hud/driving.png",true);
dgsSetVisible(vehicleIcon,false);--默认关闭

vehicleLabel = dgsCreateLabel(0.0275, 0.9025, 0.15, 0.012,"Vehicle",true) --create a label
dgsSetProperty(vehicleLabel,"font","sans")
dgsSetProperty(vehicleLabel,"colorCoded",true)
dgsSetVisible(vehicleLabel,false);--默认关闭


vehiclePB = dgsCreateProgressBar(0.0125, 0.9325, 0.152, 0.012, true);--载具生命值
dgsSetProperty(vehiclePB,"padding",{0,0})
dgsSetProperty(vehiclePB,"indicatorColor",COLOR_GREY_ALPHA);
dgsSetProperty(vehiclePB,"bgColor",COLOR_GREY_ALPHA);
dgsSetVisible(vehiclePB,false);--默认关闭


fuelPB = dgsCreateProgressBar(0.0125, 0.925, 0.152, 0.005, true);--载具FUEL
dgsSetProperty(fuelPB,"padding",{0,0})
dgsSetProperty(fuelPB,"indicatorColor",COLOR_YELLOW_ALPHA);
dgsSetProperty(fuelPB,"bgColor",COLOR_GREY_ALPHA);
dgsSetVisible(fuelPB,false);--默认关闭

--车辆状态layout
vehicleLayout = dgsCreateLayout(0.01,0.8715,0.152,0.015,"horizontal",true);
dgsSetVisible(vehicleLayout,false);--默认关闭

--icon
local vIconSize = sH*0.0275;
vEngineIcon = dgsCreateImage(0,0,vIconSize,vIconSize,":X_UI/images/action/vehicle/engine.png",false);
dgsSetVisible(vEngineIcon,false);--默认关闭


vLockIcon = dgsCreateImage(0,0,vIconSize,vIconSize,":X_UI/images/action/vehicle/lock.png",false);
dgsSetVisible(vLockIcon,false);--默认关闭


vLightIcon = dgsCreateImage(0,0,vIconSize,vIconSize,":X_UI/images/action/vehicle/light.png",false);
dgsSetVisible(vLightIcon,false);--默认关闭


vStopIcon = dgsCreateImage(0,0,vIconSize,vIconSize,":X_UI/images/action/vehicle/stop.png",false);
dgsSetVisible(vStopIcon,false);--默认关闭


--dgsLayoutAddItem(vehicleLayout,vEngineIcon);
--dgsLayoutAddItem(vehicleLayout,vLockIcon);
--outputDebugString(dgsLayoutGetItemIndex(vehicleLayout,vEngineIcon));
--outputDebugString(dgsLayoutGetItemIndex(vehicleLayout,vLockIcon));

--TODO 上车后addEventHandler
addEventHandler("onClientRender", root, 
function()
    if isPedInVehicle(localPlayer) then

        local veh = getPedOccupiedVehicle(localPlayer);
        if veh then -- 2次检测
            local vhp = getElementHealth(veh);
            --local vName = getVehicleName(veh);
            local vFuel = getElementData(veh,"Fuel");
            --iprint("vFuel",vFuel);
            local percent = vhp/10;
            --guiSetText(lblVehicle, "Currently:"..tostring(vhp).." "..tostring(percent));
            dgsProgressBarSetProgress(vehiclePB,percent);

            --TODO 可以改为刷出车时判定
            --会有那么一瞬间上车后才产生载具汽油...所以需要判断这个数据是否产生
            if vFuel then
                dgsProgressBarSetProgress(fuelPB,vFuel);
            end

            --MUST DO
        ----ENGINE---------------------------------------------------------------------------------------------
            --SHIT CODE FOR TEST
            local engine = getVehicleEngineState(veh);
            if engine then
                --引起打开了
                --引擎关闭了
                --outputDebugString("engine:"..tostring(engine));
                --outputDebugString("dgsGetParent(vEngineIcon)~=vehicleLayout:"..tostring(dgsGetParent(vEngineIcon)~=vehicleLayout));
                if dgsGetParent(vEngineIcon)~=vehicleLayout then
                    dgsLayoutAddItem(vehicleLayout,vEngineIcon);
                    dgsLayoutSetItemSortPriority(vEngineIcon,5);
                    dgsSetVisible(vEngineIcon,true);--打开
                end
            else
                --引擎关闭了
                --outputDebugString("engine:"..tostring(engine));
                --outputDebugString("dgsGetParent(vEngineIcon)==vehicleLayou:"..tostring(dgsGetParent(vEngineIcon)==vehicleLayou));
                if dgsGetParent(vEngineIcon)==vehicleLayout then
                    dgsLayoutRemoveItem(vehicleLayout,vEngineIcon);
                    dgsSetVisible(vEngineIcon,false);--打开
                end
            end
        ----LOCKED---------------------------------------------------------------------------------------------
            --SHIT CODE FOR TEST
            local locked = isVehicleLocked(veh);
            if locked then
                --引起打开了
                --引擎关闭了
                --outputDebugString("engine:"..tostring(engine));
                --outputDebugString("dgsGetParent(vEngineIcon)~=vehicleLayout:"..tostring(dgsGetParent(vEngineIcon)~=vehicleLayout));
                if dgsGetParent(vLockIcon)~=vehicleLayout then
                    dgsLayoutAddItem(vehicleLayout,vLockIcon);
                    dgsLayoutSetItemSortPriority(vLockIcon,4);
                    dgsSetVisible(vLockIcon,true);--打开
                end
            else
                --引擎关闭了
                --outputDebugString("engine:"..tostring(engine));
                --outputDebugString("dgsGetParent(vEngineIcon)==vehicleLayou:"..tostring(dgsGetParent(vEngineIcon)==vehicleLayou));
                if dgsGetParent(vLockIcon)==vehicleLayout then
                    dgsLayoutRemoveItem(vehicleLayout,vLockIcon);
                    dgsSetVisible(vLockIcon,false);--关闭
                end
            end
        ----LIGHT---------------------------------------------------------------------------------------------
            --SHIT CODE FOR TEST
            local light = getVehicleOverrideLights(veh);
            if light== 2 then
                --引起打开了
                --引擎关闭了
                --outputDebugString("engine:"..tostring(engine));
                --outputDebugString("dgsGetParent(vEngineIcon)~=vehicleLayout:"..tostring(dgsGetParent(vEngineIcon)~=vehicleLayout));
                if dgsGetParent(vLightIcon)~=vehicleLayout then
                    dgsLayoutAddItem(vehicleLayout,vLightIcon);
                    dgsLayoutSetItemSortPriority(vLightIcon,3);
                    dgsSetVisible(vLightIcon,true);--打开
                end
            else
                --引擎关闭了
                --outputDebugString("engine:"..tostring(engine));
                --outputDebugString("dgsGetParent(vEngineIcon)==vehicleLayou:"..tostring(dgsGetParent(vEngineIcon)==vehicleLayou));
                if dgsGetParent(vLightIcon)==vehicleLayout then
                    dgsLayoutRemoveItem(vehicleLayout,vLightIcon);
                    dgsSetVisible(vLightIcon,false);--关闭
                end
            end
        ----STOP---------------------------------------------------------------------------------------------
            --SHIT CODE FOR TEST
            local stop = isElementFrozen(veh);
            if stop then
                --引起打开了
                --引擎关闭了
                --outputDebugString("engine:"..tostring(engine));
                --outputDebugString("dgsGetParent(vEngineIcon)~=vehicleLayout:"..tostring(dgsGetParent(vEngineIcon)~=vehicleLayout));
                if dgsGetParent(vStopIcon)~=vehicleLayout then
                    dgsLayoutAddItem(vehicleLayout,vStopIcon);
                    dgsLayoutSetItemSortPriority(vStopIcon,2);
                    dgsSetVisible(vStopIcon,true);--打开
                end
            else
                --引擎关闭了
                --outputDebugString("engine:"..tostring(engine));
                --outputDebugString("dgsGetParent(vEngineIcon)==vehicleLayou:"..tostring(dgsGetParent(vEngineIcon)==vehicleLayou));
                if dgsGetParent(vStopIcon)==vehicleLayout then
                    dgsLayoutRemoveItem(vehicleLayout,vStopIcon);
                    dgsSetVisible(vStopIcon,false);--关闭
                end
            end
        ---------------------------------------------
        end -- if veh then
    end
end)

--上车
--TODO 进车库时
addEventHandler("onClientVehicleEnter", root,
    function(thePlayer, seat)
        if thePlayer == localPlayer then
            --outputChatBox("ENTER A VEHICLE,SHOWING");
            dgsSetVisible(vehiclePB,true);
            dgsSetVisible(fuelPB,true);

            dgsSetVisible(vehicleLayout,true);--

            dgsSetVisible(vehicleLabel,true);
            local v = getPedOccupiedVehicle(localPlayer);
            local vName = getVehicleName(v);
            local vID = exports.X_Vehicle:getVehID(v);
            --outputChatBox("vID:"..inspect(vID));
            local vType = Loc:Loc("UI_VEH_Temporary");
            if vID then
                vType = "#FFD306"..vID.." | "..Loc:Loc("UI_VEH_Permanent").."#FFFFFF";
            end
            dgsSetProperty(vehicleLabel,"text","[ "..tostring(vType).." ] "..vName);

            dgsSetVisible(vehicleIcon,true);

        end
    end
)

--下车
addEventHandler("onClientVehicleExit", root,
    function(thePlayer, seat)
        if thePlayer == localPlayer then
            --outputChatBox("EXIT A VEHICLE");
            dgsSetVisible(vehiclePB,false);
            dgsSetVisible(fuelPB,false);
            dgsSetVisible(vehicleLabel,false);
            dgsSetVisible(vehicleIcon,false);

            dgsSetVisible(vehicleLayout,false);--
        end
    end
)

