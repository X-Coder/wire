
include('shared.lua')

local matLight 		= Material( "sprites/light_ignorez" )
local matBeam		= Material( "effects/lamp_beam" )

ENT.RenderGroup 		= RENDERGROUP_BOTH

function ENT:Initialize()

	self.PixVis = util.GetPixelVisibleHandle()
	
end

/*---------------------------------------------------------
   Name: Draw
---------------------------------------------------------*/
function ENT:Draw()

	self.BaseClass.Draw( self )
	
end

/*---------------------------------------------------------
   Name: DrawTranslucent
   Desc: Draw translucent
---------------------------------------------------------*/
function ENT:DrawTranslucent()
	
	local LightNrm = self:GetAngles():Up()*(-1)
	local ViewDot = EyeVector():Dot( LightNrm )
	local c = self:GetColor()
	local LightPos = self:GetPos() + LightNrm * -10
	
	// glow sprite
	/*
	render.SetMaterial( matBeam )
	
	local BeamDot = BeamDot = 0.25
	
	render.StartBeam( 3 )
		render.AddBeam( LightPos + LightNrm * 1, 128, 0.0, Color( c.r, c.g, c.b, 255 * BeamDot) )
		render.AddBeam( LightPos - LightNrm * 100, 128, 0.5, Color( c.r, c.g, c.b, 64 * BeamDot) )
		render.AddBeam( LightPos - LightNrm * 200, 128, 1, Color( c.r, c.g, c.b, 0) )
	render.EndBeam()
	*/

	if ( ViewDot < 0 ) then return end
	
	render.SetMaterial( matLight )
	local Visible	= util.PixelVisible( LightPos, 16, self.PixVis )	
	local Size = math.Clamp( 512 * (1 - Visible*ViewDot),128, 512 )
	
	local Col = Color( c.r, c.g, c.b, 200*Visible*ViewDot )
	
	render.DrawSprite( LightPos, Size, Size, Col, Visible * ViewDot )
	
end

local wire_light_block = CreateClientConVar("wire_light_block", 0, false, false)

function ENT:Think()
	if self:GetGlow() and not wire_light_block:GetBool() then
		
		local dlight = DynamicLight( self:EntIndex() )
		if ( dlight ) then
			--local r, g, b, a = self:GetColor()
			local LightNrm = self:GetAngles():Up()*(-1)
			
			dlight.Pos = self:GetPos() + LightNrm * -10
			local c = self:GetColor()
			dlight.r,dlight.g,dlight.b = c.r, c.g, c.b
			dlight.Brightness = self:GetBrightness()
			dlight.Decay = self:GetDecay()
			dlight.Size = self:GetSize()
			dlight.DieTime = CurTime() + 1
		end
	
	end
end
