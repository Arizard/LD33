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

    self.possessed = false
    self.possessedTimer = 1000000
    self.possessor = nil

    self.walkspeed = 45

    self.grounded = false

end
function Mob:draw()
    love.graphics.setColor( self.possessed and 0 or 255,255,255 )
    

    if self.possessed and self.possessedTimer < 3 then
        self.animation:draw(self.image, self.x-10, self.y-20, math.random(-5,5) * math.pi/180 )
    else
        self.animation:draw(self.image, self.x-10, self.y-20 )
    end

    --love.graphics.rectangle( "fill", self.hitbox.x, self.hitbox.y, self.hitbox.w, self.hitbox.h )
    --love.graphics.print( tostring( math.floor( self.x ) ).." "..tostring( math.floor( self.y ) ), self.x, self.y )
end

function Mob:IsOnGround()
    return self.grounded
end

function Mob:Jump()
    if self:IsOnGround() then
        --print("grounded and jumping")
        self.dy = -100
        --print( self.dx, self.dy )
        self.grounded = false
    end
end


function Mob:Update2(dt)
    self.animation:update(dt)

    if self.possessed then
        self.possessedTimer = self.possessedTimer - dt

        if self.possessor then
            if self.possessor.x < self.x then
                self.dx = -self.walkspeed
            else
                self.dx = self.walkspeed
            end
        end

        if self.possessedTimer < 0 and self.possessor then
            self.possessor.possessing = false
            self.possessor.possesstarget = nil
            self:UnPossess()
        end
    end

    

end

function Mob:OnCollide( ent, vert, horz )

    if vert then
        self.grounded = true
    end

    if horz then
        self.dx = -self.lastdx
        self.x = self.x + self.dx * (1/60)

        --print( self.dx )
    end
end

function Mob:Possess( ent )
    self.possessed = true
    self.possessor = ent
end

function Mob:UnPossess( ent )
    self.possessed = false
    self.possessor = nil
    self:Jump()
end