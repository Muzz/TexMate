# TexMate

[Texture Packer](https://www.codeandweb.com/texturepacker) importer and animation helper library for LÖVE.

Atlas importer is designed to use the corona exporter from texture packer. It keeps all animations related to a player sprite handy.

Texture packer automatically combines unique frames but keeps references, and preserves offset data after automatic trimming.

## Usage

```lua
local AtlasImporter = require("AtlasImporter")
local TexMate = require("TexMate")

-- Load atlas you want to use
local myAtlas = AtlasImporter.loadAtlas("ASSETS.Atlas", "ASSETS.Atlas.png")

local animlist = {
  Death = {
    "Dieing001",
    "Dieing002",
    "Dieing003"
  }
  Run = {
    "Running001",
    "Running002",
    "Running003"
  }
}

--make the sprite , args: Atlas,animlist,defaultanim,x,y,pivotx,pivoty,rot
--Pivot x and y is an offset from the center of the image.

self.sprite = TexMate(myAtlas,animlist,"Death",nil,nil,0,-30)

self.sprite:changeAnim("Run")
```

## Credits

_Written by Murry Lancashire_
