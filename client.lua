--[[
    "Анимация при наведении на блок, должна быть такой-же как на примере выше;".
    Разработано на чистом DX, анимация есть, адаптация присутствует.

    По-человечески, я сделал только анмацию при первичном наведении, потому что боялся, что
    если я выполню что-то не по ТЗ(Сделаю анимацию при убирании мыши с элемента), то по этому заданию будет отказ.
    Если нужно - я обязательно сделаю что-то другое, что нужно будет.
    Так сделал, потому что я человек прямолинейный, что написано - то будет сделано, а если я уже буду работать с вами, то я буду делать всё сверх нормы по привычке)
    Если говорить короче - ресурс сделан на "скорую руку", не судите его строго. У меня есть большое портфолио, если хотите - я покажу его, оно вам понравится думаю.
    Не подумайте, что я плохой скриптер, <3 (В ib я ориентируюсь всяко лучше :) )
]]--

local x, y = guiGetScreenSize()
local sx, sy = x / 1920, y / 1080
local centerX, centerY = x / 2, y / 2

local isFunctionCalled = false

function ShowUI()
    local pi = 3.14
    local numElements = 5
    local angle = 2 * pi / numElements
    local radius = 200
    local text = "Test"

    for i = 1, numElements do

        local ellipseX = (centerX - 161 / 2) + radius * math.cos(angle * i)
        local ellipseY = (centerY - 161 / 2) + radius * math.sin(angle * i)

        local pictureX = (centerX - 100 / 2) + radius * math.cos(angle * i)
        local pictureY = (centerY - 100 / 2) + radius * math.sin(angle * i)
        local pictureToMove = pictureY - 20

        local dashX = (centerX - 161 / 2) + radius * math.cos(angle * i)
        local dashY = (centerY - 161 / 2) + radius * math.sin(angle * i)
        local dashSize = 161

        local textX = (centerX - string.len(text)/ 2) + radius * math.cos(angle * i) - 20
        local textY = (centerY - 100 / 2) + radius * math.sin(angle * i) + 60
        local textToMove = textY + 20

        local function isCursorOnElement( posX, posY, width, height )
            if isCursorShowing( ) then
                local mouseX, mouseY = getCursorPosition( )
                local clientW, clientH = guiGetScreenSize( )
                local mouseX, mouseY = mouseX * clientW, mouseY * clientH
                if ( mouseX > posX and mouseX < ( posX + width ) and mouseY > posY and mouseY < ( posY + height ) ) then
                    return true
                else
                    isFunctionCalled = false
                    return false
                end
            end
            return false
        end

        local function drawCircleDash()
            local startTime = getTickCount()
            addEventHandler("onClientRender", root, function()
                if isCursorOnElement(ellipseX * sx, ellipseY * sy, 161 * sx, 161 * sy) and not isFunctionCalled then
                    isFunctionCalled = true

                    local duration = 2500
                    local elapsedTime = getTickCount() - startTime
                    local progress = elapsedTime / duration
                    
                    dashSize = interpolateBetween(dashSize * sx, 0, 0, 179 * sx, 0, 0, progress, "Linear")
                    dashX = interpolateBetween(dashX * sx, 0, 0, ((centerX - 179 / 2) + radius * math.cos(angle * i)) * sx, 0, 0, progress, "Linear")
                    dashY = interpolateBetween(dashY * sy, 0, 0, ((centerY - 179 / 2) + radius * math.sin(angle * i)) * sy, 0, 0, progress, "Linear")
                    pictureY = interpolateBetween(pictureY * sy, 0, 0, pictureToMove * sy, 0, 0, progress, "Linear")

                    dxDrawImage (dashX, dashY, dashSize, dashSize, 'files/dash.png', angle )
                    dxDrawText(text, textX * sx, textY * sy, x, y, tocolor(0, 0, 0, 255), 1, "pricedown")
                    textY = interpolateBetween(textY * sy, 0, 0, textToMove * sy, 0, 0, progress, "Linear")
                end
            end)
        end

        addEventHandler("onClientRender", root, function()
            dxDrawImage ( ellipseX * sx, ellipseY * sy, 161 * sx, 161 * sy, 'files/ellipse.png', angle )
            dxDrawImage ( pictureX * sx, pictureY * sy, 100 * sx, 100 * sy, 'files/'..i..'.png', angle )
            if isCursorOnElement(ellipseX * sx, ellipseY * sy, 161 * sx, 161 * sy) then
                drawCircleDash()
            end
        end)
    end
    showCursor(true)
end
ShowUI()