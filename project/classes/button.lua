Button = TDF.Class{
	init = function( self, x, y, w, h )
		self.type = "Button"
		self.x, self.y = x, y
		self.w, self.h = w, h
		self.state = 0 -- 0 for open, 1 for hover, 2 for down,
		self.down = false
		self.text = "Button"
		self.font = TDF.Fonts.MainMedium

        self.images = {}
        dir = "assets/images/menu/"
        --set these to images to draw an image instead of primitives + text
        self.images.hover = nil
        self.images.default = nil
	end
}

function Button:draw()
	love.graphics.setFont( self.font )

	if self.state == 0 then
		self:DrawOpen( self.x, self.y, self.w, self.h )
	elseif self.state == 1 then
	    self:DrawHover( self.x, self.y, self.w, self.h )
	elseif self.state == 2 then
	    self:DrawDown( self.x, self.y, self.w, self.h )
	end

end

function Button:DrawOpen(x,y,w,h)
    if self.images.default == nil then
        love.graphics.setColor( 155,125,125, 255 )
        love.graphics.rectangle( "line", x, y, w, h )
        self:DrawText( self.x, self.y, self.w, self.h )
    else
        love.graphics.draw(self.images.default, x, y)
    end
end
function Button:DrawHover(x,y,w,h)
    if self.images.default == nil then
        love.graphics.setColor( 255,175,175, 255 )
        love.graphics.rectangle( "line", x, y, w, h )
    else
        love.graphics.draw(self.images.hover, x, y)
    end
end
function Button:DrawDown(x,y,w,h)
    if self.images.default == nil then
        love.graphics.setColor( 255,175,175, 255 )
        love.graphics.rectangle( "fill", x, y, w, h )
    else
        love.graphics.draw(self.images.hover, x, y)
    end
end

function Button:DrawText(x,y,w,h)
	love.graphics.setColor( 255,255,255 )
	love.graphics.print(self.text, x+w/2 - love.graphics.getFont():getWidth( self.text )/2, y + h/2 - love.graphics:getFont():getHeight( self.text )/2 )
end

function Button:SetFont( font )
	self.font = font
end
function Button:SetText( str )
	self.text = str
end

function Button:update()
	local mx, my = love.mouse.getX(), love.mouse.getY()

	if mx > self.x and mx < self.x + self.w and my > self.y and my <  self.y + self.h then
		if self.down == false and love.mouse.isDown( "l" ) == false then
			self.state = 1
		end
		if self.down == false and love.mouse.isDown( "l" ) == true then
			self.down = true
			self.state = 2
			
		end
		if self.down == true and love.mouse.isDown( "l" ) == false then
			self.down = false
			self.state = 0
			self:DoClick() -- called on release
		end
	else
		self.down = false
		self.state = 0
	end



end

function Button:DoClick()
	print("I was clicked!")
end
