class_name WarriorModelAnimator

enum WarriorActionBlendPosition {
	PRIMARY_ATTACK_1 = 0,
	PRIMARY_ATTACK_2 = 1,
	PRIMARY_ATTACK_3 = 2,
}

var _class_action_one_shot: String
var _class_blend_position: String
var _class_type: int
var _class_action_blend_position: String
var _animation_tree: AnimationTree

func _init(p_animation_tree: AnimationTree, p_class_action_one_shot: String, p_class_action_prefix: String, p_class_type: int) -> void:
	_animation_tree = p_animation_tree
	_class_action_one_shot = p_class_action_one_shot
	_class_type = p_class_type
	_class_blend_position = p_class_action_prefix + "/blend_position"
	_class_action_blend_position = p_class_action_prefix + "/" + str(p_class_type) + "/blend_position"

func play_action(type: WarriorActionBlendPosition) -> void:
	_animation_tree.set(_class_blend_position, _class_type)
	_animation_tree.set(_class_action_blend_position, type)
	_animation_tree.set(_class_action_one_shot, AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
