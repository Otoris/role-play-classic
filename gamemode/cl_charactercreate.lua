include( 'shd_animation.lua' )
function CharCreate( ply )

	CharPanel = vgui.Create( "DFrame" ) -- Creates the frame itself
	CharPanel:SetSize( 300, 596 ) -- Size of the frame
	CharPanel:SetPos( ScrW() / 2 - 150, ScrH() / 2 - 300) -- Position on the players screen
	CharPanel:SetPos( ScrW() / 2 - 150, ScrH() / 2 - 297) -- Position on the players screen
	CharPanel:SetTitle( "Character Creation" ) -- Title of the frame
	CharPanel:SetVisible( true )
	CharPanel:SetBackgroundBlur( true )
	CharPanel:SetDraggable( false ) -- Draggable by mouse?
	CharPanel:ShowCloseButton( false ) -- Show the close button?
	CharPanel:MakePopup() -- Show the frame

	backgroundPanel = vgui.Create( "DPanel", CharPanel )
	backgroundPanel:SetSize( 290, 450 )
	backgroundPanel:SetPos( 5, 22 )
	backgroundPanel.Paint = function() -- Paint function
		surface.SetDrawColor( 50, 50, 50, 255 )
		surface.DrawRect( 0, 0, backgroundPanel:GetWide(), backgroundPanel:GetTall() )
	end
	
	mdlPanel = vgui.Create( "DModelPanel", backgroundPanel )
	mdlPanel:SetSize( 550, 550 )
	mdlPanel:SetPos( -135, -105 )
	mdlPanel:SetModel( rpc.animation.models.male[1]) )
	mdlPanel:SetAnimSpeed( 0.0 )
	mdlPanel:SetAnimated( false )
	mdlPanel:SetAmbientLight( Color( 50, 50, 50 ) )
	mdlPanel:SetDirectionalLight( BOX_TOP, Color( 255, 255, 255 ) )
	mdlPanel:SetDirectionalLight( BOX_FRONT, Color( 255, 255, 255 ) )
	mdlPanel:SetCamPos( Vector( 100, 0, 40 ) )
	mdlPanel:SetLookAt( Vector( 0, 0, 40 ) )
	mdlPanel:SetFOV( 70 )
	
	function mdlPanel:LayoutEntity(Entity)

		self:RunAnimation();
		Entity:SetAngles( Angle( 0, 0, 0) )
	
	end
	
	i = 1
	
	LastMdl = vgui.Create( "DSysButton", CharPanel )
	LastMdl:SetType("left")
	LastMdl.DoClick = function()
		
		i = i - 1

		if( i == 0 ) then
			i = #rpc.animation.models.male
		end
		
		mdlPanel:SetModel(rpc.animation.models.male[i])
		
	end
	LastMdl:SetPos( 20, 460 )
	
	NextMdl = vgui.Create( "DSysButton", CharPanel )
	NextMdl:SetType("right")
	NextMdl.DoClick = function()
		
		i = i + 1

		if(i > #rpc.animation.models.male) then
			i = 1
		end
		
		mdlPanel:SetModel(rpc.animation.models.male[i])
		
	end
	NextMdl:SetPos( 220, 460 )
	
	NameForm = vgui.Create( "DForm", CharPanel )
	NameForm:SetSize( 280, 150 )
	NameForm:SetPos( 10, 485 )
	NameForm:SetPadding( 2 )
	NameForm:SetName( "Identification" )
	
	-- first = vgui.Create( "DLabel" )
	-- NameForm:AddItem( first )
	-- first:SetSize( 30, 25 )
	-- first:SetPos( 90, 50 )
	-- first:SetText( "First: " )
	
	firstname = vgui.Create( "DTextEntry" )
	NameForm:AddItem( firstname )
	firstname:SetSize( 100, 25 )
	firstname:SetPos( 140, 50 )
	firstname:SetText( "First Name" )
	
	-- sur = vgui.Create( "DLabel" )
	-- NameForm:AddItem( sur )
	-- sur:SetSize( 30, 25 )
	-- sur:SetPos( 90, 90 )
	-- sur:SetText( "Sur: " )
	
	surname = vgui.Create( "DTextEntry" )
	NameForm:AddItem( surname )
	surname:SetSize( 100, 25 )
	surname:SetPos( 140, 90 )
	surname:SetText( "Last Name" )
	
	apply = vgui.Create( "DButton" )
	NameForm:AddItem( apply )
	apply:SetSize( 270, 25 )
	apply:SetPos( 5, 140 )
	apply:SetText( "Finish and Create" )
	apply.DoClick = function()
		LocalPlayer().finalmodel = rpc.animation.models.male[i]
		LocalPlayer().finalfirstname = firstname:GetValue()
		LocalPlayer().finalsurname = surname:GetValue()
		if string.len( LocalPlayer().finalfirstname ) > 16 then
			Derma_Message( "16 Character Name Limit", "Profile Error", "Close" )
			return
		end
		if string.len( LocalPlayer().finalfirstname ) == 0 then
			Derma_Message( "Enter a First Name", "Profile Error", "Close" )
			return
		end
		if string.len( LocalPlayer().finalsurname ) > 16 then
			Derma_Message( "16 Character Name Limit", "Profile Error", "Close" )
			return
		end
		if string.len( LocalPlayer().finalsurname ) == 0 then
			Derma_Message( "Enter a Sur Name", "Profile Error", "Close" )
			return
		end
		
		if LocalPlayer().finalsurname == "Last Name" then
			Derma_Message( "Enter a Sur Name", "Profile Error", "Close" )
			return
		end
		
		if LocalPlayer().finalfirstname == "First Name" then
			Derma_Message( "Enter a First Name", "Profile Error", "Close" )
			return
		end
		
		if LocalPlayer().finalsurname == " " then
			Derma_Message( "Enter a Sur Name", "Profile Error", "Close" )
			return
		end
		
		if LocalPlayer().finalfirstname == " " then
			Derma_Message( "Enter a First Name", "Profile Error", "Close" )
			return
		end
		
		SubmitProfile( ply )
		
	end
	
end

function CompleteCharCreation()
	CharPanel:Close()
end
