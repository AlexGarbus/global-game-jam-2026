class_name HealthPickupEffect
extends PickupEffect


@export var delta := 1


func apply(player: Player) -> void:
	player.health.current_value += delta
