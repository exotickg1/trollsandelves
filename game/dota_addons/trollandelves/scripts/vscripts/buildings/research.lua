--[[
	Adds the search to the player research list
]]
function ResearchComplete( event )
	local caster = event.caster
	local player = caster:GetPlayerOwner()
	local hero = player:GetAssignedHero()
	local ability = event.ability
	local ability_level = ability:GetLevel()
	local research_name = ability:GetAbilityName()

	-- It shouldn't be possible to research the same upgrade more than once.
	hero.upgrades[research_name] = ability_level
	ability:SetLevel(ability_level + 1)
	
	-- Go through all the upgradeable units and upgrade with the research
	for _,unit in pairs(hero.units) do
		CheckAbilityRequirements( unit, player )
	end

	-- Also, on the buildings that have the upgrade, disable the upgrade and/or apply the next rank.
	for _,structure in pairs(hero.structures) do
		CheckAbilityRequirements( structure, player )
	end

	--PrintTable(hero.upgrades)
end

function ScoutResearchComplete ( event )
	local caster = event.caster
	local ability = event.ability
	local itemName = event.item_name
	local player = caster:GetPlayerOwner()
	local hero = player:GetAssignedHero()

	hero:AddItemByName(itemName)
	ResearchComplete(event)
end

function LumberResearchComplete( event )
	local player = event.caster:GetPlayerOwner()
	local hero = player:GetAssignedHero()
	local level = event.Level
	local extra_lumber_carried = event.ability:GetLevelSpecialValueFor("extra_lumber_carried", level - 1)

	hero.LumberCarried = 10 + extra_lumber_carried
end


-- When queing a research, disable it to prevent from being queued again
function DisableResearch( event )
	local ability = event.ability
	print("Set Hidden "..ability:GetAbilityName())
	ability:SetHidden(true)

	local caster = event.caster
	local hero = caster:GetOwner()
	local pID = hero:GetPlayerID()
end

-- Reenable the parent ability without item_ in its name
function ReEnableResearch( event )
	local caster = event.caster
	local ability = event.ability
	local item_name = ability:GetAbilityName()
	local research_ability_name = string.gsub(item_name, "item_", "")

	print("Unhide "..research_ability_name)
	local research_ability = caster:FindAbilityByName(research_ability_name)
	research_ability:SetHidden(false)

	local caster = event.caster
	local hero = caster:GetOwner()
	local pID = hero:GetPlayerID()
end