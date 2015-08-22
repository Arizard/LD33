TDF.States.Menu = {}

local state = TDF.States.Menu
state.Entities = {}

function state:init()
	local newButton = Button( 64, 64, 96, 32 )

	function newButton:DoClick()
		TDF.GameState.switch( TDF.States.Menu2 )
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
	love.graphics.print("Menu State", 32, 32)
	TDF.DrawGameStateEntities( self )
end
