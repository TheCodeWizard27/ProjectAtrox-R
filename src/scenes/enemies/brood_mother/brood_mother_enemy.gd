extends BaseEnemy
class_name BroodMotherEnemy

var spawns: Array[PlaceholderNode]
var max_spawns: int = 3

var detected_player: Player

@onready var buff_box: Area3D = %BuffBox	

func _ready() -> void:
	for i in max_spawns:
		var placeholder = PlaceholderNode.new()
		spawns.append(placeholder)
		add_child(placeholder)
	
