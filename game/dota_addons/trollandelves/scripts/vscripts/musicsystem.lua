music_table={
	{"ent_gw_csd1","bgm.background1",227.0,true},
	{"ent_gw_csd2","bgm.background2",179.0,true},
	{"ent_gw_csd3","bgm.background3",210.0,true},
	{"ent_gw_csd4","bgm.background4",193.0,true},
	{"ent_gw_csd5","bgm.background5",247.0,true},
	{"ent_gw_csd6","bgm.background6",335.0,true}
}
GameRules.bgm_index = RandomInt(1, 6)

function InitBackGroundMusic()
	local v = music_table[GameRules.bgm_index]
	local ent = Entities:FindByName(nil, v[1])
	if ent ~= nil then
		ent:SetContextThink(v[1],
			function ()
				v = music_table[GameRules.bgm_index]
				EmitSoundOn(v[2],ent)
				if v[4] then
					if GameRules.bgm_index == #music_table then
						GameRules.bgm_index = 1
					else
						GameRules.bgm_index = (GameRules.bgm_index + 1)
					end
					return v[3]
				else
					return nil
				end
			end, 
		0.1)
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