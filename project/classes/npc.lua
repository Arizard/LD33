NPC = TDF.Class{
	init = function( self, x, y, w, h) -- a rectangular, static solid, which collides with monsters and hero (but not player, he's a ghost)

		self.x, self.y, self.w, self.h = x, y, w, h

		self.col = { r = 255, g = 255, b = 255, a = 255 }

		self.hitbox = {}
		self.hitbox.x, self.hitbox.y, self.hitbox.w, self.hitbox.h = x, y, w, h

		self.solids = {} -- a table full of solids that the npc needs to collide with, since physics are calculated inside the class.

		self.dx, self.dy = 45, 0
		self.ddx, self.ddy = 0, -TDF.Gravity

	end
}

function NPC:SetCollisionTable( tbl )
	self.solids = tbl
end

function NPC:update( dt )

	-- check collisions
	self.ddy = -TDF.Gravity -- gravity

	self.dx = self.dx + self.ddx * dt
	self.dy = self.dy + self.ddy * dt

	for k,v in ipairs( self.solids ) do
		if v.hitbox then
			local collide, horz, vert = TDF.CheckCollide( v, self )

			if collide and vert then
				self.y = self.y
				self.dy = 0
			end
			if collide and horz then
				self.dx = -self.dx
				self.x = self.x - self.dx*dt
			end
		end
	end

	self.x = self.x + self.dx * dt
	self.y = self.y + self.dy * dt

	self.hitbox.x, self.hitbox.y = self.x, self.y
end

function NPC:draw( )

	love.graphics.setColor( 0,255,255 )
	love.graphics.rectangle( "line", self.x, self.y, self.w, self.h )

end