------------------------------ -----------------------------------------------------------
--
-- credits_screen.lua
-- Created by: Your Name
-- Special thanks to Wal Wal for helping in the design of this framework.
-- Date: Month Day, Year
-- Description: This is the credits page, displaying a back button to the main menu.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "instructions_screen"

-- Creating Scene Object
scene = composer.newScene( sceneName ) -- This function doesn't accept a string, only a variable containing a string

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
local bkg_image
local backButton

local muteButton
local unmuteButton
-----------------------------------------------------------------------------------------
-- Sounds
-----------------------------------------------------------------------------------------

local bkgMusicInstructions = audio.loadStream("Sounds/instructionsMusic.mp3")
local bkgMusicInstructionsChannel = audio.play(bkgMusicInstructions, { channel=3, loops=-1 } )

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

-- Creating Transitioning Function back to main menu
local function BackTransition( )
    composer.gotoScene( "main_menu", {effect = "zoomOutInFadeRotate", time = 500})
end

local function Mute(touch)
    if (touch.phase == "ended") then
        audio.pause(bkgMusicMM)
        soundOn = false
        muteButton.isVisible = false
        unmuteButton.isVisible = true
    end
end

local function UnMute(touch)
    if (touch.phase == "ended") then
        audio.resume(bkgMusicMM)
        soundOn = true
        muteButton.isVisible = true
        unmuteButton.isVisible = false
    end
end
-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------
    -- BACKGROUND AND DISPLAY OBJECTS
    -----------------------------------------------------------------------------------------

    -- Insert the background image and set it to the center of the screen
    bkg_image = display.newImageRect("Images/Instructions Screen.png", display.contentWidth, display.contentHeight)
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

    -- Associating display objects with this scene 
    sceneGroup:insert( bkg_image )

    -- Send the background image to the back layer so all other objects can be on top
    bkg_image:toBack()

    muteButton = display.newImageRect("Images/Mute.png", 200, 200)
    muteButton.x = display.contentWidth*1.5/10
    muteButton.y = display.contentHeight*1.3/10
    muteButton.isVisible = true

    unmuteButton = display.newImageRect("Images/UnMute.png", 200, 200)
    unmuteButton.x = display.contentWidth*1.5/10
    unmuteButton.y = display.contentHeight*1.3/10
    unmuteButton.isVisible = false

    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------

    -- Creating Back Button
    backButton = widget.newButton( 
    {
        -- Setting Position
        x = display.contentWidth*1/8,
        y = display.contentHeight*15/16,

        -- Setting Dimensions
        -- width = 1000,
        -- height = 106,

        -- Setting Visual Properties
        defaultFile = "Images/BackButtonUnpressedYourName@2x.png",
        overFile = "Images/BackButtonPressedYourName@2x.png",

        width = 250,
        height = 125,

        -- Setting Functional Properties
        onRelease = BackTransition

    } )

    -----------------------------------------------------------------------------------------

    -- Associating Buttons with this scene
    sceneGroup:insert( backButton )
    sceneGroup:insert( muteButton )
    sceneGroup:insert( unmuteButton )

end --function scene:create( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
        bkgMusicInstructionsChannel = audio.play(bkgMusicInstructions) 
        muteButton:addEventListener("touch", Mute)
        unmuteButton:addEventListener("touch", UnMute)
        
    end

end -- function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
        audio.stop(bkgMusicInstructionsChannel)
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

end --function scene:destroy( event )

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