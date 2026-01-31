class_name NodeFollow3D
extends Node3D
## A node that smoothly follows the transform of a target [Node3D].


## The [Node3D] to follow the transform of.
@export var target: Node3D
## The weight used for smoothing translation. Higher values lead to stiffer movement.
@export var linear_weight := 20.0
## The weight used for smoothing rotation. Higher values lead to stiffer movement.
@export var angular_weight := 5.0
## When enabled, the node will not rotate to match [member target].
@export var lock_rotation := false


func _ready() -> void:
	global_position = target.global_position


func _physics_process(delta: float) -> void:
	global_position = global_position.lerp(target.global_position, linear_weight * delta)
	if not lock_rotation:
		global_basis = global_basis.slerp(target.global_basis, angular_weight * delta)
