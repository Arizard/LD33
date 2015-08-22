Trigger = TDF.Class{ __includes = {Solid} }

function Trigger:Initialize()
	self.type = "Trigger"

end

function Trigger:draw()

	love.graphics.setColor( 255,0,0,100 )
	love.graphics.rectangle( "fill", self.x, self.y, self.w, self.h )

end

function Trigger:RunOnEntity( ent )

end