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

-- local function StorePlayerAmmo( ply )
	-- local ret = {}
	-- for _,v in ipairs( ply:GetWeapons() ) do
		-- ret[v:GetPrimaryAmmoType()] = v:Clip1()
	-- end
	-- if DeveloperMode then
		-- PrintTable( ret )
	-- end
	-- return ret
-- end
-- concommand.Add( "storeammo", StorePlayerAmmo )

function meta:PlayerSetModel( model )

	modelname = player_manager.TranslatePlayerModel( model )

	util.PrecacheModel( modelname )
	self:SetModel( modelname )

end

function meta:LoadLock( ply, arg )
	if arg == 1 then
		ply:Lock()
	else
		ply:UnLock()
	end
end
concommand.Add( "loadlock", LoadLock )

function meta:GiveCurrency( amount )
	local camount = meta:GetNWString( "Currency" )
	local famount = tonumber(camount) + tonumber(amount)
	meta:SetNWString( "Currency", tostring(famount) )
end

function meta:TakeCurrency( amount )
	local camount = meta:GetNWString( "Currency" )
	local famount = tonumber(camount) - tonumber(amount)
	meta:SetNWString( "Currency", tostring(famount) )
end
