Solid = TDF.Class{
	init = function( self, x, y, w, h) -- a rectangular, static solid, which collides with monsters and hero (but not player, he's a ghost)
		self.name = "solid"
		self.x, self.y, self.w, self.h = x, y, w, h

		self.col = { r = 255, g = 255, b = 255, a = 255 }

		self.hitbox = {}
		self.hitbox.x, self.hitbox.y, self.hitbox.w, self.hitbox.h = x, y, w, h

	end
}

function Solid:update( dt )

end

function Solid:draw( )

	love.graphics.setColor( 0,0,255 )
	love.graphics.rectangle( "line", self.x, self.y, self.w, self.h )

end