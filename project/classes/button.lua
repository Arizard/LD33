Button = TDF.Class{
	init = function( self, x, y, w, h )
		self.type = "Button"
		self.x, self.y = x, y
		self.w, self.h = w, h
		self.state = 0 -- 0 for open, 1 for hover, 2 for down,
		self.down = false
		self.text = "Button"
		self.font = TDF.Fonts.MainMedium
	end
}

function Button:draw()
	
	--love.graphics.rectangle( "line", self.x, self.y, self.w, self.h )

	--if self.down == true then
		--love.graphics.rectangle( "fill", self.x, self.y, self.w, self.h )
	--end

	--print("meme")
	love.graphics.setFont( self.font )

	if self.state == 0 then
		self:DrawOpen( self.x, self.y, self.w, self.h )
	elseif self.state == 1 then
	    self:DrawHover( self.x, self.y, self.w, self.h )
	elseif self.state == 2 then
	    self:DrawDown( self.x, self.y, self.w, self.h )
	end

	self:DrawOverlay( self.x, self.y, self.w, self.h )
end

function Button:DrawOpen(x,y,w,h)
	love.graphics.setColor( 155,125,125, 255 )
	love.graphics.rectangle( "line", x, y, w, h )
end
function Button:DrawHover(x,y,w,h)
	love.graphics.setColor( 255,175,175, 255 )
	love.graphics.rectangle( "line", x, y, w, h )
end
function Button:DrawDown(x,y,w,h)
	love.graphics.setColor( 255,175,175, 255 )
	love.graphics.rectangle( "fill", x, y, w, h )
end
function Button:DrawDisabled(x,y,w,h)
	self:DrawOpen()
end
function Button:DisabledOverlay(x,y,w,h)
	love.graphics.setColor( 0,0,0,150 )
	love.graphics.rectangle( "fill", x, y, w, h )
end
function Button:DrawOverlay(x,y,w,h)
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
	--print("meme update")
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