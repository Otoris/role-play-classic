local meta = FindMetaTable( "Player" )

function meta:PlayerSetModel( model )

	modelname = player_manager.TranslatePlayerModel( model )

	util.PrecacheModel( modelname )
	self:SetModel( modelname )

end