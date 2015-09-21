# TexMate
Texture packer importer and animation library. 

Written by Murry Lancashire

Atlas importer is designed to use the corona exporter from texture packer. 
It keeps all animations related to a player sprite handy. 

Texture packer automatically combines unique frames but keeps references, and preserves offset data after automatic trimming. 

USAGE:

	AtlasImporter = require("AtlasImporter")
	TexMate = require("TexMate")

	--Load atlas you want to use 
	myAtlas = AtlasImporter.loadAtlas("ASSETS.Atlas",ASSETS.Atlas.png")


	animlist = {}
	animlist["Death"] = {
		framerate = 14,
		frames = {
				"Death001",
				"Death002",
				"Death003",
				"Death004",
				"Death005",
				"Death006",
				"Death007",
				"Death008",
				"Death009"
			}
	}

	animlist["Run"] = {
		framerate = 14, 
		frames = {
				"fastZomb001",
				"fastZomb002",
				"fastZomb003",
				"fastZomb004",
				"fastZomb005",
				"fastZomb006",
				"fastZomb007",
				"fastZomb008",
				"fastZomb009"
			}
	}

	--make the sprite , args: Atlas,animlist,defaultanim,x,y,pivotx,pivoty,rot
	--Pivot x and y is an offset from the center of the image. 

	self.sprite = TexMate(myAtlas,animlist,"Death",nil,nil,0,-30)

	self.sprite:changeAnim("Run")