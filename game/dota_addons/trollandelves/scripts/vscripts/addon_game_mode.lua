-- This is the entry-point to your game mode and should be used primarily to precache models/particles/sounds/etc

require('internal/util')
require('gamemode')
require('libraries/buildinghelper')
require('utils/musicsystem')

function Precache( context )
--[[
  This function is used to precache resources/units/items/abilities that will be needed
  for sure in your game and that will not be precached by hero selection.  When a hero
  is selected from the hero selection screen, the game will precache that hero's assets,
  any equipped cosmetics, and perform the data-driven precaching defined in that hero's
  precache{} block, as well as the precache{} block for any equipped abilities.

  See GameMode:PostLoadPrecache() in gamemode.lua for more information
  ]]

  DebugPrint("[BAREBONES] Performing pre-load precache")

  -- Particles can be precached individually or by folder
  -- It it likely that precaching a single particle system will precache all of its children, but this may not be guaranteed
  PrecacheResource("particle", "particles/econ/generic/generic_aoe_explosion_sphere_1/generic_aoe_explosion_sphere_1.vpcf", context)
  PrecacheResource("particle_folder", "particles/test_particle", context)

  -- Models can also be precached by folder or individually
  -- PrecacheModel should generally used over PrecacheResource for individual models
  PrecacheResource("model_folder", "particles/heroes/antimage", context)
  PrecacheResource("model", "particles/heroes/viper/viper.vmdl", context)
  PrecacheModel("models/heroes/viper/viper.vmdl", context)
  --PrecacheModel("models/props_gameplay/treasure_chest001.vmdl", context)
  --PrecacheModel("models/props_debris/merchant_debris_chest001.vmdl", context)
  --PrecacheModel("models/props_debris/merchant_debris_chest002.vmdl", context)

  -- Sounds can precached here like anything else
  PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_gyrocopter.vsndevts", context)
  PrecacheResource("soundfile", "soundevents/bgm.vsndevts", context)

  -- Entire items can be precached by name
  -- Abilities can also be precached in this way despite the name
  PrecacheItemByNameSync("example_ability", context)
  PrecacheItemByNameSync("item_example_item", context)
  
  -- Armors
  PrecacheItemByNameSync("item_trollsandelves_armor1", context)
  PrecacheItemByNameSync("item_trollsandelves_armor2", context)
  PrecacheItemByNameSync("item_trollsandelves_armor3", context)
  PrecacheItemByNameSync("item_trollsandelves_armor4", context)
  PrecacheItemByNameSync("item_trollsandelves_armor5", context)
  PrecacheItemByNameSync("item_trollsandelves_armor6", context)
  PrecacheItemByNameSync("item_trollsandelves_armor7", context)
  PrecacheItemByNameSync("item_trollsandelves_armor8", context)
  PrecacheItemByNameSync("item_trollsandelves_armor9", context)
  PrecacheItemByNameSync("item_trollsandelves_armor10", context)
  PrecacheItemByNameSync("item_trollsandelves_armor11", context)
  PrecacheItemByNameSync("item_trollsandelves_armor12", context)

  -- Blades
  PrecacheItemByNameSync("item_trollsandelves_dmg1", context)
  PrecacheItemByNameSync("item_trollsandelves_dmg2", context)
  PrecacheItemByNameSync("item_trollsandelves_dmg3", context)
  PrecacheItemByNameSync("item_trollsandelves_dmg4", context)
  PrecacheItemByNameSync("item_trollsandelves_dmg5", context)
  PrecacheItemByNameSync("item_trollsandelves_dmg6", context)
  PrecacheItemByNameSync("item_trollsandelves_dmg7", context)
  PrecacheItemByNameSync("item_trollsandelves_dmg8", context)
  PrecacheItemByNameSync("item_trollsandelves_dmg9", context)
  PrecacheItemByNameSync("item_trollsandelves_dmg10", context)
  PrecacheItemByNameSync("item_trollsandelves_dmg11", context)
  PrecacheItemByNameSync("item_trollsandelves_dmg12", context)

  -- Gloves
  PrecacheItemByNameSync("item_trollsandelves_gloves1", context)
  PrecacheItemByNameSync("item_trollsandelves_gloves2", context)
  PrecacheItemByNameSync("item_trollsandelves_gloves3", context)
  PrecacheItemByNameSync("item_trollsandelves_gloves4", context)
  PrecacheItemByNameSync("item_trollsandelves_gloves5", context)
  PrecacheItemByNameSync("item_trollsandelves_gloves6", context)

  -- Health
  PrecacheItemByNameSync("item_trollsandelves_hp1", context)
  PrecacheItemByNameSync("item_trollsandelves_hp2", context)
  PrecacheItemByNameSync("item_trollsandelves_hp3", context)
  PrecacheItemByNameSync("item_trollsandelves_hp4", context)
  PrecacheItemByNameSync("item_trollsandelves_hp5", context)
  PrecacheItemByNameSync("item_trollsandelves_hp6", context)
  PrecacheItemByNameSync("item_trollsandelves_hp7", context)
  PrecacheItemByNameSync("item_trollsandelves_hp8", context)
  PrecacheItemByNameSync("item_trollsandelves_hp9", context)
  PrecacheItemByNameSync("item_trollsandelves_hp10", context)
  PrecacheItemByNameSync("item_trollsandelves_hp11", context)


  -- Entire heroes (sound effects/voice/models/particles) can be precached with PrecacheUnitByNameSync
  -- Custom units from npc_units_custom.txt can also have all of their abilities and precache{} blocks precached in this way
  --PrecacheUnitByNameSync("dummy_tower", context)
  --PrecacheUnitByNameSync("elf_tent", context)
  --PrecacheUnitByNameSync("elf_house1", context)


  PrecacheUnitByNameSync("npc_dota_hero_troll_trollsandelves", context)
  PrecacheUnitByNameSync("npc_dota_hero_elf_trollsandelves", context)

  -- Precache Building Helper
  PrecacheResource("particle_folder", "particles/buildinghelper", context)
end

-- Create the game mode when we activate
function Activate()
  GameRules.GameMode = GameMode()
  GameRules.GameMode:_InitGameMode()
end
