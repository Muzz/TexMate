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

function _M:initialize (Atlas,animlist,defaultanim,x,y,pivotx,pivoty,rot,flip,scale)

  if flip == true then flip = -1 elseif flip == false then flip = 1 end

	self.Atlas = Atlas
	self.animlist = animlist
	self.activeAnim = defaultanim
	self.offset = {}
	self.offset.x = pivotx or 0
	self.offset.y = pivoty or 0
	self.batch = love.graphics.newSpriteBatch( Atlas.texture, 100, "stream" )
	self.iterator = 1
	self.active = true
	self.x = x or 100
	self.y = y or 100
	self.rot = rot or 0
	self.scale = {}
	self.scale.x = scale or 1
	self.scale.y = scale or 1
  self.flip = flip or 1
  self.endCallback = {}

  if flip then
    self.scale.x = self.scale.x *-1
  end

end

function _M:frameCounter(name,rangefrom,rangeto,padding,extension)

  local count = rangeto - rangefrom
  names = {}
  pad = padding or 4

  for i=1,count+1 do
    local string = string.format("%0"..pad.."i", i-1+rangefrom)

    if extension then string = string .. extension end
    names[i] = name .. string
  end
  print("output",unpack(names))
  return unpack(names)
end



function _M:pause ()
	self.active = false
end

function _M:play ()
	self.active = true
end

--dir is a flip value, if is > 0 no flip, else is flipped
function _M:changeAnim (anim,dir)
  self.active = true

  if self.activeAnim ~= anim then
   self.iterator = 1
  end

  dir = dir or 1
	self.activeAnim = anim

  if dir < 0 then
    self.flip = -1
  else
    self.flip = 1
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

function  _M:Destroy ()
	print("destroying animation")
end


function _M:update (dt)

  if self.docallback then
    self.endCallback[self.activeAnim]()
    self.docallback = nil
  end

	--Active is whether we want the sprite to animate or not. We increment an iterator using delta time to keep things frame rate independent
	if self.active == true then

		self.iterator = self.iterator + (self.animlist[self.activeAnim].framerate * dt)

		if self.iterator > #self.animlist[self.activeAnim].frames then
			self.iterator = 1

      if self.endCallback[self.activeAnim] ~= nil then self.docallback = true end

		end
		if self.iterator < 1 then
			self.iterator = 1
		end

	end



end

function _M:draw ()



	--Reset graphics colour back to white
	love.graphics.setColor(255,255,255,255)


	--Binds the SpriteBatch to memory for more efficient updating.
	self.batch:clear()
	self.batch:bind()

    assert(self.Atlas.size[self.animlist[self.activeAnim].frames[round(self.iterator)]],"frame "..self.animlist[self.activeAnim].frames[round(self.iterator)].." Doesn't exist")

		--find the center of the sprite.
		local tempWidth = self.Atlas.size[self.animlist[self.activeAnim].frames[round(self.iterator)]].width/2
		local tempHeight = self.Atlas.size[self.animlist[self.activeAnim].frames[round(self.iterator)]].height/2
		local atlas = self.Atlas.quads[self.animlist[self.activeAnim].frames[round(self.iterator)]]
		local extra = self.Atlas.extra[self.animlist[self.activeAnim].frames[round(self.iterator)]]

		--id = SpriteBatch:add( quad, x, y, r, sx, sy, ox, oy, kx, ky )
		--r is in radians

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
