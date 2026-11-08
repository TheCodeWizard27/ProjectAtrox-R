extends Node3D
class_name Hud

@onready var _target_indicator: Node3D = $TargetIndicator

@onready var _target_stack: Node3D = $TargetStack
#@onready var _target_stack_text: MeshInstance3D = $TargetStack/Text
#@onready var _target_stack_text_shadow: MeshInstance3D = $TargetStack/Text/TextShadow

@onready var _death_indicator: Node3D = $DeathIndicator
@onready var _interaction_label: Node3D = $InteractionLabel
@onready var _interaction_label_text: MeshInstance3D = $InteractionLabel/Text
@onready var _interaction_label_shadow: MeshInstance3D = $InteractionLabel/Text/TextShadow

@onready var _health_bar: MeshInstance3D = $Health/Health

func update(player: Player, other_players: Dictionary[int, Player], delta: float) -> void:
	if (not is_instance_valid(player.target_detector.interaction_target)):
		player.target_detector.interaction_target = null
	if (not is_instance_valid(player.lock_on_target)):
		player.lock_on_target = null
	
	update_other_players(other_players)
	update_interaction(player.target_detector.interaction_target)
	update_target_indicator(player.lock_on_target, delta)
	update_target_stack(player.target_detector.targets.map(_get_target_name))
	
	var current_health = player.status.resources.health as float
	var max_health = player.status.attributes.max_health.value as float
	update_health(
		(current_health / max_health) if player.status != null 
		else (0 as float)
		)
	
	show_death_indicator(current_health <= 0)

func show_death_indicator(p_show: bool = true) -> void:
	_death_indicator.visible = p_show

func update_other_players(other_players: Dictionary[int, Player]) -> void:
	var player_stack = other_players.values()
	var container: Node3D = $OtherPlayers
	
	for i in range(2, 5):
		var player_element: Node3D = container.find_child('Player' + str(i))
		
		if (player_stack.size() <= 0):
			player_element.hide()
			continue
		
		var current_player = player_stack.pop_back() as Player
		var current_health = current_player.status.resources.health as float
		var max_health = current_player.status.attributes.max_health.value as float
		var size = (current_health / max_health) if current_player.status != null else (0 as float)
	
		var health_bar: MeshInstance3D = player_element.find_child('Health')
		var mat = health_bar.mesh.surface_get_material(0)
		mat.set("shader_parameter/size", size)
		player_element.show()

func update_interaction(interaction_target: InteractionTarget) -> void:
	var has_interaction_target = interaction_target != null
	_interaction_label.visible = has_interaction_target
	
	if (!has_interaction_target):
		return
	
	_interaction_label_text.mesh.set('text', interaction_target.interactable_text)
	_interaction_label_shadow.mesh.set('text', interaction_target.interactable_text)

func update_target_stack(_list: Array) -> void:
	_target_stack.visible = false # TODO properly implement until then hide for now.
	return
	
	#_target_stack.visible = list.size() > 0
	#
	#var target_list = '\n'.join(list)
	#
	#_target_stack_text.mesh.set('text', target_list)
	#_target_stack_text_shadow.mesh.set('text', target_list)

func update_target_indicator(target: Node3D, _delta: float) -> void:
	if (!target):
		_target_indicator.hide()
		return
		
	_target_indicator.show()
	_target_indicator.global_position = target.global_position

func update_health(new_value: float) -> void:
	var mat = _health_bar.mesh.surface_get_material(0)
	mat.set("shader_parameter/size", new_value)
	
func _get_target_name(target: ActionTarget) -> String:
	return target.visible_name
