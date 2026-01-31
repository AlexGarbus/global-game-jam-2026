class_name Bounds
extends Node


@export var min_position: Vector3
@export var max_position: Vector3
@export var target: Node3D


func _physics_process(delta: float) -> void:
	target.global_position = target.global_position.clamp(min_position, max_position)
