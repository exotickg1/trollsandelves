function Reveal( event )
	local caster = event.caster
	local ability = event.ability
	local level = ability:GetLevel()
	local reveal_radius = ability:GetLevelSpecialValueFor( "reveal_radius", level - 1 )
	local duration = ability:GetLevelSpecialValueFor( "duration", level - 1 )

	local particleName = "particles/items_fx/dust_of_appearance.vpcf"
	local target = event.target_points[1]

	EmitSoundOnLocationForAllies(target, "DOTA_Item.DustOfAppearance.Activate", caster)

    -- Particle for team
    local particle = ParticleManager:CreateParticle(particleName, PATTACH_WORLDORIGIN, caster)
    ParticleManager:SetParticleControl( particle, 0, target )
    ParticleManager:SetParticleControl( particle, 1, Vector(reveal_radius,1,reveal_radius) )

    local units = FindUnitsInRadius(caster:GetTeamNumber(), target, nil, reveal_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER,false)

    -- Vision
    AddFOWViewer(caster:GetTeamNumber(), target, reveal_radius, duration, false)
end