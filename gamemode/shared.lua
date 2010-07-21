
/*---------------------------------------------------------

RPClassic is in no way meant to be ready for server use unless you want the baseline Role-Play Experience.
RPClassic is totally modifiable for any style Gamemode/RP :/
RPClassic is completely from scratch and is not taken from any other gamemodes. (Except GMod Base)

---------------------------------------------------------*/

include( 'shd_chat.lua' )
include( 'shd_config.lua' )
include( 'shd_player.lua' )
include( 'shd_animation.lua' )

GM.Name 		= "Role-Play Classic"
GM.Author 		= "The Otoris Corp."
GM.Email 		= "me@otoris.com"
GM.Website 		= "www.otoris.com"
GM.TeamBased 	= false


/*---------------------------------------------------------
   Name: gamemode:PlayerHurt( )
   Desc: Called when a player is hurt.
---------------------------------------------------------*/
function GM:PlayerHurt( player, attacker, healthleft, healthtaken )
end


/*---------------------------------------------------------
   Name: gamemode:KeyPress( )
   Desc: Player pressed a key (see IN enums)
---------------------------------------------------------*/
function GM:KeyPress( player, key )
end


/*---------------------------------------------------------
   Name: gamemode:KeyRelease( )
   Desc: Player released a key (see IN enums)
---------------------------------------------------------*/
function GM:KeyRelease( player, key )
end


/*---------------------------------------------------------
   Name: gamemode:PlayerConnect( )
   Desc: Player has connects to the server (hasn't spawned)
---------------------------------------------------------*/
function GM:PlayerConnect( name, address )
end

/*---------------------------------------------------------
   Name: gamemode:PlayerAuthed( )
   Desc: Player's STEAMID has been authed
---------------------------------------------------------*/
function GM:PlayerAuthed( ply, SteamID, UniqueID )
end



/*---------------------------------------------------------
   Name: gamemode:PropBreak( )
   Desc: Prop has been broken
---------------------------------------------------------*/
function GM:PropBreak( attacker, prop )
end


/*---------------------------------------------------------
   Name: gamemode:PhysgunPickup( )
   Desc: Return true if player can pickup entity
---------------------------------------------------------*/
function GM:PhysgunPickup( ply, ent )

	// Don't pick up players
	if ( ent:GetClass() == "player" ) then return false end

	return true
end


/*---------------------------------------------------------
   Name: gamemode:PhysgunDrop( )
   Desc: Dropped an entity
---------------------------------------------------------*/
function GM:PhysgunDrop( ply, ent )
end


/*---------------------------------------------------------
   Name: gamemode:SetupMove( player, movedata )
   Desc: Allows us to change stuff before the engine 
		  processes the movements
---------------------------------------------------------*/
function GM:SetupMove( ply, move )
end


/*---------------------------------------------------------
   Name: gamemode:FinishMove( player, movedata )
---------------------------------------------------------*/
function GM:FinishMove( ply, move )

end

/*---------------------------------------------------------
   Name: gamemode:Move
   This basically overrides the NOCLIP, PLAYERMOVE movement stuff.
   It's what actually performs the move. 
   Return true to not perform any default movement actions. (completely override)
---------------------------------------------------------*/
function GM:Move( ply, mv )
end

/*---------------------------------------------------------
   Name: gamemode:PlayerShouldTakeDamage
   Return true if this player should take damage from this attacker
---------------------------------------------------------*/
function GM:PlayerShouldTakeDamage( ply, attacker )
	return true
end

/*---------------------------------------------------------
   Name: gamemode:ContextScreenClick(  aimvec, mousecode, pressed, ply )
   'pressed' is true when the button has been pressed, false when it's released
---------------------------------------------------------*/
function GM:ContextScreenClick( aimvec, mousecode, pressed, ply )
	
	// We don't want to do anything by default, just feed it to the weapon
	local wep = ply:GetActiveWeapon()
	if ( ValidEntity( wep ) && wep.ContextScreenClick ) then
		wep:ContextScreenClick( aimvec, mousecode, pressed, ply )
	end
	
end

/*---------------------------------------------------------
   Name: Text to show in the server browser
---------------------------------------------------------*/
function GM:GetGameDescription()
	return self.Name
end


/*---------------------------------------------------------
   Name: Saved
---------------------------------------------------------*/
function GM:Saved()
end


/*---------------------------------------------------------
   Name: Restored
---------------------------------------------------------*/
function GM:Restored()
end


/*---------------------------------------------------------
   Name: EntityRemoved
   Desc: Called right before an entity is removed. Note that this
   isn't going to be totally reliable on the client since the client
   only knows about entities that it has had in its PVS.
---------------------------------------------------------*/
function GM:EntityRemoved( ent )
end


/*---------------------------------------------------------
   Name: Tick
   Desc: Like Think except called every tick on both client and server
---------------------------------------------------------*/
function GM:Tick()
end

/*---------------------------------------------------------
   Name: OnEntityCreated
   Desc: Called right after the Entity has been made visible to Lua
---------------------------------------------------------*/
function GM:OnEntityCreated( Ent )
end

/*---------------------------------------------------------
   Name: gamemode:EntityKeyValue( ent, key, value )
   Desc: Called when an entity has a keyvalue set
	      Returning a string it will override the value
---------------------------------------------------------*/
function GM:EntityKeyValue( ent, key, value )
end

/*---------------------------------------------------------
   Name: gamemode:CreateTeams()
   Desc: Note - HAS to be shared.
---------------------------------------------------------*/
function GM:CreateTeams()

end


/*---------------------------------------------------------
   Name: gamemode:ShouldCollide( Ent1, Ent2 )
   Desc: This should always return true unless you have 
		  a good reason for it not to.
---------------------------------------------------------*/
function GM:ShouldCollide( Ent1, Ent2 )
	return true
end
