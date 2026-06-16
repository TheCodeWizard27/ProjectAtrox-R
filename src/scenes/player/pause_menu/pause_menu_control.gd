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

func update(player_status: PlayerStatus) -> void:
	name_label.text = player_status.name
	#class_label.text = player_status.name
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
