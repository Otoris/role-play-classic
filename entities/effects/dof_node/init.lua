

EFFECT.Mat = Material( "pp/dof" )

/*---------------------------------------------------------
   Initializes the effect. The data is a table of data 
   which was passed from the server.
---------------------------------------------------------*/
function EFFECT:Init( data )
	
	table.insert( DOF_Ents, self.Entity )
	self.Scale = data:GetScale()
	
	local size = 32
	self.Entity:SetCollisionBounds( Vector( -size, -size, -size ), Vector( size, size, size ) )
	
end


/*---------------------------------------------------------
   THINK
---------------------------------------------------------*/
function EFFECT:Think( )

	// If the spacing or offset has changed we need to reconfigure our positions
	local ply = LocalPlayer()

	self.spacing 	= DOF_SPACING * self.Scale
	self.offset 	= DOF_OFFSET
	
	// Just return if it hasn't
	//if ( spacing == self.spacing && offset == self.offset ) then return true end
	
	local pos = ply:EyePos()
	local fwd = ply:EyeAngles():Forward()
	
	pos = pos + (fwd * self.spacing) + (fwd * self.offset)
	
	self.Entity:SetParent( nil )
	self.Entity:SetPos( pos )
	self.Entity:SetParent( ply )
		
	// We don't kill this, the pp effect should
	return true
	
end

/*---------------------------------------------------------
   Draw the effect
---------------------------------------------------------*/
function EFFECT:Render()

	//render.UpdateRefractTexture()
	render.UpdateScreenEffectTexture()

	local SpriteSize = (self.spacing + self.offset) * 3.0
	
	render.SetMaterial( self.Mat )
	render.DrawSprite( self.Entity:GetPos(), SpriteSize, SpriteSize, Color(255, 255, 255, 255) )

end
