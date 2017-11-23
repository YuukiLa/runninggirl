-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local composer = require("composer")

display.setStatusBar(display.HiddenStatusBar)
composer.recycleOnSceneChange = true
local data = audio.loadStream("assets/sound/background.mp3")
--audio.seek(0, data, {channel = 0})
audio.play(data, {channel = 0, loops = -1})


-- composer.gotoScene("scene.mainMenu", {params = {username = "yuuki"}})
composer.gotoScene("scene.login")