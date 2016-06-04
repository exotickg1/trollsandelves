--[[
	Author: Noya
	Edited: -ExotiC-
	Replaces the building to the upgraded unit name
]]
function UpgradeBuilding( event )
	local caster = event.caster
	local new_unit = event.UnitName
	local position = caster:GetAbsOrigin()
	local hero = caster:GetPlayerOwner():GetAssignedHero()
	local playerID = hero:GetPlayerID()
	local player = PlayerResource:GetPlayer(playerID)
	local currentHealthPercentage = caster:GetHealthPercent() * 0.01

	-- Keep the gridnav blockers and orientation
	local blockers = caster.blockers
	local hull_radius = caster:GetHullRadius()
	local flag = caster.flag
	local flag_type = caster.flag_type
	local angle = caster:GetAngles()

	-- Remove the old building from the game
	local old_flag = caster.flag
	if IsValidEntity(caster) then
		--caster:SetAbsOrigin(Vector(6000, -6000, 0))
		--caster:ForceKill(true)
        caster:RemoveSelf()
    end

	-- If the building to ugprade is selected, change the selection to the new one
	if PlayerResource:IsUnitSelected(playerID, caster) then
		PlayerResource:AddToSelection(playerID, building)
	end

	-- New building
	local building = BuildingHelper:PlaceBuilding(player, new_unit, position, caster.construction_size, 0, 0)
	building.blockers = blockers
	building:SetHullRadius(hull_radius)
	building:SetAngles(0, angle.y, 0)


	-- Update the player base
	if not string.find(new_unit, "tower") then
		print("Updated Base: "..new_unit)
		hero.base = building
	end
	
	-- Unstuck any units
	Timers:CreateTimer(0.1, function()
		local units = FindUnitsInRadius(hero:GetTeamNumber(), position, nil, building:GetHullRadius()*2, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC, 0, 0, false)
		for _,unit in pairs(units) do
			FindClearSpaceForUnit(unit, unit:GetAbsOrigin(), true)
		end
	end)

end

-- Forces an ability to level 0
function SetLevel0( event )
	local ability = event.ability
	if ability:GetLevel() == 1 then
		ability:SetLevel(0)	
	end
end