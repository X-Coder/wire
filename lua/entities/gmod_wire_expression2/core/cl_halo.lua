--[[
	Halo Extension
	  by thetree / Optimized by Ninja101
]]

local CanDraw = CreateConVar("wire_expression2_halo_draw", "1")

require("glon")

Halos = {}
 
net.Receive("WireHaloInit", function()
    Halos = net.ReadTable()
end)

net.Receive("WireHaloUpdate", function()
	local todo = net.ReadBit()
	local entidx = net.ReadLong()
	if todo == 1 then
		Halos[entidx] = nil
	else
		local add = net.ReadTable()
		Halos[entidx] = add
	end
end)

hook.Add("PreDrawHalos", "WireHaloRender", function()
	if CanDraw:GetBool() then
		Draw = {}
		for k, v in pairs(Halos) do
			local str = glon.encode(v.halo)
			if not Draw[str] then
				Draw[str] = {Entity(k)}
			else
				table.insert(Draw[str], Entity(k))
			end
		end
		for key, v in pairs(Draw) do
			local k = glon.decode(key)
			effects.halo.Add(v, Color(k.R, k.G, k.B, k.A), k.Size, k.Size, k.Passes, true, (k.Walls > 0))
		end
	end
end)