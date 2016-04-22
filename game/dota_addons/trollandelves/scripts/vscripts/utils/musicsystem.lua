music_table={
	{"backgroundmusic_1","TrollsAndElves.background1",227.0,true},
	{"backgroundmusic_2","TrollsAndElves.background2",179.0,true},
	{"backgroundmusic_3","TrollsAndElves.background3",210.0,true},
	{"backgroundmusic_4","TrollsAndElves.background4",193.0,true},
	{"backgroundmusic_5","TrollsAndElves.background5",247.0,true},
	{"backgroundmusic_6","TrollsAndElves.background6",335.0,true}
}

function InitBackGroundMusic()
	for k,v in ipairs(music_table) do
		local ent = Entities:FindByName(nil, v[1])
		if ent ~= nil then
			ent:SetContextThink(v[1],
				function ()
					EmitSoundOn(v[2],ent)
					if v[4] then
						return v[3]
					else
						return nil
					end
				end, 
			0.1)
		end
	end
end

function EmitSoundBackGroundMusic(strMusic)
	for k,v in ipairs(music_table) do
		if v[1] == strMusic then
			local ent = Entities:FindByName(nil, v[1])
			if ent ~= nil then
				ent:SetContextThink(v[1],
					function ()
						EmitSoundOn(v[2],ent)
						v[4] = true
						return v[3]
					end, 
				0.1)
			end
		end
	end
end

function StopSoundBackGroundMusic(strMusic)
	for k,v in ipairs(music_table) do
		if v[1] == strMusic then
			local ent = Entities:FindByName(nil, v[1])
			if ent ~= nil then
				ent:SetContextThink(v[1],
					function ()
						StopSoundOn(v[2],ent)
						v[4] = false
						return nil
					end, 
				0.1)
			end
		end
	end
end