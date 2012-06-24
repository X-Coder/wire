local path = "Expression2/_helloworld_.txt"

local contents = [[
@name Hello World
@inputs A B
@outputs Add Sub Mul Div
@outputs GreaterThan Highest Lowest
@outputs Vector:vector
@persist D
@trigger all

Add = A + B
Sub = A - B
Mul = A * B
Div = A / B

GreaterThan = A > B

if(A > B) {
    Highest = A, Lowest = B
} else {
    Highest = B, Lowest = A
}

Vector = vec(A, B, 0)
Vector = Vector + vec(0, 0, A + B)
Vector = Vector:normalized()
]]

local f = file.Open(path, "w", "DATA")
if (f) then
	f:Write(contents)
	f:Close()
end