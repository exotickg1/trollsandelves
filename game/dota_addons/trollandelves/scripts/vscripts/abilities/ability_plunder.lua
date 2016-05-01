function plunder(keys)
    local caster = keys.caster
    local player = PlayerResource:GetPlayer( caster:GetPlayerID() )
    local damage = caster:GetAverageTrueAttackDamage()
    local goldGain = damage * 1

    caster:ModifyGold(goldGain, true, 0)

	local particle = ParticleManager:CreateParticle("particles/generic_gameplay/lasthit_coins.vpcf", PATTACH_ABSORIGIN, caster )
	ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 1, caster:GetAbsOrigin())

    local particle = ParticleManager:CreateParticle("particles/msg_fx/msg_gold.vpcf", PATTACH_ABSORIGIN, caster )
	ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 1, Vector(0, goldGain, 0))
	ParticleManager:SetParticleControl(particle, 2, Vector(1, goldGain, 0))
	ParticleManager:SetParticleControl(particle, 3, Vector(255, 200, 10))
end