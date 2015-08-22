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
end

function state:enter()
	
end

function state:leave()

end

function state:update( dt )
	TDF.UpdateGameStateEntities( self, dt )
end

function state:draw( )
	--love.graphics.print("Menu State", 32, 32)
	TDF.DrawGameStateEntities( self )

	love.graphics.draw( TDF.Images.Title_Title, 512-(720/2), 64 )
	love.graphics.draw( TDF.Images.Knight_Title, 0, 5 + 5*math.sin( TDF.Ticker/2 ) )
	love.graphics.draw( TDF.Images.Ghost_Title, 1024 - 250, 128 + 20*math.sin( TDF.Ticker ) )
end
