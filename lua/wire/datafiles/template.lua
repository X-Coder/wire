local path = ""

local contents = [[

]]

local f = file.Open(path, "w", "DATA")
if (f) then
	f:Write(contents)
	f:Close()
end