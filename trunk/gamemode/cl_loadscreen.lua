function FinishLoad()

	loadfinished = true

end

loadfinished = false

function LoadScreen()

if !loadfinished then
	draw.RoundedBox( 0, 0, 0, ScrW(), ScrH(), Color( 0, 0, 0, 255 ) )
	draw.SimpleText("Loading...", "ScoreboardText", ScrW() - 60, ScrH() - 63, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

end

hook.Add( "HUDPaint", LoadScreen, LoadScreen )
