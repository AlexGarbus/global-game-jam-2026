class_name GemPickupEffect
extends PickupEffect


@export var gem_type: Enum.GemType


func apply(player: Player) -> void:
	player.inventory.set_gem(gem_type, true)
