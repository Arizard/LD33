-- Ludum Dare 33
-- Redacted Studios
-- Arizard, TheQuinn, Rukai

TDF = {}
TDF.States = {}



function love.load()
	love.window.setTitle( "TDF - LD33" )

	TDF.GameState = require( "hump.gamestate" )
	TDF.Timer = require( "hump.timer" )
	TDF.Vector = require( "hump.vector" )
	TDF.Class = require( "hump.class" )

	require( "states.menu" )
	require( "states.menu2" )

	require( "classes.button")


	TDF.Version = "Dank Version"
	TDF.Authors = { "Arizard", "Rukai", "TheQuinn" }
	TDF.dt = 0

	TDF.GameState.registerEvents();
	TDF.GameState.switch( TDF.States.Menu );
end

function love.keypressed( key, isrepeat )
	if key == " " then
		if TDF.GameState.current() == TDF.States.Menu then
			TDF.GameState.switch( TDF.States.Menu2 )
		else
			TDF.GameState.switch( TDF.States.Menu )
		end
	end
end

function love.draw( )

	-- debug things, these should go at the END.
	love.graphics.setColor( 255,255,255 )
	local debugprints = {
		"Framerate : "..tostring( love.timer.getFPS() ),
		"Tickrate : "..tostring( math.ceil(1/TDF.dt) )
	}
	
	for i = 1, #debugprints do
		love.graphics.print( debugprints[i], 0, 12*(i-1) )
	end

end

function love.update( dt )
	TDF.dt = dt
end


-- how to use classes this way
-- create a class in the state:init() function of your gamestate
-- call TDF.AddClassToGameState( state, class ) to add it to the gamestate's Entities table
-- in the gamestate's Update and Draw loops, call the corrsponding TDF.<Draw/Update>GameStateEntities( state )
-- this will run the draw and update functions of each class in the entities table
-- as a result, these entities will not draw when in other gamestates, however they are not removed from memory.
-- TDF.AddClassToGameState returns the index of the newly added class in the Entities table. Call table.remove and use the index to remove the class.

-- function to add an class to a gamestate -- all gamestates used with this must have their own gamestate.Entities table.
function TDF.AddClassToGameState( state, class )
	table.insert( state.Entities, class )
	return #state.Entities
end

function TDF.DrawGameStateEntities( state )
	for k,v in ipairs( state.Entities ) do
		v:draw()
	end
end

function TDF.UpdateGameStateEntities( state, dt )
	for k,v in ipairs( state.Entities ) do
		v:update( dt )
	end
end

function TDF.ClearGameStateEntities( state ) -- removes all classes from the gamestate
	for k,v in ipairs( state.Entities ) do
		state.Entities[k] = nil
	end
end