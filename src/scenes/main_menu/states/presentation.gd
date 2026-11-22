extends LobbyState

@export var presentation_control: PresentationControl

func _ready():
	init_for_control(presentation_control)
	
func enter(msg: Dictionary = {}) -> void:
	super(msg)
	presentation_control.clear()
