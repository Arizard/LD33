TDF.States.Ingame_Test = {}

local state = TDF.States.Ingame_Test
state.Entities = {}
state.Solids = {}

local levelSolids = {
	{ 75, 0, 400, 100 },
	{ 200, 0, 24, 1030}
}

function state:init()
	
	for k,v in ipairs( levelSolids ) do

		local newSolid = Solid( v[1],v[2],v[3],v[4] )

		TDF.AddClassToGameState( self, newSolid )
		table.insert( self.Solids, newSolid )

	end

	local newNPC = NPC( 100, 400, 32, 64 )

	newNPC:SetCollisionTable( self.Solids )

	TDF.AddClassToGameState( self, newNPC )
end

function state:enter()
	
end

function state:leave()

end

function state:update( dt )
	TDF.UpdateGameStateEntities( self, dt )
end

function state:draw( )
	--love.graphics.print("Menu State", 32, 32)
	TDF.DrawGameStateEntities( self )

end
