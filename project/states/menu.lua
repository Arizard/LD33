TDF.States.Menu = {}

local state = TDF.States.Menu
state.Entities = {}

function state:init()
	local newButton = Button( 512 - 128, 576 * (2/3) - 96/2, 256, 96 )

	newButton:SetText( "PLAY" )
	newButton:SetFont( TDF.Fonts.MainLarge )

	function newButton:DoClick()
		TDF.GameState.switch( TDF.States.Level01 )
	end

	TDF.AddClassToGameState( self, newButton )
    

    local dir = "assets/images/menu/"
    self.images = {} -- store all images for the menu in here

    --load static images
    self.images.background = love.graphics.newImage( dir .. "background.png" )
    self.images.knight = love.graphics.newImage( dir .. "bigStaticKnight.png" )
    self.images.title = love.graphics.newImage( dir .. "titleText.png" )

    --load animations
    self.images.ghostSpritesheet = love.graphics.newImage( dir .. "bigGhostSpritesheet.png" )
    local g = anim8.newGrid(199, 248, self.images.ghostSpritesheet:getWidth(), self.images.ghostSpritesheet:getHeight())
    self.ghostAnimation = anim8.newAnimation(g('1-10', '1-3', '1-8', 4), 0.06)
end

function state:enter()
	
end

function state:leave()

end

function state:update( dt )
	TDF.UpdateGameStateEntities( self, dt )
    self.ghostAnimation:update(dt)
end

function state:draw( )
    love.graphics.setColor(255, 255, 255);
    love.graphics.draw( self.images.background, 0, 0)
	love.graphics.draw( self.images.title, love.graphics.getWidth()/2 - self.images.title:getWidth()/2 , 64 )
	love.graphics.draw( self.images.knight, 0, 155 + 5*math.sin( TDF.Ticker/2 ) )
    self.ghostAnimation:draw(self.images.ghostSpritesheet, 1024 - 250, 240 + 20*math.sin( TDF.Ticker ) )

	TDF.DrawGameStateEntities( self )
end
