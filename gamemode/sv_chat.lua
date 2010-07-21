include( 'shd_chat.lua' )
function GM:PlayerSay( ply, text, toall )

	for _, pl in pairs(player.GetAll()) do
		if pl:EyePos( ):Distance( ply:EyePos( ) ) <= ChatDistance then
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

