TDF.States.Level01 = {}

local state = TDF.States.Level01
state.Entities = {}
state.Solids = {}

local levelSolids = {
	{ 500, 576-197, 55*2, 55*4 },
	{ -55*10, 576-55, 55*100, 55*10 }

}

function state:init()
	
	for i = 1, #levelSolids do
		v = levelSolids[i]
		local newSolid = Grass( v[1],v[2],v[3],v[4] )

		TDF.AddClassToGameState( self, newSolid )
		table.insert( self.Solids, newSolid )

	end

	local newHero = Hero( 0, 576-102-64, 70, 107 )

	newHero:SetCollisionTable( self.Solids )

	TDF.AddClassToGameState( self, newHero )

	local player = Ghost( 100,100, 20, 20 )

	TDF.AddClassToGameState( self, player )
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
