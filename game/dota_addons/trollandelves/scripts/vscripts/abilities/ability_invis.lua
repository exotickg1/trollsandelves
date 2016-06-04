function invis_cast( event )
  event.ability:ApplyDataDrivenModifier(event.caster, event.caster, "modifier_troll_invis", nil)
  event.caster:AddNewModifier(event.caster, event.ability, "modifier_invisible", {duration = 25}) 

end

function invis_interrupt( event )
 event.caster:RemoveModifierByName("modifier_troll_invis")
 event.caster:RemoveModifierByName("modifier_invisible")
end

function invis_attack( event )
 event.caster:RemoveModifierByName("modifier_troll_invis")
 event.caster:RemoveModifierByName("modifier_invisible")
end