class_name DefeatChanger
extends Node
## A node that changes a target node to a different instance once its health reaches zero.


@export var health: Health: set = set_health
@export var target: Node
@export var scene: PackedScene


func set_health(value: Health) -> void:
	health = value
	health.reached_zero.connect(_on_health_reached_zero)


func _on_health_reached_zero() -> void:
	var parent := target.get_parent()
	var instance := scene.instantiate()
	var instance_3d := instance as Node3D
	var target_3d := target as Node3D
	if instance_3d and target_3d:
		instance_3d.global_transform = target_3d.global_transform
	parent.add_child(instance)
	target.queue_free()
