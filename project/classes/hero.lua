Hero = TDF.Class{ __includes = {ENTITY} }

function Hero:Initialize()
	self.dx = 100
	self.grounded = false

	--animation
	self.image = love.graphics.newImage('assets/spritesheets/knight.png')
	local g = anim8.newGrid(self.w, self.h, self.image:getWidth(), self.image:getHeight())
	self.animation = anim8.newAnimation(g('1-7','1-2','1-5','3-3'), 0.03)
end

function Hero:IsOnGround()
	return self.grounded
end

function Hero:draw()
	self.animation:draw( self.image, self.x, self.y )
end

function Hero:OnCollide( ent1, vert, horz )
	if horz then
		self.dx = -10
		self.dy = -100
	end

	if vert then
		self.grounded = true
	end
end


function Hero:Update2( dt )

	self.animation:update( dt * ( math.abs(self.dx) / 100 ) )

	self.ddx = 100

	if self:IsOnGround() == false then self.ddx = 0 end

	self.dx = math.clamp( self.dx, -1000, 100 )

	self.grounded = false
end