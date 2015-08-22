Grass = Solid

Grass.tiles = {}
Grass.tiles.top = love.graphics.newImage( "assets/images/ground/grassTile0001.png" )
Grass.tiles.topleft = love.graphics.newImage( "assets/images/ground/grassTile0002.png" )
Grass.tiles.topright = love.graphics.newImage( "assets/images/ground/grassTile0003.png" )
Grass.tiles.center = love.graphics.newImage( "assets/images/ground/grassTile0004.png" )
Grass.tiles.bottom = love.graphics.newImage( "assets/images/ground/grassTile0005.png" )
Grass.tiles.bottomleft = love.graphics.newImage( "assets/images/ground/grassTile0006.png" )
Grass.tiles.bottomright = love.graphics.newImage( "assets/images/ground/grassTile0007.png" )
Grass.tiles.left = love.graphics.newImage( "assets/images/ground/grassTile0008.png" )
Grass.tiles.right = love.graphics.newImage( "assets/images/ground/grassTile0009.png" )

function Grass:Initialize()
	
end

function Grass:draw()

	--love.graphics.setColor( 255,0,0 )
	--love.graphics.rectangle( "fill", self.x, self.y, self.w, self.h )

	love.graphics.setColor( 255, 255, 255 )
	
	love.graphics.draw( self.tiles.topleft, self.x, self.y )
	love.graphics.draw( self.tiles.bottomleft, self.x, self.y + self.h - 55 )

	love.graphics.draw( self.tiles.topright, self.x + self.w - 55, self.y )
	love.graphics.draw( self.tiles.bottomright, self.x + self.w - 55, self.y + self.h - 55 )

	local xrep, yrep = love.graphics.getTileDimensions( self.tiles.center, self.x + 55, self.y + 55, self.w - 55*2, self.h - 55*2 )

	if xrep > 0 and yrep >= 0 then
		love.graphics.tileImage( self.tiles.top, self.x + 55, self.y, self.w - 55*2, 55 )
		love.graphics.tileImage( self.tiles.bottom, self.x + 55, self.y + self.h - 55, self.w - 55*2, 55 )
	end

	if xrep >= 0 and yrep > 0 then
		love.graphics.tileImage( self.tiles.left, self.x, self.y + 55, 55, self.h - 55*2 )
		love.graphics.tileImage( self.tiles.right, self.x + self.w - 55, self.y + 55, 55, self.h - 55*2 )
	end

	if xrep > 0 and yrep > 0 then
		love.graphics.tileImage( self.tiles.center, self.x+55, self.y+55, self.w - 55*2, self.h - 55*2 )
	end

	--love.graphics.tileImage( self.tiles.center,  self.x, self.y, self.w, 55 )
end

function Grass:update( dt )

end