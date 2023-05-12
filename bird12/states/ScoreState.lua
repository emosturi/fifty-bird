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
    print(self.ranking)
    table.insert(self.ranking, self.score.." points  -  "..self.timeStamp)
    table.sort(self.ranking, function(a, b) return a > b end)
    if #self.ranking > 3 then
        local newRanking = {}
        for i = 1, 3 do
            newRanking[i] = self.ranking[i]
        end
        self.ranking = newRanking
    end
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
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oops! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    local height = 100
    for k, v in pairs(self.ranking) do
        love.graphics.printf('Record: '..self.ranking[k] , 0, height, VIRTUAL_WIDTH, 'center')
        height = height + 20
    end

    love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')
end