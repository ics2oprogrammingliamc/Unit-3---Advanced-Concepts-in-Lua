-----------------------------------------------------------------------------------------
--
-- Title: Simple Platform Game
-- Name: Liam Csiffary
-- Course: ICS2O/3C
-- This program is a simple platformer where your avatar moves arround answering math questions to advance.

-----------------------------------------------------------------------------------------

-- Hiding Status Bar
display.setStatusBar( display.HiddenStatusBar )

-----------------------------------------------------------------------------------------

-- Use composer library
local composer = require( "composer" )

-----------------------------------------------------------------------------------------

-- Go to the intro screen
composer.gotoScene( "level1_screen" )