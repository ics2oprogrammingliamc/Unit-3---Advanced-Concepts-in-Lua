-- Title: WidgetsAndTransitions
-- Name: Liam Csiffary
-- Course: ICS2O/3C
-- This program is a simulation to help learn the differnet transitions in lua
-----------------------------------------------------------------------------------------

-- Hiding Status Bar
display.setStatusBar( display.HiddenStatusBar )

-----------------------------------------------------------------------------------------

-- Calling composer library
local composer = require( "composer" )

-----------------------------------------------------------------------------------------

-- Tansitioning to the menu screen
composer.gotoScene( "main_menu" )