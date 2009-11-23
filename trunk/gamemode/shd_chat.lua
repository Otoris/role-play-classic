function GM:OnPlayerChat( player, strText, bTeamOnly, bPlayerIsDead )

	if bPlayerIsDead then
		return false
	end
	
			if string.sub( strText, 1, 3 ) == "/me" then
				chat.AddText( Color( 255, 255, 255 ), player:FirstLastName(), " ", string.gsub(strText, "/me", "" ) )
				return true
			end
				
			if string.sub( strText, 1, 3 ) == "/it" then
				chat.AddText( Color( 255, 255, 255 ), string.gsub(strText, "/it", "" ) )
				return true
			end
			
			chat.AddText( Color( 20, 20, 20 ), player:FirstLastName(), Color( 255, 255, 255 ), ": ", strText )
			return true
		
end
