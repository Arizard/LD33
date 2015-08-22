Mob = TDF.Class{__includes = {ENTITY}}

function Mob:Initialize()
    self.type = "Mob"
    --self.w, self.h = 56, 56
    --self.hitbox.w, self.hitbox.h = self.w, self.h

    --animation
    self.image = love.graphics.newImage('assets/spritesheets/mob.png')
    local g = anim8.newGrid(self.w+20, self.h+20, self.image:getWidth(), self.image:getHeight())
    self.animation = anim8.newAnimation(g('1-9',1, '1-9',2, 1,1), 0.03)

    self.ddx = 0

end
function Mob:draw()
    love.graphics.setColor( 255,255,255 )
    self.animation:draw(self.image, self.x-10, self.y-20)

    --love.graphics.rectangle( "fill", self.hitbox.x, self.hitbox.y, self.hitbox.w, self.hitbox.h )
    --love.graphics.print( tostring( math.floor( self.x ) ).." "..tostring( math.floor( self.y ) ), self.x, self.y )
end

function Mob:Update2(dt)
    self.animation:update(dt)
end

function Mob:OnCollide( ent, vert, horz )
    if horz then
        self.dx = -self.lastdx
        self.x = self.x + self.dx * (1/60)

        --print( self.dx )
    end
end
