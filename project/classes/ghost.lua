Ghost = TDF.Class{
    init = function( self, x, y)
        self.type = "Ghost"
        self.x, self.y = x, y
        self.w, self.h = 54, 66

        self.dx, self.dy = 0, 0
        self.ddx, self.ddy = 0, 0

        --animation
        self.image = love.graphics.newImage('assets/spritesheets/ghost.png')
        local g = anim8.newGrid(self.w, self.h, self.image:getWidth(), self.image:getHeight())
        self.animation = anim8.newAnimation(g('1-8',1), 0.03)
    end
}
function Ghost:draw()
    love.graphics.setColor( 255,255,255 )
    --love.graphics.rectangle( "line", self.x, self.y, self.w, self.h )
    self.animation:draw(self.image, self.x, self.y, ( self.dx/10 ) * math.pi/180)

    love.graphics.rectangle( "fill", self.x, self.y, 1, 1 )
    love.graphics.print( tostring( math.floor( self.x ) ).." "..tostring( math.floor( self.y ) ), self.x, self.y )
end

function Ghost:update(dt)
    self.animation:update(dt)

    self.dx = self.dx + self.ddx * dt
    self.dy = self.dy + self.ddy * dt

    local acc = 100
    local maxspeed = 400

    if love.keyboard.isDown("right", "d") then
        self.ddx = acc
    end
    if love.keyboard.isDown("left", "a") then
        self.ddx = -acc
    end
    if not love.keyboard.isDown("left", "a") and not love.keyboard.isDown("left", "d") then
        self.ddx = 0
    end
    if love.keyboard.isDown("up", "w") then
        self.ddy = -acc
    end
    if love.keyboard.isDown("down", "s") then
        self.ddy = acc
    end
    if not love.keyboard.isDown("left", "w") and not love.keyboard.isDown("left", "s") then
        self.ddy = 0
    end

    self.dx = math.clamp( self.dx, -maxspeed, maxspeed )
    self.dy = math.clamp( self.dy, -maxspeed, maxspeed )

    -- slow down
    self.dx = self.dx - (self.dx*0.99*dt)
    self.dy = self.dy - (self.dy*0.99*dt)

    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt

    local cx, cy = TDF.Cam:pos()
    local mx, my = (self.x + 26 - cx)*dt*2, (self.y + 32 - cy)*dt*2 
    
    TDF.Cam:move( math.pow( mx, 1 ), math.pow( my, 1 ) )

end


