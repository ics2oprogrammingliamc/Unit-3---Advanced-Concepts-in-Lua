-----------------------------------------------------------------------------------------
-- Title: Dragging Answers into Boxes
-- Name: Liam Csiffary
-- Course: ICS2O/3C
-- This program is a simulator in which you drag objects into boxes
-----------------------------------------------------------------------------------------------------

-- Hiding Status Bar
display.setStatusBar( display.HiddenStatusBar )

-- Use composer library
local composer = require( "composer" )

-----------------------------------------------------------------------------------------
-- Go to the intro screen
composer.gotoScene( "level1_screen" )