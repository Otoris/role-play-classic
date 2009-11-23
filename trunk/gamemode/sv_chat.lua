function GM:PlayerSay( ply, text, toall )

	for k, v in pairs(player.GetAll()) do
		if ply:GetPos():Distance(v:GetPos()) < ChatDistance then
			if DeveloperMode then
			Msg( "Returned Text\n" )
			end
			return text
		end
	end
	if DeveloperMode then
	Msg( "No Text Returned\n" )
	end
end

