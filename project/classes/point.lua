Point = TDF.Class{
	init = function( self, x, y )
		self.x = x
		self.y = y

		self.type = "Point"
		self:Initialize()
	end
}

function Point:Initialize()

end

function Point:update()
end

function Point:draw()

	love.graphics.setColor( 255,0,0,100 )
	love.graphics.rectangle( "fill", self.x, self.y, 2,2 )

end