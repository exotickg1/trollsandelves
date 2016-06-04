function GoldIncome(keys)
    local caster = keys.caster
    local income = GameMode.UnitKVs[caster:GetUnitName()].GoldAmount
    local pID = caster:GetPlayerOwnerID()
	local hero = caster:GetOwner()

	PlayerResource:ModifyGold(pID, income, true, 0) 
	PopupGoldGain(caster, income)
end