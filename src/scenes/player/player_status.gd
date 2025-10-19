class_name PlayerStatus

var name: String = "Default"
var play_time: float = 0
var current_health: int = 10
var combat_class: Enums.CombatClasses = Enums.CombatClasses.Warrior
var stats: PlayerStats = PlayerStats.new()
var currency: int = 0
var inventory: Array[Items.ConsumableItems] = [1, 2, 3]
var armor_inventory: Array[Armor.Armor] = [1, 4, 7, 10]
var equipped_armor: Array[Armor.Armor]= [1, 4, 7, 10]
