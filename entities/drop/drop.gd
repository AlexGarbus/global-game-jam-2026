extends Node3D


@export_range(1, 100, 1, "or_greater") var spawn_chance := 1

@onready var _spawner := $Spawner


func _ready() -> void:
	if randi() % spawn_chance == 0:
		_spawner.spawn()


func _on_explosion_animation_finished() -> void:
	queue_free()
