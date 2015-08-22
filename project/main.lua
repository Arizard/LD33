-- Ludum Dare 33
-- Redacted Studios
-- Arizard, TheQuinn, Rukai

TDF = {}

function love.load()
	TDF.Version = "Dank Version"
	TDF.Authors = { "Arizard", "Rukai", "TheQuinn" }
	TDF.dt = 0
end

function love.keypressed( key, isrepeat )
end

function love.draw( )


	
	-- debug things, these should go at the END.
	local debugprints = {
		"Framerate : "..tostring( love.timer.getFPS() ),
		"Tickrate : "..tostring( math.ceil(1/TDF.dt) )
	}
	
	for i = 1, #debugprints do
		love.graphics.print( debugprints[i], 0, 12*(i-1) )
	end

end

function love.update( dt )
	TDF.dt = dt
end