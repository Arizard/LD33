Ghost = TDF.Class{
    init = function( self, x, y, w, h)
        self.type = "Ghost"
        self.x, self.y = x, y
        self.w, self.h = 54, 66

        self.dx, self.dy = 0, 0
        self.ddx, self.ddy = 0, 0

        self.hitbox = {}
        self.hitbox.x, self.hitbox.y, self.hitbox.w, self.hitbox.h = x, y, w, h

        self.possessing = false
        self.possesstarget = nil

        --animation
        self.image = love.graphics.newImage('assets/spritesheets/ghost.png')
        local g = anim8.newGrid(self.w, self.h, self.image:getWidth(), self.image:getHeight())
        self.animation = anim8.newAnimation(g('1-8',1), 0.03)

        self.particles = {}
        self.particleTimer = 0

        --load audio
        dir = "assets/sounds/"
        self.audio = {}
        self.audio.whoosh = love.audio.newSource(dir .. "whoosh.mp3", "static")
        self.audio.whoosh:play()
        self.audio.whoosh:setVolume(0.1)
        self.audio.whoosh:setLooping(true)
    end
}

function Ghost:SetCollisionTable( tbl )
    self.solids = tbl
end

function Ghost:draw()
    love.graphics.setColor( 255,255,255 )


    if self.possessing then
        love.graphics.setColor( 0,0,0 )

        local tx, ty = self.possesstarget.x + self.possesstarget.w/2, self.possesstarget.y + self.possesstarget.h/2
        local x, y = self.x + self.w/2, self.y + self.h/2

        for i = 1, 50 do
            local frac = InverseLerp( i, 1, 50 )
            local xp = QuadLerp( frac, x, tx )
            local yp = QuadLerp( math.pow(frac,0.7), y, ty )

            love.graphics.rectangle( "line", xp-2, yp-2, 4, 4)
        end

    end

    --love.graphics.rectangle( "line", self.x, self.y, self.w, self.h )
    self.animation:draw(self.image, self.x, self.y, ( self.dx/10 ) * math.pi/180)

    --love.graphics.rectangle( "fill", self.x, self.y, 1, 1 )
    --love.graphics.print( tostring( math.floor( self.x ) ).." "..tostring( math.floor( self.y ) ), self.x, self.y )
end

function Ghost:NewBubble()
    
end

function Ghost:update(dt)

    self.dx = self.dx + self.ddx * dt
    self.dy = self.dy + self.ddy * dt
    local acc = 800
    local maxspeed = 400

    --controls
    if love.keyboard.isDown("right", "d") then
        self.ddx = acc
    end
    if love.keyboard.isDown("left", "a") then
        self.ddx = -acc
    end
    if not love.keyboard.isDown("left", "a") and not love.keyboard.isDown("right", "d") then
        self.ddx = 0
    end
    if love.keyboard.isDown("up", "w") then
        self.ddy = -acc
    end
    if love.keyboard.isDown("down", "s") then
        self.ddy = acc
    end
    if not love.keyboard.isDown("up", "w") and not love.keyboard.isDown("down", "s") then
        self.ddy = 0
    end

    self.dx = math.clamp( self.dx, -maxspeed, maxspeed )
    self.dy = math.clamp( self.dy, -maxspeed, maxspeed )

    -- slow down
    if self.ddx == 0 then
        self.dx = self.dx - (self.dx*0.999*dt*4)
    end
    if self.ddy == 0 then
        self.dy = self.dy - (self.dy*0.999*dt*4)
    end
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
    local cx, cy = TDF.Cam:pos()
    local mx, my = (self.x + 26 - cx)*dt*2, (self.y + 32 - cy)*dt*2 
    self.hitbox.x, self.hitbox.y = self.x, self.y
    
    --posessing
    if self.possessing then
        local dist = math.sqrt( math.pow( self.x + 26 - self.possesstarget.x + self.possesstarget.w/2, 2) + math.pow( self.y + 32 - self.possesstarget.y + self.possesstarget.h/2, 2) ) 

        if dist > 400 then
            local frac = math.clamp( InverseLerp( dist, 400, 500 ), 0, 1 )

            local ang = math.atan2( self.possesstarget.y + self.possesstarget.h/2 - self.y + 32, self.possesstarget.x + self.possesstarget.w/2 - self.x + 26 ) * 180/math.pi

            print( ang )

            self.dx = self.dx - math.cos( ang ) * frac * 12000 * dt
            self.dy = self.dy - math.sin( ang ) * frac * 12000 * dt
        end
    end
    
    --animation and camera
    TDF.Cam:move( math.pow( mx, 1 ), math.pow( my, 1 ) )
    self.animation:update(dt)
        
    --particles
    self.particleTimer = self.particleTimer + dt
    if self.particleTimer > 1 then
        self.particleTimer = 0
        self:NewBubble()
    end

    --audio
    --calculate volume of whoosh noise based on the speed ghost is traveling
    local whooshVolume = (math.abs(self.dx) + math.abs(self.dy)) / 800
    print(whooshVolume)
    self.audio.whoosh:setVolume(whooshVolume)
end

function Ghost:keypressed( key, isRepeat )
    if key == " " then
        if self.possessing == false then
            local foundcollider = false
            local target = nil
            for k,v in ipairs( self.solids ) do
                if v.type == "Mob" then
                    if TDF.CheckCollide( v, self ) then
                        foundcollider = true
                        target = v
                    end
                end
            end

            if target then
                target:Possess( self )
                self.possesstarget = target
                self.possessing = true
            end

        elseif self.possessing then
            self.possesstarget:UnPossess()
            self.possessing = false
            self.possesstarget = nil
        end

    end
end


