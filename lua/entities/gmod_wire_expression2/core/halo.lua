--[[
	Halo Extension
	  by thetree / Optimized by Ninja101
]]

util.AddNetworkString("WireHaloInit")
util.AddNetworkString("WireHaloUpdate")

E2Lib.RegisterExtension("halo", true)

CreateConVar( "wire_max_halo", "15" )

local validEntity  = E2Lib.validEntity
local validPhysics = E2Lib.validPhysics
local getOwner     = E2Lib.getOwner
local isOwner      = E2Lib.isOwner

local Halos = {}

function SendTable( ply )
	net.Start("WireHaloInit")
		net.WriteTable(Halos)
	net.Send( ply )
end
hook.Add( "PlayerInitialSpawn", "WireHaloSpawn", SendTable )

function UpdateHalo( entidx, halo, delete )
	net.Start("WireHaloUpdate")
		net.WriteBit(delete)
		net.WriteLong(entidx)
		if not delete then
			net.WriteTable(halo)
		end
	net.Broadcast()
	if delete then Halos[entidx] = nil end
end

__e2setcost(20)

e2function void entity:setHalo(vector4 colour, number size, number passes, number walls)
	if not validPhysics(this) then return nil end
	if not isOwner(self, this) then return nil end
	local count = 0
	for k,v in pairs(Halos) do
		if v.owner == self.player then
			count = count + 1
		end
	end
	if count > GetConVar("wire_max_halo"):GetInt() then
		return 0
	end
	
	local HaloTable = {
		["halo"] = {
			["R"] = math.Clamp(colour[1], 0, 255),
			["G"] = math.Clamp(colour[2], 0, 255),
			["B"] = math.Clamp(colour[3], 0, 255),
			["A"] = math.Clamp(colour[4], 0, 255),
			["Size"] = math.Clamp(size, 0, 3),
			["Passes"] = math.Clamp(passes, 0, 3),
			["Walls"] = walls
		},
		["Chip"] = self.entity,
		["owner"] = self.player
	}
	Halos[this:EntIndex()] = HaloTable
	
	UpdateHalo(this:EntIndex(), HaloTable, false)
	return 1
end

__e2setcost(5)

e2function void entity:removeHalo()
	if not validPhysics(this) then return nil end
	if not isOwner(self, this) then return nil end
	if not Halos[this:EntIndex()] then return 0 end
	UpdateHalo(this:EntIndex(), nil, true)
end

registerCallback("destruct", function(self)
	if not self or not validEntity(self.entity) then return end
	for k, v in pairs(Halos) do
		if v.Chip == self.entity then
			UpdateHalo(k, nil, true)
		end
	end
end)
