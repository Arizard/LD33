TDF.States.Level01 = {}

local state = TDF.States.Level01
state.Entities = {}
state.Solids = {}

local levelSolids = {
	{ 500, 576-157, 55*2, 55*4 },
	{ 500+500, 576-157, 55*2, 55*4 },
	{ 500+500+500, 576-157, 55*8, 55*4 },
	{ -55*10, 576-55, 55*100, 55*10 },

}

function state:init()
	
	for i = 1, #levelSolids do
		v = levelSolids[i]
		local newSolid = Grass( v[1],v[2],v[3],v[4] )

		TDF.AddClassToGameState( self, newSolid )
		table.insert( self.Solids, newSolid )

	end

	local newHero = Hero( 0, 576-102-64, 70-40, 107-20 )

	newHero:SetCollisionTable( self.Entities )

	TDF.AddClassToGameState( self, newHero )

	local newMob = Mob(500, 200, 56-20, 56-20)

	newMob:SetCollisionTable( self.Entities )
    TDF.AddClassToGameState( self, newMob )

	-- create a trigger to make the jumping do the happen
	local jumpTrigger = Trigger( 420, 576-55-2, 16, 2 )

	function jumpTrigger:RunOnEntity( ent )
		if ent.type == "Hero" then
			ent:Jump()
		end
	end

	TDF.AddClassToGameState( self, jumpTrigger )

	local jumpTrigger = Trigger( 420 + 500, 576-55-2, 16, 2 )

	function jumpTrigger:RunOnEntity( ent )
		if ent.type == "Hero" then
			ent:Jump()
		end
	end

	--TDF.AddClassToGameState( self, jumpTrigger )

	local jumpTrigger = Trigger( 420 + 500 + 500, 576-55-2, 16, 2 )

	function jumpTrigger:RunOnEntity( ent )
		if ent.type == "Hero" then
			ent:Jump()
		end
	end

	--TDF.AddClassToGameState( self, jumpTrigger )


	local player = Ghost( 100, 100, 40, 40)

	TDF.AddClassToGameState( self, player )

	player:SetCollisionTable( self.Entities )

	self.player = player

    self.images = {}
    local dir = "assets/images/"
    self.images.background = love.graphics.newImage(dir .. "background.png")
    self.images.hill = love.graphics.newImage(dir .. "hill.png")
    self.images.bush = love.graphics.newImage(dir .. "bush.png")
end

function state:enter()
	
end

function state:leave()

end

function state:keypressed( key, isRepeat )
	self.player:keypressed( key, isRepeat )
end

function state:update( dt )
	TDF.UpdateGameStateEntities( self, dt )
	
end

function state:draw( )

	local cx, cy = TDF.Cam:pos()

	love.graphics.setColor( 190, 245, 245 )
	love.graphics.rectangle( "fill", 0, 0, 1024, 576 )
    love.graphics.draw(self.images.background)
    love.graphics.draw(self.images.hill, 800 - cx * 0.25, 230 - cy * 2/6 )
    love.graphics.draw(self.images.hill, 400 - cx * 0.25, 310 - cy * 1/6)
    love.graphics.draw(self.images.hill, 330 - cx * 0.25, 310 - cy * 1/6)
    love.graphics.tileImage( self.images.bush, -self.images.bush:getWidth() - cx * 0.75, 120-cy * 3/6, self.images.bush:getWidth()*8, self.images.bush:getHeight() )

	TDF.Cam:attach()
	--love.graphics.print("Menu State", 32, 32)
	TDF.DrawGameStateEntities( self )

	TDF.Cam:detach()
end
