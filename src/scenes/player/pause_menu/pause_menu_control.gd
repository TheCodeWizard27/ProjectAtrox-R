extends Control
class_name PauseMenuControl

@onready var name_label: Label = %StatusInfo/PlayerInfo/ValueLabel
@onready var class_label: Label = %StatusInfo/ClassInfo/ValueLabel
@onready var currency_label: Label = %StatusInfo/CurrencyInfo/ValueLabel
@onready var play_time_label: Label = %StatusInfo/PlayTimeInfo/ValueLabel
@onready var health_label: Label = %StatusInfo/HealthInfo/ValueLabel
@onready var strength_label: Label = %StatusInfo/StrengthInfo/ValueLabel
@onready var dexterity_label: Label = %StatusInfo/DexterityInfo/ValueLabel
@onready var intelligence_label: Label = %StatusInfo/IntelligenceInfo/ValueLabel
@onready var defense_label: Label = %StatusInfo/DefenseInfo/ValueLabel
@onready var speed_label: Label = %StatusInfo/SpeedInfo/ValueLabel

@onready var inventory: VBoxContainer = $MarginContainer/TabContainer/Status/MarginContainer/HBoxContainer/VBoxContainer/PanelContainer2/MarginContainer/Invenctory/Entries
@onready var gear_inventory: VBoxContainer = $MarginContainer/TabContainer/Status/MarginContainer/HBoxContainer/VBoxContainer/PanelContainer3/MarginContainer/Invenctory/Entries

func update(player_status: PlayerStatus) -> void:
	name_label.text = player_status.name
	currency_label.text = str(player_status.currency) + ' $'
	
	var seconds = fmod(player_status.play_time, 60)
	var minutes = fmod(player_status.play_time / 60, 60)
	var hours = fmod(player_status.play_time / 60 / 60, 60)
	var time_text = '%02d:%02d:%02d' % [hours, minutes, seconds]
	play_time_label.text = time_text
	
	health_label.text = str(player_status.current_health) + ' / ' + str(player_status.attributes.max_health)
	strength_label.text = str(player_status.attributes.strength)
	dexterity_label.text = str(player_status.attributes.dexterity)
	intelligence_label.text = str(player_status.attributes.intelligence)
	defense_label.text = str(player_status.attributes.defense)
	speed_label.text = str(player_status.attributes.speed)

func load_inventory(player_status: PlayerStatus) -> void:
	var children = inventory.get_children()
	for child in children:
		inventory.remove_child(child)
	
	for item in player_status.inventory:
		var hBox = HBoxContainer.new()
		var item_name_label = Label.new()
		hBox.add_child(item_name_label)
		
		match(item.type):
			Item.ItemType.MISC:
				item_name_label.text = MiscItems.item_table[item.item].name
			Item.ItemType.CONSUMABLE: 
				item_name_label.text = ConsumableItems.item_table[item.item].name
		
		hBox.add_spacer(false)
		
		var count_label = Label.new()
		hBox.add_child(count_label)
		count_label.text = str(item.count)
		
		inventory.add_child(hBox)

func load_gear(player_status: PlayerStatus) -> void:
	var children = gear_inventory.get_children()
	for child in children:
		gear_inventory.remove_child(child)
	
	for item in player_status.gear_inventory:
		var hBox = HBoxContainer.new()
		var item_name_label = Label.new()
		hBox.add_child(item_name_label)
		
		item_name_label.text = GearItems.item_table[item.item].name
		
		gear_inventory.add_child(hBox)
