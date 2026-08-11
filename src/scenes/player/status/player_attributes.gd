class_name PlayerAttributes
extends EntityAttributes

var inventory_size: EntityAttribute = EntityAttribute.new(25)
var gear_inventory_size: EntityAttribute = EntityAttribute.new(8)

func copy() -> EntityAttributes:
	var new_attributes = PlayerAttributes.new()
	
	new_attributes.max_health = max_health.copy_without_modifiers()
	new_attributes.strength = strength.copy_without_modifiers()
	new_attributes.dexterity = dexterity.copy_without_modifiers()
	new_attributes.intelligence = intelligence.copy_without_modifiers()
	new_attributes.defense = defense.copy_without_modifiers()
	new_attributes.crit_chance = crit_chance.copy_without_modifiers()
	new_attributes.speed = speed.copy_without_modifiers()
	
	new_attributes.inventory_size = inventory_size.copy_without_modifiers()
	new_attributes.gear_inventory_size = gear_inventory_size.copy_without_modifiers()
	
	return new_attributes
