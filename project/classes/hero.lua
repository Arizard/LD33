Hero = TDF.Class{ __includes = {ENTITY} }

function Hero:Initialize()

	self.type = "Hero"

	self.dx = 100
	self.grounded = false

	--animation
	self.image = love.graphics.newImage('assets/spritesheets/knight.png')
	local g = anim8.newGrid(self.w+40, self.h+20, self.image:getWidth(), self.image:getHeight())
	self.animation = anim8.newAnimation(g('1-7','1-2','1-5','3-3'), 0.03)
end

function Hero:IsOnGround()
	return self.grounded
end

function Hero:draw()
	self.animation:draw( self.image, self.x-20, self.y-20 )
end

function Hero:OnCollide( ent1, vert, horz )
	self.grounded = false
	if vert then
		self.grounded = true
	end
	if horz then
		self:Jump()
		self.dx = -10
	end
end

function Hero:Jump()
	if self:IsOnGround() then
		--print("grounded and jumping")
		self.dy = -200
		self.grounded = false
	end
end

function Hero:Update2( dt )

	--self:Jump()

	self.animation:update( dt * ( math.abs(self.dx) / 100 ) )

	self.ddx = 70

	if self:IsOnGround() == false then self.ddx = 0 end

	self.dx = math.clamp( self.dx, -1000, 70 )

	--
end