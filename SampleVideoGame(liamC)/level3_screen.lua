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

local character

-- create apples
local apple1
local apple2
local apple3
local apple4
local apple5
local apple6

local theApple

local motionx = 0
local motiony = 0
local SPEED = 6
local SPEEDR = -6
local LINEAR_VELOCITY = -100
local GRAVITY = 4

local rArrow
local lArrow
local uArrow
local dArrow

local heart1
local heart2

local leftW 
local rightW
local topW
local floor

local door

-----------------------------------------------------------------------------------------
-- SOUND VARIABLES
----------------------------------------------------------------------------------------- 

local loseSound = audio.loadSound( "Sounds/YouLose.mp3" )
local loseSoundChannel

local hitSound = audio.loadSound( "Sounds/Pop.mp3" )
local hitSoundChannel

local winSound = audio.loadSound( "Sounds/Cheer.m4a" )
local winSoundChannel

----------------------------------------------------------------------
-- LOCAL SCENE FUNCTIONS
----------------------------------------------------------------------

-- when right arrow is touched move right
local function right (touch)
    print("***Called right")
    motionx = SPEED
    character.xScale = 1
end

-- when right arrow is touched move right
local function left (touch)
    motionx = -SPEED
    character.xScale = -1
end

-- when right arrow is touched move right
local function up (touch)
    motiony = -SPEED
end

local function movePlayer (event)
    print ("***Called movePlayer")
    character.x = character.x + motionx
    character.y = character.y + motiony
end

local function stop (event)
    if (event.phase == "ended") then
        motionx = 0
        motiony = 0
    end
end

local function AddArrowEventListeners()
    print ("***Called AddArrowEventListeners")
    rArrow:addEventListener("touch", right)
    lArrow:addEventListener("touch", left)
    uArrow:addEventListener("touch", up)
end

local function RemoveArrowEventListeners()
    rArrow:removeEventListener("touch", right)
    lArrow:removeEventListener("touch", left)
    uArrow:removeEventListener("touch", up)
end

local function AddRuntimeListeners()
    print ("***Called AddRuntimeListeners")
    Runtime:addEventListener("enterFrame", movePlayer)
    Runtime:addEventListener("touch", stop)
end

local function RemoveRuntimeListeners()
    Runtime:removeEventListener("enterFrame", movePlayer)
    Runtime:removeEventListener("touch", stop)
end

local function ReplaceCharacter()
    print ("***Called ReplaceCharacter")
    character = display.newImageRect("Images/MooseCharacterLiamC.png", 100, 150)
    character.x = display.contentWidth * 1 / 8
    character.y = display.contentHeight  * 0.1 / 3
    character.width = 240
    character.height = 160
    character.myName = "Moose"

    -- intialize horizontal movement of character
    motionx = 0

    -- add physics body
    physics.addBody( character, "dynamic", { density=0, friction=0.5, bounce=0, rotation=0 } )

    -- prevent character from being able to tip over
    character.isFixedRotation = true

    -- add back arrow listeners
    AddArrowEventListeners()

    -- add back runtime listeners
    AddRuntimeListeners()
end


local function MakeAppleVisible()
    apple1.isVisible = true
    apple2.isVisible = true
    apple3.isVisible = true
    apple4.isVisible = true
    apple5.isVisible = true
    apple6.isVisible = true
end

local function MakeHeartsVisible()
    heart1.isVisible = true
    heart2.isVisible = true
end

local function YouLoseTransition()
    apple1.isVisible = false
    apple2.isVisible = false
    apple3.isVisible = false
    apple4.isVisible = false
    apple5.isVisible = false
    apple6.isVisible = false
    loseSoundChannel = audio.play(loseSound)
    composer.gotoScene( "you_lose" )
end

local function onCollision( self, event )
    -- for testing purposes
    --print( event.target )        --the first object in the collision
    --print( event.other )         --the second object in the collision
    --print( event.selfElement )   --the element (number) of the first object which was hit in the collision
    --print( event.otherElement )  --the element (number) of the second object which was hit in the collision
    --print( event.target.myName .. ": collision began with " .. event.other.myName )

    if ( event.phase == "began" ) then

        if  (event.target.myName == "no apple1") or 
            (event.target.myName == "no apple2") or
            (event.target.myName == "no apple3") or 
            (event.target.myName == "no apple4") or
            (event.target.myName == "no apple5") or 
            (event.target.myName == "no apple6") or
            (event.target.myName == "no apple7") or 
            (event.target.myName == "no apple8") or
            (event.target.myName == "no apple9") then ------------- NONE OF THIS SHOULD HAPPEN AS YOU NEVER LOSE LIVES -----------------------------

            -- add sound effect here

            -- remove runtime listeners that move the character
            RemoveArrowEventListeners()
            RemoveRuntimeListeners()

            -- remove the character from the display
            display.remove(character)

            -- decrease number of lives
            numLives = numLives - 1

            -- make sound for when the character gets hit
            hitSoundChannel = audio.play(hitSound)

            if (numLives == 1) then
                -- update hearts
                heart1.isVisible = true
                heart2.isVisible = false
                timer.performWithDelay(200, ReplaceCharacter) 

            elseif (numLives == 0) then
                -- update hearts
                heart1.isVisible = false
                heart2.isVisible = false
                timer.performWithDelay(200, YouLoseTransition)
            end
        end

        if  (event.target.myName == "apple1") or
            (event.target.myName == "apple2") or
            (event.target.myName == "apple3") or
            (event.target.myName == "apple4") or  
            (event.target.myName == "apple5") or
            (event.target.myName == "apple6") then


            -- get the ball that the user hit
            theApple = event.target

            -- stop the character from moving
            motionx = 0

            -- make the character invisible
            character.isVisible = false

            -- show overlay with math question
            composer.showOverlay( "level1_question", { isModal = true, effect = "fade", time = 100})

            -- Increment questions answered
            questionsAnswered = questionsAnswered + 1
        end

        if (event.target.myName == "door") then
            print(questionsAnswered)
            --check to see if the user has answered 5 questions
            if (questionsAnswered == 6) then
                -- after getting 3 questions right, go to the you win screen
                winSoundChannel = audio.play(winSound)
                composer.gotoScene( "you_win" )
            end
        end        

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

    door.collision = onCollision
    door:addEventListener( "collision" )    

end

local function RemoveCollisionListeners()
    apple1:removeEventListener( "collision" )
    apple2:removeEventListener( "collision" )
    apple3:removeEventListener( "collision" )
    apple4:removeEventListener( "collision" )
    apple5:removeEventListener( "collision" )
    apple6:removeEventListener( "collision" )

    door:removeEventListener( "collision" )
end     

local function AddPhysicsBodies()
    physics.addBody(leftW, "static", {density=1, friction=0.3, bounce=0.2} )
    physics.addBody(rightW, "static", {density=1, friction=0.3, bounce=0.2} ) 
    physics.addBody(topW, "static", {density=1, friction=0.3, bounce=0.2} )
    physics.addBody(floor, "static", {density=1, friction=0.3, bounce=0.2} )

    physics.addBody(apple1, "static", {density=0, friction=0, bounce=0} ) 
    physics.addBody(apple2, "static", {density=0, friction=0, bounce=0} ) 
    physics.addBody(apple3, "static", {density=0, friction=0, bounce=0} ) 
    physics.addBody(apple4, "static", {density=0, friction=0, bounce=0} ) 
    physics.addBody(apple5, "static", {density=0, friction=0, bounce=0} ) 
    physics.addBody(apple6, "static", {density=0, friction=0, bounce=0} ) 

    physics.addBody(door, "static", {density=1, friction=0.3, bounce=0.2} )

end

local function RemovePhysicsBodies()
    physics.removeBody(leftW)
    physics.removeBody(rightW)
    physics.removeBody(topW)
    physics.removeBody(floor)

    physics.removeBody(door)
 
end


-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

function ResumeGame()

        -- make character visible again
    character.isVisible = true
    
    if (questionsAnswered > 0) then
        if (theApple ~= nil) and (theApple.isBodyActive == true) then
            physics.removeBody(theApple)
            theApple.isVisible = false
        end
    end

end

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

        -- Insert background image into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( bkg_image )    

    -- create apples
    apple1 = display.newImageRect("Images/ApplesNathan@2x.png", 100, 100)
    apple1.x = 390
    apple1.y = 730
    apple1:scale(.3,.3)
    apple1.myName = "apple1"

    apple2 = display.newImageRect("Images/ApplesNathan@2x.png", 100, 100)
    apple2.x = 490
    apple2.y = 640
    apple2:scale(.3,.3)
    apple2.myName = "apple2"

    apple3 = display.newImageRect("Images/ApplesNathan@2x.png", 100, 100)
    apple3.x = 530
    apple3.y = 730
    apple3:scale(.3,.3)
    apple3.myName = "apple3"

    apple4 = display.newImageRect("Images/ApplesNathan@2x.png", 100, 100)
    apple4.x = 630
    apple4.y = 670
    apple4:scale(.3,.3)
    apple4.myName = "apple4"

    apple5 = display.newImageRect("Images/ApplesNathan@2x.png", 100, 100)
    apple5.x = 660
    apple5.y = 730
    apple5:scale(.3,.3)
    apple5.myName = "apple5"

    apple6 = display.newImageRect("Images/ApplesNathan@2x.png", 100, 100)
    apple6.x = 750
    apple6.y = 680
    apple6:scale(.3,.3)
    apple6.myName = "apple6"

    sceneGroup:insert(apple1)
    sceneGroup:insert(apple2)
    sceneGroup:insert(apple3)
    sceneGroup:insert(apple4)
    sceneGroup:insert(apple5)
    sceneGroup:insert(apple6)

    --Insert the right arrow
    rArrow = display.newImageRect("Images/RightArrowUnpressed.png", 100, 50)
    rArrow.x = display.contentWidth * 9.2 / 10
    rArrow.y = display.contentHeight * 9.5 / 10

    -- insert image fpor up arrow
    uArrow = display.newImageRect("Images/UpArrowUnpressed.png", 50, 100)
    uArrow.x = display.contentWidth * 8.2 / 10
    uArrow.y = display.contentHeight * 8.5 / 10

    lArrow = display.newImageRect("Images/LeftArrowUnpressed.png", 100, 50)
    lArrow.x = display.contentWidth * 7.2 / 10
    lArrow.y = display.contentHeight * 9.5 / 10

    door = display.newImage("Images/Level-1Door.png", 200, 200)
    door.x = display.contentWidth*7/8 
    door.y = display.contentHeight*6.1/7
    door.myName = "door"

    --WALLS--

    leftW = display.newLine( 0, 0, 0, display.contentHeight)
    leftW.isVisible = true

     -- Insert objects into the scene group in order to ONLY be associated with this scene

    rightW = display.newLine( 1024, 0, 1024, display.contentHeight)
    rightW.isVisible = true

     -- Insert objects into the scene group in order to ONLY be associated with this scene   

    topW = display.newLine( 0, 0, display.contentWidth, 0)
    topW.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene    
    floor = display.newImageRect("Images/Ground.png", 1000, 100)
    floor.x = display.contentCenterX
    floor.y = display.contentHeight * 2.1/2
    
    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( floor )
    sceneGroup:insert( topW )
    sceneGroup:insert( rightW )
    sceneGroup:insert( leftW )
    sceneGroup:insert( door )
    sceneGroup:insert( lArrow )
    sceneGroup:insert( rArrow )
    sceneGroup:insert( uArrow ) 



 
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
        physics.start()

    elseif ( phase == "did" ) then

        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.


        questionsAnswered = 0

        -- make all soccer balls visible
        MakeAppleVisible()

        -- add collision listeners to objects
        AddCollisionListeners()

        -- create the character, add physics bodies and runtime listeners
        ReplaceCharacter() 

        AddPhysicsBodies()


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
        RemoveCollisionListeners()
        RemovePhysicsBodies()

        physics.stop()
        RemoveArrowEventListeners()
        RemoveRuntimeListeners()
        display.remove(character)
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
