-- justify.lua
--
-- The MIT License (MIT)

-- Copyright (c) 2014 Ingemar Bergmark, Swipeware

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.

local justifyFull = function(options)
    assert(options.text, "No text specified.")
    options.maxWidth  = options.maxWidth or display.contentWidth
    options.font      = options.font or native.systemFont
    options.fontSize  = options.fontSize or 12
    options.fillColor = options.fillColor or {1}

    local words = {}

    -- divide string into words
    for word in options.text:gmatch("[^%s]+") do 
        words[#words + 1] = word
    end

    -- set up intermediary text object
    local tmp = display.newText {
        text     = " ",
        font     = options.font,
        fontSize = options.fontSize
    }

    -- create individual text objects for each word
    local output = {}
    local lineCount = 0
    local lineLength = 99999999 
    local spaceWidth = tmp.width

    for i = 1, #words do
        tmp.text = words[i]
        
        if (lineLength + tmp.width > options.maxWidth) then
            if (lineCount > 0) then
                output[lineCount].full = true
            end

            lineLength = 0
            lineCount = lineCount + 1
            output[lineCount] = {}
            output[lineCount].words = {}
            output[lineCount].length = 0
            output[lineCount].full = false
        end

        local index = #output[lineCount].words + 1

        output[lineCount].words[index] = display.newText {
            text     = words[i],
            font     = options.font,
            fontSize = options.fontSize   
        }

        output[lineCount].words[index]:setFillColor(unpack(options.fillColor))
        output[lineCount].words[index].anchorX = ((options.rtl == true) and 1 or 0)
        output[lineCount].length = output[lineCount].length + tmp.width

        lineLength = lineLength + tmp.width + spaceWidth 
    end

    tmp:removeSelf()

    -- create lineGroup with justified text
    local lineGroup = display.newGroup()
    local lineHeight = output[1].words[1].height        -- get height from first word
    local newY = lineHeight / 2                         -- adjust text downwards

    for lineNumber, line in pairs(output) do
        local index = #lineGroup + 1    
        local newX = (options.rtl == true) and options.maxWidth or 0
        local lineSpaceWidth = spaceWidth

        if (line.full) then
            lineSpaceWidth = (options.maxWidth - line.length) / (#line.words - 1)
        end

        for wordNumber, word in pairs(line.words) do
            lineGroup:insert(word)
            word.x = newX
            word.y = newY
            newX = newX + (word.width + lineSpaceWidth) * ((options.rtl == true) and -1 or 1)
        end

        newY = newY + lineHeight
    end

    return lineGroup
end


local public = {}

public.justifyFull = justifyFull

return public
