# TexMate

[Texture Packer](https://www.codeandweb.com/texturepacker) and [ShoeBox](http://renderhjs.net/shoebox/) importer and animation helper library for LÖVE.

Atlas importer is designed to use the corona exporter from texture packer. It keeps all animations related to a player sprite handy.

Texture packer automatically combines unique frames but keeps references, and preserves offset data after automatic trimming.

Texmate requires a specific class library, [middleclass](https://github.com/bartbes/Class-Commons), to be on the `packages.path`. Supporting for [class commons](https://github.com/bartbes/Class-Commons) is planned for a later release.

## Usage

```lua
AtlasImporter = require("AtlasImporter")
TexMate = require("TexMate")

function love.load ()

    --Load atlas you want to use

    --myAtlas = AtlasImporter.loadAtlasShoeBox("ASSETS/sprites","ASSETS/sprites.png")
    myAtlas = AtlasImporter.loadAtlasTexturePacker("ASSETS/spriteTP2","ASSETS/spriteTP.png")

    -- use the exporter marked Corona TM SDK from texture packer.
    -- If using shoebox, use the settings file provided

    animlist = {}
    animlist["Death"] = {
        framerate = 14,
        frames = {
                "Death001",
                "Death002",
                "Death003",

                }
        }

    animlist["Run"] = {
        framerate = 14,
        frames = {
                "Run001",
                "Run002",
                "Run003",

                }
        }

    --make the sprite , arguments: atlas, animlist, defaultanim, x, y, pivotx, pivoty, rotation
    --Pivot x and y is an offset from the center of the image.

    sprite = TexMate(myAtlas,animlist,"Death",nil,nil,0,-30)

    sprite:changeAnim("Run")

end

function love.update(dt)
    sprite:update(dt)
end

function love.draw()
    sprite:draw()
end

```

## Credits

_Written by Murry Lancashire_
