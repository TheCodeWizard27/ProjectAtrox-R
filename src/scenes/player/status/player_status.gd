class_name PlayerStatus
extends StoredPlayerStatus

var base_attributes: PlayerAttributes = PlayerAttributes.new()
var attributes: PlayerAttributes = PlayerAttributes.new()

var resources: PlayerResources = PlayerResources.new()

var effects: Array[EffectReference]
