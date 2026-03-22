class_name PlayerStatus

var name: String = "Default"
var play_time: float = 0
var current_health: int = 10
var combat_class: Enums.CombatClasses = Enums.CombatClasses.Warrior
var stats: PlayerStats = PlayerStats.new()
var currency: int = 0
var inventory: Array[Items.ConsumableItems] = [Items.ConsumableItems.HealCrystal, Items.ConsumableItems.Energydrink, Items.ConsumableItems.ElementalInfusion]
var armor_inventory: Array[Armor.Armor]= [Armor.Armor.NoviceWeapon, Armor.Armor.NoviceHelmet, Armor.Armor.NoviceBreastPlate, Armor.Armor.NoviceBoots]
var equipped_armor: Array[Armor.Armor]= [Armor.Armor.NoviceWeapon, Armor.Armor.NoviceHelmet, Armor.Armor.NoviceBreastPlate, Armor.Armor.NoviceBoots]
