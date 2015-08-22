TDF.States.Level01 = {}

local state = TDF.States.Level01
state.Entities = {}
state.Solids = {}

local levelSolids = {
	{ 0, 576-32, 3000, 32 }
}

function state:init()
	
	for i = 1, #levelSolids do
		v = levelSolids[i]
		local newSolid = Solid( v[1],v[2],v[3],v[4] )

		TDF.AddClassToGameState( self, newSolid )
		table.insert( self.Solids, newSolid )

	end

	local newHero = Hero( 100, 100, 32, 64 )

	newHero:SetCollisionTable( self.Solids )

	TDF.AddClassToGameState( self, newHero )

	local player = Ghost( 100, 100)

	TDF.AddClassToGameState( self, player )

    TDF.AddClassToGameState( self, Mob(200, 200) )
end

function state:enter()
	
end

function state:leave()

end

function state:update( dt )
	TDF.UpdateGameStateEntities( self, dt )
end

function state:draw( )
	TDF.Cam:attach()
	--love.graphics.print("Menu State", 32, 32)
	TDF.DrawGameStateEntities( self )

	TDF.Cam:detach()

end
