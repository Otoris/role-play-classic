local meta = FindMetaTable( "Player" )

function GM:DoPlayerDeath( ply, attacker, dmginfo )

	ply:CreateRagdoll()
	unique_id = ply:SteamID()
	DestroyProfile( unique_id, ply )
	if DeveloperMode then
		return
	end
	RunConsoleCommand( "addip", 1440, ply:IPAddress() )
	RunConsoleCommand( "kick", ply:Name() )
	
end

-- local function StorePlayerAmmo(ply)
	-- local ret = {}
	-- for _,v in ipairs(ply:GetWeapons()) do
		-- ret[v:GetPrimaryAmmoType()] == v:Clip1()]
	-- end
	-- return ret
-- end

local function CreateTask( ply, task, name, obj, complete, ttime )
	local task = {
		name,
		obj,
		complete,
		tonumber(ttime)
	}
	timer.Create( name, ttime, 1, function() if complete then timer.Destroy( name ) return end RemoveTask( name ) end )
	if DeveloperMode then
	PrintTable( task )
	Msg( task )
	end
end

function TestTask( ply, cmd, args )
CreateTask( ply, args[1], args[2], args[3], false, args[5] )
end
concommand.Add( "testtask", TestTask )
function TradeTask( ply, target, task )

end

local function RemoveTask( task )
	table.Remove( task )
end



function meta:PlayerSetModel( model )

	modelname = player_manager.TranslatePlayerModel( model )

	util.PrecacheModel( modelname )
	self:SetModel( modelname )

end