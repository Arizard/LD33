Minotaur = TDF.Class{__includes = {Mob}}

function Minotaur:Initialize()
    self.type = "Minotaur"
    self.action = "run"
    self.w, self.h = 115, 124
    self.hitbox.w, self.hitbox.h = self.w, self.h -- these values are going to be messed up
    self.idleW, self.idleH = 115, 124
    self.runW, self.runH = 138, 106 --146, 109

    --animation idle
    self.imageIdle = love.graphics.newImage('assets/spritesheets/minotaurIdle.png')
    local gIdle = anim8.newGrid(self.idleW, self.idleH, self.imageIdle:getWidth(), self.imageIdle:getHeight())
    self.animationIdle = anim8.newAnimation(gIdle('1-8', '1-2', '1-3', 3), 0.03)

    --animation run
    self.imageRun = love.graphics.newImage('assets/spritesheets/minotaurRun.png')
    local gRun = anim8.newGrid(self.runW, self.runH, self.imageRun:getWidth(), self.imageRun:getHeight())
    self.animationRun = anim8.newAnimation(gRun('1-7', 1, '1-5', 2), 0.03)
    
end

function Minotaur:draw()
    love.graphics.setColor(255, 255, 255)
    if self.action == "idle" then
        self.animationIdle:draw(self.imageIdle, self.x, self.y)
    elseif self.action == "run" then
        self.animationRun:draw(self.imageRun, self.x, self.y)
    end
end

function Minotaur:Update2(dt)

    --delete below before commit
    self.x = 200
    self.y = 200
    --delete above before commit
    --
    if self.action == "idle" then
        self.animationIdle:update(dt)
    elseif self.action == "run" then
        self.animationRun:update(dt)
    end
end
