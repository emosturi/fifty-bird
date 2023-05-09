--[[
    PauseState Class
    Author: Nicolas Albistur
    nicsalb@gmail.com

    The PauseState class is the pause to the playState
]]
PauseState = Class{__includes = BaseState}

--[[
    
]]
function PauseState:enter(params)
    self.score = params.score
    self.bird = params.bird
    self.pipePairs = params.pipePairs
    self.timer = params.timer
end

function PauseState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('p') then
        gStateMachine:change('play', {
            score = self.score,
            bird = self.bird,
            pipePairs = self.pipePairs,
            timer = self.timer
        })
    end
end

function PauseState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('You paused the game!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    love.graphics.printf('Press P to continue Playing!', 0, 160, VIRTUAL_WIDTH, 'center')
end