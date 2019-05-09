-----------------------------------------------------------------------------------------
--
-- main_menu
-- Title: SSG (SuperSlamGames)
-- Name: Liam Csiffary
-- Course: ICS2O/3C
-- This program is the main menu screen, this is where the user is put after the splash screen, and it allows then to view the other screens
-----------------------------------------------------------------------------------------

display.setStatusBar(display.HiddenStatusBar)
-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-----------------------------------------------------------------------------------------

-- Use Widget Library
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "main_menu"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- Global vars
-----------------------------------------------------------------------------------------

soundOn = true

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

local bkg_image

local playButton
local creditsButton
local instructionsButton

local muteButton
local unmuteButton
-----------------------------------------------------------------------------------------
-- Sounds
-----------------------------------------------------------------------------------------

local bkgMusicMM = audio.loadStream("Sounds/mmBKGmusic.mp3")
local bkgMusicMMChannel = audio.play( bkgMusicMM, { channel=1, loops=-1 } )

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------
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

-- Creating Transition Function to Credits Page
local function CreditsTransition( )       
    composer.gotoScene( "credits_screen", {effect = "zoomInOutFade", time = 500})
end 

-----------------------------------------------------------------------------------------

-- Creating Transition to Level1 Screen
local function Level1ScreenTransition( )
    composer.gotoScene( "level1_screen", {effect = "crossFade", time = 1000})
end    

local function InstructionsTransition( )
    composer.gotoScene( "instructions_screen", {effect = "zoomInOutRotate", time = 1000})
end

local function LevelsScreenTransition( )
    composer.gotoScene( "levels_screen", {effect = "zoomInOutRotate", time = 1000})
end

-- INSERT LOCAL FUNCTION DEFINITION THAT GOES TO INSTRUCTIONS SCREEN 

-----------------------------------------------------------------------------------------
-- Global Scene Functions
-----------------------------------------------------------------------------------------


-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------
    -- BACKGROUND IMAGE & STATIC OBJECTS
    -----------------------------------------------------------------------------------------

    -- Insert the background image and set it to the center of the screen
    bkg_image = display.newImage("Images/MainMenuNathan@2x.png")
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

    muteButton = display.newImageRect("Images/Mute.png", 200, 200)
    muteButton.x = display.contentWidth*1.5/10
    muteButton.y = display.contentHeight*1.3/10
    muteButton.isVisible = true

    unmuteButton = display.newImageRect("Images/UnMute.png", 200, 200)
    unmuteButton.x = display.contentWidth*1.5/10
    unmuteButton.y = display.contentHeight*1.3/10
    unmuteButton.isVisible = false

    -- Associating display objects with this scene 
    sceneGroup:insert( bkg_image )

    -- Send the background image to the back layer so all other objects can be on top
    bkg_image:toBack()

    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------   

    -- Creating Play Button
    playButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth/2,
            y = display.contentHeight*7/8,

            -- Insert the images here
            defaultFile = "Images/PlayButtonUnpressedYourName@2x.png",
            overFile = "Images/PlayButtonPressedYourName@2x.png",

            width =  250, 
            height = 125,

            -- When the button is released, call the Level1 screen transition function
            onRelease = Level1ScreenTransition          
        } )

    -----------------------------------------------------------------------------------------

    -- Creating Credits Button
    creditsButton = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*7/8,
            y = display.contentHeight*7/8,

            -- Insert the images here
            defaultFile = "Images/CreditsButtonUnpressedYourName@2x.png",
            overFile = "Images/CreditsButtonPressedYourName@2x.png",

            width = 200,
            height = 100,
            -- When the button is released, call the Credits transition function
            onRelease = CreditsTransition
        } ) 
    

        -- Creating instructions Button
    instructionsButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*1/8,
            y = display.contentHeight*7/8,

            -- Insert the images here
            defaultFile = "Images/InstructionsButtonUnpressedTaishaunJ@2x.png",
            overFile = "Images/InstructionsButtonPressedTaishaunJ@2x.png",

            width = 200,
            height = 100,

            -- When the button is released, call the Level1 screen transition function
            onRelease = InstructionsTransition       
        } )


    levelsButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*1/8,
            y = display.contentHeight*5/8,

            -- Insert the images here
            defaultFile = "Images/LevelsButtonUnpressedYourName@2x.png",
            overFile = "Images/LevelsButtonPressedYourName@2x.png",

            width =  200, 
            height = 100,

            -- When the button is released, call the Level1 screen transition function
            onRelease = LevelsScreenTransition          
        } )

    -----------------------------------------------------------------------------------------

    -- Associating button widgets with this scene
    sceneGroup:insert( playButton )
    sceneGroup:insert( creditsButton )
    sceneGroup:insert( instructionsButton )
    sceneGroup:insert( levelsButton )
    sceneGroup:insert( muteButton )
    sceneGroup:insert( unmuteButton )


end -- function scene:create( event )   



-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is still off screen (but is about to come on screen).   
    if ( phase == "will" ) then
       
    -----------------------------------------------------------------------------------------

    -- Called when the scene is now on screen.
    -- Insert code here to make the scene come alive.
    -- Example: start timers, begin animation, play audio, etc.
    elseif ( phase == "did" ) then       
        
        bkgMusicMMChannel = audio.play(bkgMusicMM)
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
        bkgMusicMMChannel = audio.stop()
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
        muteButton:removeEventListener("touch", Mute)
        unmuteButton:removeEventListener("touch", UnMute)
    end

end -- function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

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