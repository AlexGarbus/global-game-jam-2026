extends AnimatableBody3D


const Eye := preload("uid://5vhu0fombpnq")

@export var _angular_velocity: Vector3
@export var _eyes: Array[Eye]

var rotating := false


func _physics_process(delta: float) -> void:
	if not rotating:
		return
	var new_basis := global_basis
	new_basis = new_basis.rotated(Vector3.RIGHT, _angular_velocity.x * delta)
	new_basis = new_basis.rotated(Vector3.UP, _angular_velocity.y * delta)
	new_basis = new_basis.rotated(Vector3.FORWARD, _angular_velocity.z * delta)
	global_basis = new_basis.orthonormalized()


func set_active(value: bool) -> void:
	rotating = value
	for eye in _eyes:
		eye.set_shooting(value)
