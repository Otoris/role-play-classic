function Startup()
	//Start up our database by either A) Loading the existing one or B) creating tables for a new one!
	if ( sql.TableExists( "profiles" ) && sql.TableExists( "permakills" ) ) then
		Msg( "Player Profiles Loaded\n" )
		Msg( "Permakills list Loaded\n" )
	else
		if ( !sql.TableExists( "profiles" ) ) then
			query = "CREATE TABLE profiles ( unique_id varchar(255), rp_firstname str, rp_surname str, rp_model str, rp_hp int, rp_armor int, rp_currency varchar(255) )"
			result = sql.Query( query )
			if ( sql.TableExists( "profiles" ) ) then
				Msg( "Profiles Database Created\n" )
			else
				Msg( "Profiles Database Failed to Create\n" )
				Msg( sql.LastError( result ) .. "\n" )
			end
		end
		if ( !sql.TableExists( "permakills" ) ) then
			query = "CREATE TABLE permakills ( rp_firstname str, rp_surname str )"
			result = sql.Query( query )
			if ( sql.TableExists( "permakills" ) ) then
				Msg( "Permakill list Created\n" )
			else
				Msg( "Permakill Database Failed to Create\n" )
				Msg( sql.LastError( result ) .. "\n" )
			end
		end
	end
	
end

local function CheckForProfile( ply )

	ply.unique_id = ply:SteamID()
	
	result = sql.Query( "SELECT unique_id FROM profiles WHERE unique_id = '"..ply.unique_id.."'" )
	if ( result ) then
		if DeveloperMode then
		Msg( "Profile ".. ply.unique_id .." Exists\n" )
		end
		NewChar = "Failure"
		LoadProfile( ply ) // We will call this to retrieve the stats
	else
		if DeveloperMode then
		Msg( "Profile ".. ply.unique_id .." Creating\n" )
		end
		NewChar = nil
		ply:SendLua( "CharCreate()" )
	end
	
end

function GetNewSetup( ply, cmd, args )

	if ( NewChar == nil ) then
	raisedead = sql.Query( "SELECT * FROM permakills WHERE rp_firstname = '".. args[1] .."' AND rp_surname = '".. args[2] .."'" )
	Msg( raisedead )
		if raisedead then
		Msg( raisedead )
		ply:SendLua( "Derma_Message( 'Player is 6 feet under. R.I.P.', 'Profile Error', 'Close' )" )
		return
		end
	globalplayers = sql.Query( "SELECT * FROM profiles WHERE rp_firstname = '".. args[1] .."' AND rp_surname = '".. args[2] .."'" )
		if globalplayers then
		ply:SendLua( "Derma_Message( 'Profile Name in Use', 'Profile Error', 'Close' )" )
		return
		end
	
		ply.rp_firstname = args[1]
		ply.rp_surname = args[2]
		ply.rp_model = args[3]
		ply.rp_armor = StartingArmor
		ply.rp_hp = StartingHP
		ply:SendLua( "CompleteCharCreation()" )
		NewChar = "Failure"
		CreateProfile( unique_id, ply ) // Create a new player :D
	else
		RunConsoleCommand( "kick", ply:Name() )
		Msg( "Player Kicked for Hacking" )
	end
end
concommand.Add( "rp_newcharacter", GetNewSetup )

function CreateProfile( unique_id, ply )

	sql.Query( "INSERT INTO profiles ( `unique_id`, `rp_firstname`, `rp_surname`, `rp_model`, `rp_hp`, `rp_armor`, `rp_currency` )VALUES ( '".. ply.unique_id .."', '".. ply.rp_firstname .."', '".. ply.rp_surname .."', '".. ply.rp_model .."', '".. ply.rp_hp .."', '".. ply.rp_armor .."', '1' )" )
	result = sql.Query( "SELECT unique_id FROM profiles WHERE unique_id = '".. ply.unique_id .."'" )
	if ( result ) then
		if DeveloperMode then
		Msg( "Profile ID ".. ply.unique_id .." Created\n" )
		end
		LoadProfile( ply )
	else
		if DeveloperMode then
		Msg( "Profile Failed to Create\n" )
		Msg( sql.LastError( result ) )
		end
	end
	
end

function DestroyProfile( unique_id, ply )
	
	timer.Destroy( "SaveProfile" )
	sql.Query( "INSERT INTO permakills ( `rp_firstname`, `rp_surname` )VALUES ( '".. ply:GetNWString( "FirstName" ) .. "', '".. ply:GetNWString( "SurName" ) .."' )" )
	sql.Query( "DELETE FROM profiles WHERE unique_id = '".. ply.unique_id .."'" )
	if DeveloperMode then
		Msg( "Profile ID ".. ply.unique_id .." Destroyed and Added to the Permakill list\n" )
	end
end

local function SaveProfile( ply )

	ply.currency = ply:GetNWString( "Currency" )
	ply.hp = ply:Health()
	ply.armor = ply:Armor()
	sql.Query("UPDATE profiles SET rp_currency = "..ply.currency..", rp_hp = "..ply.hp..", rp_armor = "..ply.armor.."  WHERE unique_id = '"..ply.unique_id.."'")
	if DeveloperMode then
		Msg( "Profile ID ".. ply.unique_id .." Saved\n" )
	end

end
concommand.Add( "rp_saveprofile", SaveProfile )

function LoadProfile( ply )

	ply.profile = sql.QueryRow("SELECT * FROM profiles WHERE unique_id = '"..ply.unique_id.."'")
	
	ply.firstname = ply.profile["rp_firstname"]
	ply.surname = ply.profile["rp_surname"]
	ply.model = ply.profile["rp_model"]
	ply.hp = ply.profile["rp_hp"]
	ply.armor = ply.profile["rp_armor"]
	ply.currency = ply.profile["rp_currency"]
	
	ply:SetNWString( "FirstName", ply.firstname )
	ply:SetNWString( "SurName", ply.surname )
	ply:SetNWString( "Currency", ply.currency )
	ply:ConCommand( "ChangeModel ".. ply.model )
	ply:Spawn()
	
	if DeveloperMode then
		Msg( "Profile ID ".. ply.unique_id .." Loaded\n" )
		Msg( "Please welcome! ".. ply.firstname .." ".. ply.surname .." ".. ply.model .." HP:".. ply.hp .." ARMOR:".. ply.armor .." Currency:".. ply.currency .."\n" )
	end
	
end

function Initialize()

	Startup()
	
end

function PlayerInitialSpawn( ply )
	
	ply:SendLua( "LoadScreen()" )
	ply:Lock()
	
	timer.Simple( 5, function()
		ply.unique_id = ply:SteamID()
		CheckForProfile( ply ) 
		ply:SendLua( "FinishLoad()" )
		ply:UnLock()
	end )
	
end

function PlayerSpawn( ply )
	ply:SetHealth( ply.hp )
	ply:SetArmor( ply.armor )
	ply:SendLua( "SaveTimer()" )
end

hook.Add( "Initialize", Initialize, Initialize )
hook.Add( "PlayerInitialSpawn", PlayerInitialSpawn, PlayerInitialSpawn )
hook.Add( "PlayerSpawn", PlayerSpawn, PlayerSpawn )