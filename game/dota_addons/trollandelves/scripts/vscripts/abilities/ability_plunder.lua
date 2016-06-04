function plunder(keys)
    local caster = keys.caster
    local damage = caster:GetAverageTrueAttackDamage()
    caster:ModifyGold(damage, true, 0)

    PopupGoldGain(caster,math.floor(damage))
end