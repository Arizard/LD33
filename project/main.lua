-- Ludum Dare 33
-- Redacted Studios
-- Arizard, TheQuinn, Rukai

TDF = {}
TDF.States = {}

TDF.Names = {
	"Brobert",
	"Aurelius",
	"Lucas",
	"Arthur",
	"Pendleburry",
	"Zaphod",
	"Runalot",
	"Michael",
	"Ryan",
	"Gavin",
	"Geoffrey",
	"Lindsay",
	"Jack",
	"Jeremy",
	"Matthew",
	"Andrew",
	"Mitchell",
	"Reeks",
	"Benjamin",
	"Jaime",
	"Bronn",
	"Hotpie",
	"Fiddlesticks",
	"Maxwell",
	"Steve",
	"Markus",
	"Carlos",
	"Peter",
	"Phil",
	"Stuart",
	"Knight",
	"Chief",
	"Teal'c",
	"Carter",
	"Hammond",
}

TDF.Adjectives = {
	"Brave",
	"Cowardly",
	"Fleetfooted",
	"Lovely",
	"Kind",
	"Mean",
	"Rude",
	"Hopeless",
	"Smart",
	"Intelligent",
	"Clumsy",
	"Barely Legal",
	"Possibly Not A Knight",
	"Certainly Not A Knight",
	"Dastardly",
	"Dumb",
	"Moronic",
	"Fabulous",
	"Cheater",
	"Hacker",
	"Unbelievable",
	"Superfluous",
	"Impoverished Game Developer",
	"Crybaby",
	"Mad",
	"Myterious",
	"Boring",
	"Free Spirit",
	"Bastard",
	"Kingslayer",
	"Incestuous",
	"Dragonlover",
	"Northerner",
	"Australian",
	"Politician",
	"False God",
	"Cultist",
}

-- fonts

TDF.Fonts = {}
TDF.Fonts.MainLarge = love.graphics.newFont("assets/fonts/Kevin Eleven.ttf", 48)
TDF.Fonts.MainMedium = love.graphics.newFont("assets/fonts/Kevin Eleven.ttf", 18)
TDF.Fonts.MainSmall = love.graphics.newFont("assets/fonts/Kevin Eleven.ttf", 12)

TDF.Fonts.Default = love.graphics.newFont(12)

TDF.Images = {}
TDF.Images.Knight_Title = love.graphics.newImage( "assets/images/knight_title_placeholder.png" )
TDF.Images.Ghost_Title = love.graphics.newImage( "assets/images/ghost_title_placeholder.png" )
TDF.Images.Title_Title = love.graphics.newImage( "assets/images/game_title_placeholder.png" )

TDF.Ticker = 0

function love.load()
	love.window.setTitle( "TDF - LD33" )
	love.window.setMode( 1024, 576 )

	TDF.GameState = require( "hump.gamestate" )
	TDF.Timer = require( "hump.timer" )
	TDF.Vector = require( "hump.vector" )
	TDF.Class = require( "hump.class" )
	anim8 = require( "anim8" )
	
	camera = require( "hump.camera" )

	TDF.Cam = camera(0,0,1,0)


	require( "states.menu" )
	require( "states.menu2" )
	require( "states.game" )
	require( "states.ingame_test" )
	require( "states.level01" )

	require( "classes.entity" )
	require( "classes.button" )
	require( "classes.solid" )
	require( "classes.ghost" )
	require( "classes.mob" )
	require( "classes.hero" )
	require( "classes.grass" )
	require( "classes.trigger" )

	TDF.Version = "Dank Version"
	TDF.Authors = { "Arizard", "Rukai", "TheQuinn" }
	TDF.dt = 0

	TDF.Gravity = 98*2

	TDF.GameState.registerEvents();
	TDF.GameState.switch( TDF.States.Menu );

	--TDF.currentMusic = love.audio.newSource("assets/music/Wagon Wheel.mp3")
	--TDF.currentMusic:play()
	--TDF.currentMusic:setVolume(0.7)
end

function love.keypressed( key, isrepeat )
	if key == "2" then
		if TDF.GameState.current() == TDF.States.Menu then
			TDF.GameState.switch( TDF.States.Menu2 )
		else
			TDF.GameState.switch( TDF.States.Menu )
		end
	end
	if key == "1" then
		TDF.GameState.switch( TDF.States.Level01 )
	end
end


function love.draw( )
	love.graphics.setFont( TDF.Fonts.Default )

	-- debug things, these should go at the END.
	love.graphics.setColor( 0,255,0 )
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
	TDF.Ticker = TDF.Ticker + dt -- number of seconds since program started
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

function TDF.CheckCollide( ent1, ent2 ) -- performs AABB collision check between two entities, prerequisites are both entities have a self.hitbox table

	local x1, y1, w1, h1, x2, y2, w2, h2 = ent1.hitbox.x, ent1.hitbox.y, ent1.hitbox.w, ent1.hitbox.h, ent2.hitbox.x, ent2.hitbox.y, ent2.hitbox.w, ent2.hitbox.h
	
	if ent1.dx then
		x1 = x1 + ent1.dx * TDF.dt
	end

	if ent1.dy then
		y1 = y1 + ent1.dy * TDF.dt
	end

	if ent2.dx then
		x2 = x2 + ent2.dx * TDF.dt
	end

	if ent2.dy then
		y2 = y2 + ent2.dy * TDF.dt
	end

	local xCheck = x1 + w1 > x2 and x1 < x2 + w2
	local yCheck = y1 + h1 > y2 and y1 < y2 + h2

	local collide = (xCheck and yCheck)

	-- fire a trace outwards to check if it's possible to move in that direction

	local x3 = x1 + w1/2
	local y3 = y1 + h1/2
	local x4 = x2 + w2/2
	local y4 = y2 + h2/2

	local ho = false
	local ve = false

	local padx = 5
	local pady = 5

	padx = math.sqrt( math.pow(math.abs( ent1.dx or 5 ),2) + math.pow(math.abs( ent2.dx or 5 ),2) )
	pady = math.sqrt( math.pow(math.abs( ent1.dy or 5 ),2) + math.pow(math.abs( ent2.dy or 5 ),2) )

	if y1 < y2 and x1 < x2 then
		if math.abs(y1 + h1 - y2) < pady then
			ve = true
		elseif math.abs(x1 + w1 - x2) < padx then
			ho = true
		end
	end

	if y2 < y1 and x2 < x1 then
		if math.abs(y2 + h2 - y1) < pady then
			ve = true
		elseif math.abs(x2 + w2 - x1) < padx then
			ho = true
		end
	end

	if y1 < y2 and x2 < x1 then
		if math.abs(y1 + h1 - y2) < pady then
			ve = true
		elseif math.abs(x2 + w2 - x1) < padx then
			ho = true
		end
	end

	if y2 < y1 and x1 < x2 then
		if math.abs(y2 + h2 - y1) < pady then
			ve = true
		elseif math.abs(x1 + w1 - x2) < padx then
			ho = true
		end
	end
	
	-- vertical collision takes priority on a per-solid basis

	return collide, ho, ve
end

function math.clamp( x, min, max ) -- clamp a value x
	if x < min then x = min end
	if x > max then x = max end

	return x
end

function love.graphics.getTileDimensions( img, x, y, w, h )
	local iw, ih = img:getWidth(), img:getHeight()

	local xrep = math.floor( w / iw )
	local yrep = math.floor( h / ih )
	
	return xrep, yrep
end

function love.graphics.tileImage( img, x, y, w, h )

	local iw, ih = img:getWidth(), img:getHeight()
	local xrep, yrep = love.graphics.getTileDimensions( img, x, y, w, h )

	for i = 1, xrep do
		for j = 1, yrep do
			love.graphics.draw( img, x + (i-1)*iw, y + (j-1)*ih )
		end
	end

end

function QuadLerp( frac, p1, p2 )

    local y = (p1-p2) * (frac -1)^2 + p2
    return y

end

function InverseLerp( pos, p1, p2 )

	local range = 0
	range = p2-p1

	if range == 0 then return 1 end

	return ((pos - p1)/range)

end