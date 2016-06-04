--[[
	Replaces the building to the upgraded unit name
]]--
function UpgradeBuilding( event )
	local caster = event.caster
	local new_unit = event.UnitName
	local position = caster:GetAbsOrigin()
	local playerID = caster:GetPlayerOwnerID()
	local player = PlayerResource:GetPlayer(playerID)
	local currentHealthPercentage = caster:GetHealthPercent() * 0.01

	-- Keep the gridnav blockers, hull radius and orientation
	local blockers = caster.blockers
	local hull_radius = caster:GetHullRadius()
	local flag = caster.flag
	local flag_type = caster.flag_type
	local angle = caster:GetAngles()

    -- New building
	local building = BuildingHelper:PlaceBuilding(player, new_unit, position, caster.construction_size, 0, 0)
	building.blockers = blockers
	building:SetHullRadius(hull_radius)
	building:SetAngles(0, angle.y, 0)

	-- Keep the rally flag reference if there is one
    building.flag = flag

	-- If the building to ugprade is selected, change the selection to the new one
	if PlayerResource:IsUnitSelected(playerID, caster) then
		PlayerResource:AddToSelection(playerID, building)
	end

	-- Remove the old building
	local old_flag = caster.flag
	if IsValidEntity(caster) then
		caster:SetAbsOrigin(Vector(12000, -12000, 0))
        caster:RemoveSelf()
    end

	local newRelativeHP = building:GetMaxHealth() * currentHealthPercentage
	if newRelativeHP == 0 then newRelativeHP = 1 end --just incase rounding goes wrong
	building:SetHealth(newRelativeHP)

end

--[[
	Disable any queue-able ability that the building could have, because the caster will be removed when the channel ends
	A modifier from the ability can also be passed here to attach particle effects
]]--
function StartUpgrade( event )	
	local caster = event.caster
	local ability = event.ability
	local modifier_name = event.ModifierName
	local lumberCost = event.ability:GetSpecialValueFor("lumber_cost")
	local playerID = caster:GetPlayerOwnerID()

	if lumberCost and lumberCost > Players:GetLumber(playerID) then
		return
	end

	-- Iterate through abilities marking those to disable
	local abilities = {}
	for i=0,15 do
		local abil = caster:GetAbilityByIndex(i)
		if abil then
			local ability_name = abil:GetName()

			-- Abilities to hide include the strings train_ and research_, the rest remain available
			if string.match(ability_name, "train_") or string.match(ability_name, "research_") then
				table.insert(abilities, abil)
			end
		end
	end

	-- Keep the references to enable if the upgrade gets canceled
	caster.disabled_abilities = abilities

	-- Units can't attack while upgrading
	caster.original_attack = caster:GetAttackCapability()
	caster:SetAttackCapability(DOTA_UNIT_CAP_NO_ATTACK)

	-- Pass a modifier with particle(s) of choice to show that the building is upgrading. Remove it on CancelUpgrade
	if modifier_name then
		ability:ApplyDataDrivenModifier(caster, caster, modifier_name, {})
		caster.upgrade_modifier = modifier_name
	end

	FireGameEvent( 'ability_values_force_check', { player_ID = playerID })
end

-- Resets any change done in StartUpgrade
function CancelUpgrade( event )
	local caster = event.caster
	local abilities = caster.disabled_abilities
	local playerID = caster:GetPlayerOwnerID()

	-- Give the unit their original attack capability
    caster:SetAttackCapability(caster.original_attack)

	local upgrade_modifier = caster.upgrade_modifier
	if upgrade_modifier and caster:HasModifier(upgrade_modifier) then
		caster:RemoveModifierByName(upgrade_modifier)
	end

	FireGameEvent( 'ability_values_force_check', { player_ID = playerID })
end

-- Forces an ability to level 0
function SetLevel0( event )
	local ability = event.ability
	if ability:GetLevel() == 1 then
		ability:SetLevel(0)	
	end
end

-- Hides an ability
function HideAbility( event )
	local ability = event.ability
	ability:SetHidden(true)
end