-----------------------------------------------------------------------------------------
--
-- level1_screen.lua
-- Title: SSG (SuperSlamGames)
-- Name: Liam Csiffary
-- Course: ICS2O/3C
-- This program is the level 1 screen of the program it is where the user starts to play the game.

-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "level1_screen"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- The local variables for this scene
local bkg_image

local moose

-- create apples
local apple1
local apple2
local apple3
local apple4
local apple5
local apple6
local apple7
local apple8
local apple9
local apple10
local apple11

local motionx = 0
local motiony = 0
local SPEED = 6
local SPEEDR = -6


local rArrow
local lArrow
local uArrow
local dArrow

----------------------------------------------------------------------
-- LOCAL SCENE FUNCTIONS
----------------------------------------------------------------------

-- when right arrow is touched move right
local function right (touch)
    motionx = SPEED
    moose.xScale = -1
end

-- when right arrow is touched move right
local function left (touch)
    motionx = SPEEDR
    moose.xScale = -1
end

-- when right arrow is touched move right
local function up (touch)
    motionx = SPEED
    moose.yScale = +1
end

-- when right arrow is touched move right
local function down (touch)
    motionx = SPEED
    moose.yScale = -1
end

local function movePlayerX (event)
    character.x = character.x + motionx
end

local function movePlayerY (event)
    character.y = character.y + motiony
end

local function stop (event)
    if (event.phase == "ended") then
        motionx = 0
        motiony = 0
    end
end

local function AddCollisionListeners()
    -- if character collides with ball, onCollision will be called
    apple1.collision = onCollision
    apple1:addEventListener( "collision" )
    apple2.collision = onCollision
    apple2:addEventListener( "collision" )
    apple3.collision = onCollision
    apple3:addEventListener( "collision" )
    apple4.collision = onCollision
    apple4:addEventListener( "collision" )
    apple5.collision = onCollision
    apple5:addEventListener( "collision" )
    apple6.collision = onCollision
    apple6:addEventListener( "collision" )
    apple7.collision = onCollision
    apple7:addEventListener( "collision" )
    apple8.collision = onCollision
    apple8:addEventListener( "collision" )
    apple9.collision = onCollision
    apple9:addEventListener( "collision" )
    apple10.collision = onCollision
    apple10:addEventListener( "collision" )
    apple11.collision = onCollision
    apple11:addEventListener( "collision" )

    moose.collision = onCollision
    moose:addEventListener( "collision" )
end

local function RemoveCollisionListeners()
    apple1:removeEventListener( "collision" )
    apple2:removeEventListener( "collision" )
    apple3:removeEventListener( "collision" )
    apple4:removeEventListener( "collision" )
    apple5:removeEventListener( "collision" )
    apple6:removeEventListener( "collision" )
    apple7:removeEventListener( "collision" )
    apple8:removeEventListener( "collision" )
    apple9:removeEventListener( "collision" )
    apple10:removeEventListener( "collision" )
    apple11:removeEventListener( "collision" )

    moose:removeEventListener( "collision" )
end    


-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    -- Insert the background image
    bkg_image = display.newImageRect("Images/Level1ScreenNathan@2x.png", display.contentWidth, display.contentHeight)
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

    -- Send the background image to the back layer so all other objects can be on top
    bkg_image:toBack()

        -- Insert background image into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( bkg_image )    

    moose = display.newImageRect("Images/MooseCharacterLiamC.png", 200, 100)
    moose.x = 190
    moose.y = 650
    moose:scale(1.8,2.8)

    -- create apples
    apple1 = display.newImageRect("Images/ApplesNathan@2x.png", 100, 100)
    apple1.x = 390
    apple1.y = 730
    apple1:scale(.3,.3)

    apple2 = display.newImageRect("Images/ApplesNathan@2x.png", 100, 100)
    apple2.x = 490
    apple2.y = 640
    apple2:scale(.3,.3)

    apple3 = display.newImageRect("Images/ApplesNathan@2x.png", 100, 100)
    apple3.x = 530
    apple3.y = 730
    apple3:scale(.3,.3)

    apple4 = display.newImageRect("Images/ApplesNathan@2x.png", 100, 100)
    apple4.x = 630
    apple4.y = 670
    apple4:scale(.3,.3)

    apple5 = display.newImageRect("Images/ApplesNathan@2x.png", 100, 100)
    apple5.x = 660
    apple5.y = 730
    apple5:scale(.3,.3)

    apple6 = display.newImageRect("Images/ApplesNathan@2x.png", 100, 100)
    apple6.x = 750
    apple6.y = 680
    apple6:scale(.3,.3)

    apple7 = display.newImageRect("Images/ApplesNathan@2x.png", 100, 100)
    apple7.x = 770
    apple7.y = 730
    apple7:scale(.3,.3)

    apple8 = display.newImageRect("Images/ApplesNathan@2x.png", 100, 100)
    apple8.x = 846
    apple8.y = 690
    apple8:scale(.3,.3)

    apple9 = display.newImageRect("Images/ApplesNathan@2x.png", 100, 100)
    apple9.x = 880
    apple9.y = 730
    apple9:scale(.3,.3)

    apple10 = display.newImageRect("Images/ApplesNathan@2x.png", 100, 100)
    apple10.x = 965
    apple10.y = 690
    apple10:scale(.3,.3)

    apple11 = display.newImageRect("Images/ApplesNathan@2x.png", 100, 100)
    apple11.x = 1000
    apple11.y = 730
    apple11:scale(.3,.3)



end --function scene:create( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then

        -- Called when the scene is still off screen (but is about to come on screen).
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then

        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.

    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.

end -- function scene:destroy( event )

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- Adding Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
