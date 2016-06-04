-- hero.lumber = 0
-- hero.gold = 0
-- hero.food = 0
-- modifyGold(hero,0)
-- modifyLumber(hero,0)

function modifyGold(hero,gold)
    local player = hero:GetPlayerOwner()
    if hero.gold + gold > 1000000 then
      hero.gold = 1000000
    else
      hero.gold = hero.gold + gold
    end
    CustomGameEventManager:Send_ServerToPlayer(player, "player_custom_gold_changed", { gold = math.floor(hero.gold) })
end

function modifyLumber(hero,lumber)
    local player = hero:GetPlayerOwner()
    if hero.lumber + lumber > 1000000 then
      hero.lumber = 1000000
    else
      hero.lumber = hero.lumber + lumber
    end
    CustomGameEventManager:Send_ServerToPlayer(player, "player_lumber_changed", { lumber = math.floor(hero.lumber) })
end

function modifyFood(hero,food)
    local player = hero:GetPlayerOwner()
    local playerID = hero:GetMainControllingPlayer()
    if hero.food + food > 20 then
      hero.food = 20
    else
      SendErrorMessage(playerID, "#error_not_enough_food")
    end
    CustomGameEventManager:Send_ServerToPlayer(player, "player_food_changed", { food = math.floor(hero.food) , maxFood = GameRules.max_food })
end