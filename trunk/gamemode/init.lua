AddCSLuaFile( 'cl_init.lua' )
AddCSLuaFile( 'cl_charactercreate.lua' )
AddCSLuaFile( 'cl_loadscreen.lua' )
AddCSLuaFile( 'cl_hud.lua' )
AddCSLuaFile( 'shared.lua' )
AddCSLuaFile( 'shd_player.lua' )
AddCSLuaFile( 'shd_chat.lua' )
AddCSLuaFile( 'shd_config.lua' )
AddCSLuaFile( 'shd_animation.lua' )

include( 'shared.lua' )
include( 'shd_animation.lua' )
include( 'shd_config.lua' )
include( 'shd_player.lua' )
include( 'shd_chat.lua' )
include( 'sv_chat.lua' )
include( 'sv_player.lua' )
include( 'sv_database.lua' )


/*---------------------------------------------------------
   Name: gamemode:Initialize( )
   Desc: Called immediately after starting the gamemode 
---------------------------------------------------------*/
function GM:Initialize( )
	for k, v in pairs(rpc.animation.models) do
		util.PrecacheModel(v)
	end
end


/*---------------------------------------------------------
   Name: gamemode:InitPostEntity( )
   Desc: Called as soon as all map entities have been spawned
---------------------------------------------------------*/
function GM:InitPostEntity( )	
end


/*---------------------------------------------------------
   Name: gamemode:Think( )
   Desc: Called every frame
---------------------------------------------------------*/
function GM:Think( )
end


/*---------------------------------------------------------
   Name: gamemode:ShutDown( )
   Desc: Called when the Lua system is about to shut down
---------------------------------------------------------*/
function GM:ShutDown( )
end

/*---------------------------------------------------------
   Name: gamemode:EntityTakeDamage( entity, inflictor, attacker, amount, dmginfo )
   Desc: The entity has received damage	 
---------------------------------------------------------*/
function GM:EntityTakeDamage( ent, inflictor, attacker, amount, dmginfo )
end


/*---------------------------------------------------------
   Name: gamemode:CreateEntityRagdoll( entity, ragdoll )
   Desc: A ragdoll of an entity has been created
---------------------------------------------------------*/
function GM:CreateEntityRagdoll( entity, ragdoll )
	timer.Simple( RagdollRemoveTime, function() ragdoll:Remove() end )
end


/*---------------------------------------------------------
	Show the default team selection screen
---------------------------------------------------------*/
function GM:ShowTeam( ply )

end

function ChangePLModel( ply, cmd, args )

	if args[1] then
		ply:SetModel( args[1] )
	end

end
concommand.Add( "ChangePLModel", ChangePLModel )




