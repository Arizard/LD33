Mob = TDF.Class{__includes = {ENTITY}}

function Mob:Initialize()
    self.type = "Mob"
    self.w, self.h = 56, 56
    self.hitbox.w, self.hitbox.h = self.w, self.h

    --animation
    self.image = love.graphics.newImage('assets/spritesheets/mob.png')
    local g = anim8.newGrid(self.w, self.h, self.image:getWidth(), self.image:getHeight())
    self.animation = anim8.newAnimation(g('1-9',1, '1-9',2, 1,1), 0.03)

end
function Mob:draw()
    love.graphics.setColor( 255,255,255 )
    self.animation:draw(self.image, self.x, self.y)

    love.graphics.rectangle( "fill", self.x, self.y, 1, 1 )
    love.graphics.print( tostring( math.floor( self.x ) ).." "..tostring( math.floor( self.y ) ), self.x, self.y )
end

function Mob:Update2(dt)
    self.animation:update(dt)
end
