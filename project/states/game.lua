TDF.States.Game = {}

local state = TDF.States.Game

state.Entities = {}

function state:init()
    TDF.AddClassToGameState( self, Ghost( 100, 100, 20, 20 ) )
end

function state:draw( )
    TDF.DrawGameStateEntities( self )
end

function state:update( dt )
	TDF.UpdateGameStateEntities( self, dt )
end
