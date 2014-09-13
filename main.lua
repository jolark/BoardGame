function love.load()
	-- global declarations
	math.randomseed(os.time())
	love.mouse.setVisible(false)
	
	-- global params
	tilePixelSize = 50
	boardXSize = 15
	boardYSize = 9

	-- load all modules
	require "player"
	require "board"
	require "mouse"
	require "utils"

	-- objects initialization
	mouse = Mouse:new()

    player = Player:new()
    player:addRanger()
    player:addShield()
    player:addRogue()

    board = Board:new()
    board:initialize()
    -- board:generateEndPosition()
    board:generate_enemies(2)

    player:go_to_start_position(board)

    imageDice = love.graphics.newImage('img/game/dice.png')
    imageBgChar = love.graphics.newImage('img/game/blank.png')
end

function love.update(dt)
	-- stimeUpdate = os.clock()
	player:update(dt,mouse)
	board:update(player)
	mouse:update(player)
	-- etimeUpdate = os.clock()
end

function love.draw()
	-- stimeDraw = os.clock()
	board:draw(player, mouse)
	player:draw()
	-- board:drawDecoration(player)

	if player.dice > 0 then
		for i=1,player.dice do
			love.graphics.draw(imageDice, i*70+300, 520)
		end
	end
	mouse:draw()
	-- etimeDraw = os.clock()

	love.graphics.draw(imageBgChar, 0, 500, 0, 2)
	love.graphics.draw(player.characters[player.currentChar].image, 0, 500, 0, 2)

    -- INFO

    -- love.graphics.print(tostring("update time: "..(etimeUpdate - stimeUpdate)/100000), 200, 510)
    -- love.graphics.print(tostring("draw time: "..(etimeDraw - stimeDraw)/100000), 200, 520)
    love.graphics.print(tostring("mouseOverTile: "..mouse.mouseOverTile[1]..","..mouse.mouseOverTile[2]), 200, 510)
    -- love.graphics.print(tostring("mouseOverTile value : "..mouseOverTileValue), 200, 520)
    love.graphics.print(tostring("player: "..player.characters[player.currentChar].x..","..player.characters[player.currentChar].y), 200, 520)
    love.graphics.print(tostring("player currentChar: "..player.currentChar), 200, 530)
    -- love.graphics.print(tostring("villain: "..tostring(board.villainPositions[1][1])..","..tostring(board.villainPositions[1][2])), 200, 560)
    love.graphics.print(tostring("distance: "..tostring(tile_distance({player.characters[player.currentChar].x,player.characters[player.currentChar].y},mouse.mouseOverTile))), 200, 560)
    love.graphics.print(tostring("mouseOverIsInRange: "..tostring(mouse.mouseOverIsInRange)), 200, 540)

end



function restart()
    board:initialize()
    board:generateEndPosition()
    player:go_to_start_position(board)
end