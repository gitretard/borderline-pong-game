-- Sorry for my fancy texts looking like shit

pl1 = {}
pl2 = {}
ball = {}
function love.load()
	-- Load some stuff
	-- pl1 and pl2 position
	pl1.x, pl1.y, pl2.x, pl2.y = 64, (love.graphics.getHeight() - 64), (1280 - 64), (love.graphics.getHeight() - 64)
	-- Window size
	love.window.setMode(1280, 720, {vsync = -1})
	-- Ball in center of window
	ball.x, ball.y = love.graphics.getWidth() / 2, love.graphics.getHeight() / 2
	-- Math stuff idk
	angle = 0
	speed = 120
	repeatcheck = true
end

function love.update(dt) --Magic deltatime
	-- Player controls
	if love.keyboard.isDown("w") then
		if pl1.y > 0 then
			pl1.y = pl1.y - speed * dt
		end
	elseif love.keyboard.isDown("s") then
		pl1.y = pl1.y + speed * dt
	end
	-- Ball collision
	if CheckCollision(pl1.x, pl1.y, 30, 64, ball.x, ball.y, 15, 15) then
		if angle > 180 then
			angle = angle - math.random(173, 197)
		else
			angle = angle + math.random(171, 200)
		end
	end

-- Floor and ceiling bounce
if (ball.y > love.graphics.getHeight() - 16) or ball.y < 16 then
	if angle > 180 then
		angle = angle - math.random(180, 197)
	else
		angle = angle + math.random(180, 200)
	end
end
-- Idk how this works
ball.x = ball.x + math.cos(angle) * dt * speed
ball.y = ball.y + math.sin(angle) * dt * speed
-- pl2 collision
if CheckCollision(pl2.x, pl2.y, 20, 64, ball.x, ball.y, 15, 15) then
	ball.x = ball.x - 3
	if angle > 180 then
			angle = angle - math.random(173, 197)
		else
			angle = angle + math.random(173, 200)
		end
	end

-- pl2 will move y position after ball
if pl2.y > ball.y - 32 then
	pl2.y = pl2.y - 100 * dt
end
if pl2.y < ball.y - 32 then
	pl2.y = pl2.y + 100 * dt
end
if ball.x > love.graphics.getWidth() - 15 or ball.x < 0 then
	love.graphics.clear(255,255,255)
end
end
-- Also something seems to be wrong with collision so i changed the values when calling CheckCollision()
function love.draw()
	love.graphics.print(ball.y)
	love.graphics.print(angle, 128, 0)
	love.graphics.print(pl2.y, 190, 0)
	love.graphics.rectangle("fill", pl1.x, pl1.y, 20, 64)
	love.graphics.rectangle("fill", pl2.x, pl2.y, 20, 64)
	love.graphics.circle("fill", ball.x, ball.y, 16)
end

function CheckCollision(x1, y1, w1, h1, x2, y2, w2, h2)
	return x1 < x2 + w2 and x2 < x1 + w1 and y1 < y2 + h2 and y2 < y1 + h1
end
