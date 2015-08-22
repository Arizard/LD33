Ghost = TDF.Class{
    init = function( self, x, y)
        self.x, self.y = x, y
        self.w, self.h = 54, 66

        --velocity
        self.vx, self.vy = 0, 0

        --animation
        self.image = love.graphics.newImage('assets/spritesheets/ghost.png')
        local g = anim8.newGrid(self.w, self.h, self.image:getWidth(), self.image:getHeight())
        self.animation = anim8.newAnimation(g('1-8',1), 0.03)
    end
}
function Ghost:draw()
    --love.graphics.rectangle( "line", self.x, self.y, self.w, self.h )
    self.animation:draw(self.image, self.x, self.y)
end

function Ghost:update(dt)
    self.animation:update(dt)

    --slow down
    --Yo arie! These are hardcoded for my dt can you generalise the next two lines to work for all dt?
    self.vx = self.vx / 1.01
    self.vy = self.vy / 1.01

    --accellerate
    if love.keyboard.isDown("right", "d") then
        self.vx = 120
    end
    if love.keyboard.isDown("left", "a") then
        self.vx = -120
    end
    if love.keyboard.isDown("up", "w") then
        self.vy = -120
    end
    if love.keyboard.isDown("down", "s") then
        self.vy = 120
    end

    --move
    self.x = self.x + dt * self.vx
    self.y = self.y + dt * self.vy
end
