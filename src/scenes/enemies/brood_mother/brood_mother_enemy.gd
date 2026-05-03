extends BaseEnemy
class_name BroodMotherEnemy

var spawns: Array[PlaceholderNode]
var max_spawns: int = 3

var detected_player: Player

@onready var buff_box: Area3D = %BuffBox	
@onready var spawn_location: Node3D = %SpawnLocation

func _ready() -> void:
	for i in max_spawns:
		var placeholder = PlaceholderNode.new()
		spawns.append(placeholder)
		spawn_location.add_child(placeholder)
	
