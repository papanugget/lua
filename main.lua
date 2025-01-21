function love.load()
    anim8 = require 'libraries.anim8'
    love.graphics.setDefaultFilter('nearest', 'nearest')

    player = {}
    local animSpeed = 0.2
    player.x = 400
    player.y = 200
    player.speed = 5
    player.sprite = love.graphics.newImage('assets/sprites/parrot.png')
    player.spriteSheet = love.graphics.newImage('assets/sprites/player-sheet.png')
    player.grid = anim8.newGrid( 12, 18, player.spriteSheet:getWidth(), player.spriteSheet:getHeight() )

    player.animations = {}
    player.animations.down = anim8.newAnimation( player.grid('1-4', 1), animSpeed )
    player.animations.left = anim8.newAnimation( player.grid('1-4', 2), animSpeed )
    player.animations.right = anim8.newAnimation( player.grid('1-4', 3), animSpeed )   
    player.animations.up = anim8.newAnimation( player.grid('1-4', 4), animSpeed )

    player.anim = player.animations.left
    
    background = love.graphics.newImage('assets/sprites/background.png')
end

function love.update(dt)
    local isMoving = false

    if love.keyboard.isDown("right") then
        player.x = player.x + player.speed
        player.anim = player.animations.right
        isMoving = true
    end

    if love.keyboard.isDown("left") then
        player.x = player.x - player.speed
        player.anim = player.animations.left
        isMoving = true
    end

    if love.keyboard.isDown("down") then
        player.y = player.y + player.speed
        player.anim = player.animations.down
        isMoving = true
    end

    if love.keyboard.isDown("up") then
        player.y = player.y - player.speed
        player.anim = player.animations.up
        isMoving = true
    end
    
    if isMoving == false then
        player.anim:gotoFrame(2)
    end
    --player.animations.down:update(dt)
    --player.animations.left:update(dt)
    --player.animations.right:update(dt)
    --player.animations.up:update(dt)
    player.anim:update(dt)
end

function love.draw()
    -- love.graphics.circle("fill", player.x, player.y, 100)
    love.graphics.draw(background, 0, 0)
    --love.graphics.draw(player.sprite, player.x, player.y)
    --player.animations.down:draw(player.spriteSheet, player.x, player.y, nil, 10)
    player.anim:draw(player.spriteSheet, player.x, player.y, nil, 10)
end