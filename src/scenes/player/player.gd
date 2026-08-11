extends Entity
class_name Player

@export var max_speed: float = Globals.PLAYER_MAX_SPEED
@export var turn_threshold: float = Globals.ENTITY_TURN_THRESHOLD
@export var turn_speed: float = Globals.ENTITY_TURN_SPEED

@export var body: CharacterBody3D
@export var target_detector: TargetDetector
@export var event_player: PlayerEventPlayer
@export var model_animator: PlayerModelAnimator
@export var state_machine: StateMachine
@export var camera_anchor: Marker3D

var looking_direction: Vector3 = Vector3.FORWARD
var lock_on_target: Node3D
var input_buffer: InputBuffer = InputBuffer.new()

var inventory: InventorySystem = InventorySystem.new()
var effects: EffectSystem = EffectSystem.new()
var status: PlayerStatus

var primary_action_state: NodePath
var secondary_action_state: NodePath
var defensive_action_state: NodePath
var special_action_state: NodePath

func configure_player(new_status: PlayerStatus) -> void:
	status = new_status
	inventory.configure(status)
	effects.configure(self, status.effects)
	
	# TODO remove Simple mesh replacement test.
	var skeleton: Skeleton3D = $Body/CharacterModel/metarig/Skeleton3D
	var other_skin
	if(status.combat_class == Enums.CombatClasses.WARRIOR):
		other_skin = preload("res://src/assets/models/player/character_model.tscn").instantiate()	
	if(status.combat_class == Enums.CombatClasses.MAGE):
		other_skin = preload("res://src/assets/models/player/character_model_2.tscn").instantiate()
	
	var other_skin_skeleton = other_skin.get_node('metarig').get_node('Skeleton3D')
	
	var mesh_names: Array[String] = [
		'Head',
		'Arms',
		'LowerBody',
		'Legs'
	]
	
	for mesh_path in mesh_names:
		skeleton.remove_child(skeleton.get_node(mesh_path))
		var new_mesh_node = other_skin_skeleton.get_node(mesh_path)
		other_skin_skeleton.remove_child(new_mesh_node)
		new_mesh_node.owner = null
		skeleton.add_child(new_mesh_node)
	
	update_attributes()
	_init_class_actions()
	_init_resources()
	
	# TODO remove effect test
	effects.add_effect(EffectReference.create_with_duration(EffectIds.Id.REGEN, 5))
	effects.add_effect(EffectReference.create_with_duration(EffectIds.Id.SPEED, 5))

#region Entity implementation

func get_hit() -> void:
	super.get_hit()
	status.resources.health -= 5 # TODO
	event_player.play_getting_hit()
	
func get_entity_position() -> Vector3:
	return body.position
	
func get_entity_rotation() -> Vector3:
	return body.rotation

func add_effect(effect_reference: EffectReference) -> void:
	effects.add_effect(effect_reference)

#endregion

func push_event(event: InputEvent) -> void:
	input_buffer.push_event(event)

func update_attributes() -> void:
	status.attributes = status.base_attributes.copy()
	inventory.update_attributes(status.attributes)
	effects.update_attributes(status.attributes)

func _ready() -> void:
	_init_state_machine()
	_connect_to_events()
	configure_player(PlayerStatus.new())

func _init_state_machine() -> void:
	for state in state_machine.get_all_states(true):
		if state is PlayerState:
			state.init(self)

func _process(delta: float) -> void:
	effects.process_effects(delta)
	update_attributes() # TODO check Maybe do this conditionally?
	state_machine.process(delta)
	status.play_time += delta

func _physics_process(delta: float) -> void:	
	state_machine.physics_process(delta)
	body.move_and_slide()
	input_buffer.update()

func _init_class_actions() -> void:
	match status.combat_class:
		Enums.CombatClasses.WARRIOR:
			primary_action_state = WarriorState.WARRIOR_PRIMARY_ACTION
			secondary_action_state = WarriorState.WARRIOR_SECONDARY_ACTION
			defensive_action_state = WarriorState.WARRIOR_DEFENSIVE_ACTION
			special_action_state = WarriorState.WARRIOR_SPECIAL_ACTION
		Enums.CombatClasses.MAGE:
			primary_action_state = MageState.MAGE_PRIMARY_ACTION
			secondary_action_state = MageState.MAGE_SECONDARY_ACTION
			defensive_action_state = MageState.MAGE_DEFENSIVE_ACTION
			special_action_state = MageState.MAGE_SPECIAL_ACTION

func _init_resources() -> void:
	status.resources.health = status.attributes.max_health.value

func _connect_to_events() -> void:
	Events.player.quest_accepted.connect(_on_accept_quest)

func _on_accept_quest(quest: Quest) -> void:
	status.current_quest = quest

func _on_item_collector_area_entered(area: Area3D) -> void:
	var item_entity = EntityResolveUtil.resolve_item(area)
	
	if (item_entity == null or item_entity.item_reference == null):
		return
	
	var result = inventory.add_item(item_entity.pick_up())
	
	if (result == null):
		return
	
	# TODO cleanup but basically spawn Item leftovers
	var item = preload('res://src/scenes/item_entity/item_entity.tscn').instantiate() as ItemEntity
	Events.entity.spawn_entity(item, get_entity_position(), get_entity_rotation())
	item.delay_pick_up()
	item.add_spawn_velocity()
	item.item_reference = result
