extends LobbyControl
class_name PresentationControl

@onready var current_page: Label = %CurrentPage

@onready var start: Control = %Start
@onready var table_of_contents: Control = %TableOfContents

@onready var overview: Control = %Overview
@onready var overview2: Control = %Overview2

@onready var demo: Control = %Demo

@onready var network: Control = %Network
@onready var network2: Control = %Network2
@onready var network3: Control = %Network3
@onready var network4: Control = %Network4
@onready var network5: Control = %Network5
@onready var network6: Control = %Network6

@onready var sync: Control = %Sync
@onready var sync2: Control = %Sync2
@onready var sync3: Control = %Sync3
@onready var sync4: Control = %Sync4

@onready var arch: Control = %Arch
@onready var arch2: Control = %Arch2
@onready var arch3: Control = %Arch3

@onready var retro: Control = %Retro
@onready var end: Control = %End
@onready var qna: Control = %QNA

var _current_control: Control
var _current_page = 1
var _control_stack: Array[Control] = []

func clear() -> void:
	_control_stack.clear()
	_current_control = null
	_show_next(start, 1)

func hide_all() -> void:
	var all_controls = [
		start,
		table_of_contents,
		overview,
		overview2,
		demo,
		network,
		network2,
		network3,
		network4,
		network5,
		network6,
		
		sync,
		sync2,
		sync3,
		sync4,
		
		arch,
		arch2,
		arch3,
		
		retro,
		end,
		qna
	]
	
	for control in all_controls:
		control.hide()

func _show_next(control: Control, page: int) -> void:
	hide_all()
	control.show()
	if (_current_control):
		_control_stack.push_front(_current_control)
	_current_control = control
	_current_page = page
	_set_page(_current_page)

func _go_back() -> void:
	if (_control_stack.is_empty()):
		return
	
	var previous_control = _control_stack.pop_front()
	hide_all()
	previous_control.show()
	_current_control = previous_control
	_current_page = _current_page - 1
	_set_page(_current_page)

func _set_page(page: int) -> void:
	current_page.text = str(page)

func _on_back_button_pressed() -> void:
	_go_back()

func _on_start_button_pressed() -> void:
	_show_next(table_of_contents, _current_page + 1)

func _on_table_of_contents_button_pressed() -> void:
	_show_next(overview, _current_page + 1)

func _on_overview_button_pressed() -> void:
	_show_next(overview2, _current_page + 1)
	
func _on_overview_button_2_pressed() -> void:
	_show_next(demo, _current_page + 1)

func _on_start_demo_button_pressed() -> void:
	pass

func _on_skip_demo_button_pressed() -> void:
	_show_next(network, _current_page + 1)

func _on_network_button_pressed() -> void:
	_show_next(network2, _current_page + 1)

func _on_network_button_2_pressed() -> void:
	_show_next(network3, _current_page + 1)

func _on_network_button_3_pressed() -> void:
	_show_next(network4, _current_page + 1)

func _on_network_button_4_pressed() -> void:
	_show_next(network5, _current_page + 1)

func _on_network_button_5_pressed() -> void:
	_show_next(network6, _current_page + 1)

func _on_network_button_6_pressed() -> void:
	_show_next(sync, _current_page + 1)

func _on_sync_button_pressed() -> void:
	_show_next(sync2, _current_page + 1)

func _on_sync_button_2_pressed() -> void:
	_show_next(sync3, _current_page + 1)

func _on_sync_button_3_pressed() -> void:
	_show_next(sync4, _current_page + 1)

func _on_sync_button_4_pressed() -> void:
	_show_next(arch, _current_page + 1)

func _on_arch_button_pressed() -> void:
	_show_next(arch2, _current_page + 1)

func _on_arch_button_2_pressed() -> void:
	_show_next(arch3, _current_page + 1)

func _on_arch_button_3_pressed() -> void:
	_show_next(retro, _current_page + 1)

func _on_retro_button_pressed() -> void:
	_show_next(end, _current_page + 1)

func _on_end_button_pressed() -> void:
	_show_next(qna, _current_page + 1)
