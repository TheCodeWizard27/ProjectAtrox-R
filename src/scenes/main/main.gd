extends Node3D

# Define scene as path so the Game can start immediately.
@export var initial_scene_path: String

@onready var _loading_screen: LoadingScreen = $LoadingScene
@onready var _sub_scene: PlaceholderNode = $PlaceholderNode

var _current_load_state: int # (ResourceLoader.ThreadLoadStatus)
var _current_loading_path: String
var _current_scene: Node

func _ready() -> void:
	Events.scene_change_requested.connect(_start_load)

	_start_load(initial_scene_path)

func _process(_delta: float) -> void:
	if _current_load_state == ResourceLoader.ThreadLoadStatus.THREAD_LOAD_LOADED:
		return

	var progress = []
	_current_load_state = ResourceLoader.load_threaded_get_status(_current_loading_path, progress)
	print(progress)

	assert(
		_current_load_state != ResourceLoader.ThreadLoadStatus.THREAD_LOAD_INVALID_RESOURCE,
		"Error Invalid Resource"
		)
	assert(
		_current_load_state != ResourceLoader.ThreadLoadStatus.THREAD_LOAD_FAILED,
		"Error Load Failed"
		)

	if (_current_load_state == ResourceLoader.ThreadLoadStatus.THREAD_LOAD_LOADED):
		_end_load()

func _start_load(scene_path: String) -> void:
	_current_loading_path = scene_path
	ResourceLoader.load_threaded_request(_current_loading_path)
	_loading_screen.init()
	
func _end_load() -> void:
	var resource = ResourceLoader.load_threaded_get(_current_loading_path)

	assert(resource is PackedScene, "Loaded resource is not a Scene")

	_current_scene = _sub_scene.load_in(resource)
	_loading_screen.visible = false
