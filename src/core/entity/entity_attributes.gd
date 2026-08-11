class_name EntityAttributes

var max_health: EntityAttribute = EntityAttribute.new(100)
var strength: EntityAttribute = EntityAttribute.new(20)
var dexterity: EntityAttribute = EntityAttribute.new(20)
var intelligence: EntityAttribute = EntityAttribute.new(20)
var defense: EntityAttribute = EntityAttribute.new(20)
var crit_chance: EntityAttribute = EntityAttribute.new(0.05, 0, 1)
var speed: EntityAttribute = EntityAttribute.new(1, 0, 1.4)

func copy() -> EntityAttributes:
	var new_attributes = EntityAttributes.new()
	
	new_attributes.max_health = max_health.copy_without_modifiers()
	new_attributes.strength = strength.copy_without_modifiers()
	new_attributes.dexterity = dexterity.copy_without_modifiers()
	new_attributes.intelligence = intelligence.copy_without_modifiers()
	new_attributes.defense = defense.copy_without_modifiers()
	new_attributes.crit_chance = crit_chance.copy_without_modifiers()
	new_attributes.speed = speed.copy_without_modifiers()
	
	return new_attributes
