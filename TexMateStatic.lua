local _M = CLASS("texmate")
--pass in the atlas, and it will make a deck, and preseve offset data.
--framerate, works as a global number

function round(num, idp)

  if idp and idp>0 then
    local mult = 10^idp
    return math.floor(num * mult + 0.5) / mult
  end

  return math.floor(num + 0.5)

end

function _M:initialize (Atlas,imageid,x,y,pivotx,pivoty,rot,flip,scale)

	self.Atlas = Atlas
	self.image = imageid
	self.offset = {}
	self.offset.x = pivotx or 0
	self.offset.y = pivoty or 0
	self.batch = love.graphics.newSpriteBatch( Atlas.texture, 100, "stream" )
	self.active = true
	self.x = x or 100
	self.y = y or 100
	self.rot = rot or 0
	self.scale = {}
	self.scale.x = scale or 1
	self.scale.y = scale or 1
  self.flip = -1
  self.endCallback = {}

  if flip then
    self.scale.x = self.scale.x *-1
  end

end


function _M:changeLoc (x,y)
	self.x = x or self.x
	self.y = y or self.y
end

function _M:changeRot(angle)
	self.rot = angle
end

function _M:changeRotVec(vec)
  self.rot = math.deg(math.atan2(vec.y,vec.x))+90
end

function _M:getLoc()
	return self.x,self.y
end

function _M:draw ()

	--Reset graphics colour back to white
	love.graphics.setColor(255,255,255,255)

	--Binds the SpriteBatch to memory for more efficient updating.
	self.batch:clear()
	self.batch:bind()

		--find the center of the sprite.
		local tempWidth = self.Atlas.size[self.image].width
		local tempHeight = self.Atlas.size[self.image].height
		local atlas = self.Atlas.quads[self.image]
		local extra = self.Atlas.extra[self.image]

		self.batch:add( atlas,
						self.x, --x
						self.y, --y
						math.rad(self.rot), -- rot
						self.scale.x*self.flip, -- scale x
						self.scale.y, -- scale y
						-extra[1]+tempWidth-self.offset.x, --pivotx, needs to add in the trimming data here.
						-extra[2]+tempHeight-self.offset.y -- pivoty
					)


	self.batch:unbind()

	love.graphics.draw(self.batch)

end

return _M
