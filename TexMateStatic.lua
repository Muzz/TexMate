local class = require('middleclass')

local _M = class("texmate")
--pass in the atlas, and it will make a deck, and preseve offset data.
--framerate, works as a global number

function round(num, idp)

  if idp and idp>0 then
    local mult = 10^idp
    return math.floor(num * mult + 0.5) / mult
  end

  return math.floor(num + 0.5)

end

function _M:initialize (Atlas,imageid,x,y,pivotx,pivoty,rot,flip,scalex,scaley,offsetstyle,ignoretrim)
  self.ignoretrim = ignoretrim or false
  self.offsetStyle = offsetstyle or "topleft"
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
	self.scale.x = scalex or 1
	self.scale.y = scaley or scalex or 1
  self.flip = -1
  self.endCallback = {}

  if flip then
    self.scale.x = self.scale.x *-1
  end

  --ofs is the number that it uses to work out the offset.
  if self.offsetStyle == "center" then
      self.ofs = 0.5
  else
      self.ofs = 1
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
		local tempWidth = self.Atlas.size[self.image].width*self.ofs
		local tempHeight = self.Atlas.size[self.image].height*self.ofs
		local atlas = self.Atlas.quads[self.image]
		local extra = self.Atlas.extra[self.image]

    if ignoretrim then
        extra[1] = 0
        extra[2] = 0
    end

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
