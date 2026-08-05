class_name PlayerStatus
extends StoredPlayerStatus

var base_attributes: PlayerAttributes = PlayerAttributes.new()
var attributes: PlayerAttributes = PlayerAttributes.new()

var current_health: float = 10

var effects: Array[EffectReference]
