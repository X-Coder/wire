
if CLIENT then

	local path = "wire/datafiles/"
	local files = file.Find(path .. "*.lua", LUA_PATH)

	if not file.Exists("wire_version.txt", "DATA") then

		for _, v in pairs(files) do
			include(path .. v)
		end
		
		local f = file.Open("wire_version.txt", "w", "DATA")
		if f then
			f:Write("2527")
			f:Close()
		end
		
	end

end