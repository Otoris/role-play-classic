local meta = FindMetaTable( "Player" )

function meta:FirstLastName()

	fullname = self:GetNWString( "FirstName" ) .." ".. self:GetNWString( "SurName" )

	return fullname
	
end
