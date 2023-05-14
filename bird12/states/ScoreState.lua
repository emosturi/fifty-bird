--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
    self.timeStamp = os.date("%X %x")
    self.ranking = params.ranking 
    if self.score > 3 then
        table.insert(self.ranking, {self.score, self.timeStamp})
    end
        table.sort(self.ranking, function(a, b) return a[1] > b[1] end)
    if #self.ranking > 3 then
        local newRanking = {}
        for i = 1, 3 do
            newRanking[i] = self.ranking[i]
        end
        self.ranking = newRanking
    end
end

function ScoreState:init()
    self.gold = love.graphics.newImage('gold.png')
    self.silver = love.graphics.newImage('silver.png')
    self.bronce = love.graphics.newImage('bronce.png')
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown', {
            ranking = self.ranking
        })
    end
end

function ScoreState:render()
    local height = 100
    local medal = {'gold', 'silver', 'bronce'}
    local podium = 0
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oops! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)   
    for k, v in pairs(self.ranking) do
        love.graphics.printf('Record: '..v[1]..' points  -  '..v[2] , 0, height, VIRTUAL_WIDTH, 'center')
        height = height + 20
        if(v[1]==self.score) then
            podium = k
        end
    end
    if podium ~= 0 then
        love.graphics.printf('You got '..medal[podium]..' medal!', 0, 180, VIRTUAL_WIDTH, 'center')
        if podium == 1 then
            love.graphics.draw(self.gold, VIRTUAL_WIDTH / 2 -15, VIRTUAL_HEIGHT -80 )
        elseif podium == 2 then
            love.graphics.draw(self.silver, VIRTUAL_WIDTH / 2 -15, VIRTUAL_HEIGHT -80 )
        elseif podium == 3 then
            love.graphics.draw(self.bronce, VIRTUAL_WIDTH / 2 -15, VIRTUAL_HEIGHT -80 )
        end
    end
    love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')
end