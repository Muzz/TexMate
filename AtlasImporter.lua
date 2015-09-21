--[[
Copyright (c) 2015 Murry Lancashire

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

Except as contained in this notice, the name(s) of the above copyright holders
shall not be used in advertising or otherwise to promote the sale, use or
other dealings in this Software without prior written authorization.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
]]--

local _M = {}

function _M.loadAtlasTexturePacker(lua,png)
    local TextureAtlas = {}
    --atlas file is exported from texture packer
    local atlas = require (lua)
    local data = atlas.getSpriteSheetData()

    --frames holds the data that we need to interpret
    local frames = data.frames
    local tex = love.graphics.newImage( png )

    local Quads = {}
    --extra holds the offset data
    local Extra = {}
    local Size = {}

    --make sure offsets and quads are all right
    for i=1,#frames do
        local rect = frames[i].textureRect
        local offset = frames[i].spriteColorRect


        local x = rect.x
        local y = rect.y
        local height = rect.height
        local width = rect.width
        local th = tex:getHeight ()
        local tw = tex:getWidth ()

        Quads[frames[i].name] = love.graphics.newQuad(x, y, width, height, tw,th )

        Extra[frames[i].name] = {offset.x,offset.y}

        Size[frames[i].name] = frames[i].spriteSourceSize

    end

    TextureAtlas.quads = Quads
    TextureAtlas.texture = tex
    TextureAtlas.extra = Extra
    TextureAtlas.size = Size

    return TextureAtlas
end




function _M.loadAtlasShoeBox(lua,png)
    local TextureAtlas = {}
    --atlas file is exported from texture packer
    local data = require (lua)
    --local data = atlas.getSpriteSheetData()


    --frames holds the data that we need to interpret
    local frames = data.sheetData.frames
    local tex = love.graphics.newImage( png )

    local Quads = {}
    --extra holds the offset data
    local Extra = {}
    local Size = {}

    --make sure offsets and quads are all right
    for i=1,#frames do
        local rect = {width = frames[i].width,height = frames[i].height,x = frames[i].x,y = frames[i].y} 
        local offset = {x = frames[i].sourceX,y = frames[i].sourceY}

        local x = rect.x
        local y = rect.y
        local height = rect.height
        local width = rect.width
        local th = tex:getHeight ()
        local tw = tex:getWidth ()

        Quads[frames[i].name] = love.graphics.newQuad(x, y, width, height, tw,th )

        Extra[frames[i].name] = {offset.x,offset.y}

        Size[frames[i].name] = {width = frames[i].sourceWidth,height = frames[i].sourceHeight}

    end

    TextureAtlas.quads = Quads
    TextureAtlas.texture = tex
    TextureAtlas.extra = Extra
    TextureAtlas.size = Size
    TextureAtlas.importer = "shoebox"
    
    return TextureAtlas
end


return _M