function plunder(keys)
    local caster = keys.caster
    local damage = caster:GetAverageTrueAttackDamage()
    local goldGain = damage * 1
    caster:ModifyGold(goldGain, true, 0)

    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_alchemist/alchemist_lasthit_coins.vpcf", PATTACH_ABSORIGIN, caster )
    ParticleManager:SetParticleControl( particle, 0, caster:GetAbsOrigin() )
    ParticleManager:SetParticleControl( particle, 1, caster:GetAbsOrigin() )
end