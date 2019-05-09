-- Title: SampleVideoGame
-- Name: Liam Csiffary
-- Course: ICS2O/3C
-- This program is my first game where you pick up a turtle and drop it into a box.
-----------------------------------------------------------------------------------------

display.setStatusBar(display.HiddenStatusBar)

-----------------------------------------------------------------------------------------

-- Use composer library
local composer = require( "composer" )

-----------------------------------------------------------------------------------------

-- Go to the intro screen
composer.gotoScene( "splash_screen" )
