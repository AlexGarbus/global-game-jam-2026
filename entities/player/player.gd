extends RigidBody3D


## Amount to change the player's height by after knockback.
@export_custom(PROPERTY_HINT_NONE, "suffix:m") var knockback_correction := 1.0
@export_group("Linear Motion")
@export_range(0.0, 5.0, 0.1, "or_greater", "hide_control", "suffix:m/s") var _max_linear_speed := 5.0
@export_range(0.0, 5.0, 0.1, "or_greater", "hide_control") var _linear_acceleration := 5.0
@export_group("Angular Motion")
@export_range(0.0, 5.0, 0.1, "or_greater", "hide_control", "suffix:m/s") var _max_angular_speed := 5.0
@export_range(0.0, 5.0, 0.1, "or_greater", "hide_control") var _angular_acceleration := 5.0
@export_range(-90.0, 0.0, 0.1, "radians_as_degrees") var _min_pitch := 0.0
@export_range(0.0, 90.0, 0.1, "radians_as_degrees") var _max_pitch := 0.0

var input_disabled := false
var _angular_speed := Vector2.ZERO
var _knockback_angle := 0.0

@onready var health: Health = $Health
@onready var _bullet_spawner: Spawner3D = $BulletSpawner
@onready var _camera_pivot: NodeFollow3D = $CameraPivot
@onready var _damage_area: DamageArea3D = $DamageArea3D
@onready var _knockback_timer: Timer = $KnockbackTimer


func _unhandled_input(event: InputEvent) -> void:
	if input_disabled:
		return
	if event.is_action_pressed("shoot"):
		_bullet_spawner.spawn()


func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	if input_disabled:
		return
	_apply_angular_input(state)
	_apply_linear_input(state)


func _apply_angular_input(state: PhysicsDirectBodyState3D) -> void:
	var to_x := 0.0
	var to_y := 0.0
	var input_dir := Input.get_vector("move_right", "move_left", "move_up", "move_down")
	var euler := state.transform.basis.get_euler()
	if input_dir.x != 0:
		to_y = clamp(_angular_speed.y + input_dir.x, -_max_angular_speed, _max_angular_speed)
	if (
		euler.x <= _min_pitch and input_dir.y <= 0
		or euler.x >= _max_pitch and input_dir.y >= 0
	):
		_angular_speed.y = 0
		euler.x = clampf(euler.x, _min_pitch, _max_pitch)
		state.transform.basis = Basis.from_euler(euler).orthonormalized()
	elif input_dir.y != 0:
		to_x = clamp(_angular_speed.x + input_dir.y, -_max_angular_speed, _max_angular_speed)
	_angular_speed.x = move_toward(_angular_speed.x, to_x, _angular_acceleration * state.step)
	_angular_speed.y = move_toward(_angular_speed.y, to_y, _angular_acceleration * state.step)
	state.angular_velocity = _angular_speed.x * Vector3.RIGHT + _angular_speed.y * Vector3.UP


func _apply_linear_input(state: PhysicsDirectBodyState3D)-> void:
	var current_speed := state.linear_velocity.length()
	var new_speed := 0.0
	if Input.is_action_pressed("accelerate"): 
		if current_speed >= _max_linear_speed:
			new_speed = _max_linear_speed
		else:
			var delta := _linear_acceleration * state.step
			new_speed = move_toward(current_speed, _max_linear_speed, delta)
	state.linear_velocity = state.transform.basis.z * -new_speed


func _set_force_integration(enabled: bool) -> void:
	custom_integrator = not enabled
	input_disabled = enabled
	_damage_area.set_deferred("monitoring", not enabled)


func _start_knockback() -> void:
	_knockback_angle = global_rotation.y
	_set_force_integration(true)
	_camera_pivot.lock_rotation = true
	_knockback_timer.start()


func _end_knockback() -> void:
	_set_force_integration(false)
	global_position.y += knockback_correction
	global_rotation = Vector3(0, _knockback_angle, 0)
	_camera_pivot.lock_rotation = false


func _on_health_changed(old_value: int, new_value: int) -> void:
	if new_value == 0:
		_set_force_integration(true)
	elif new_value < old_value:
		_start_knockback()


func _on_knockback_timer_timeout() -> void:
	_end_knockback()


func _on_collect_area_3d_area_entered(area: Area3D) -> void:
	var pickup_area := area as PickupArea
	if not pickup_area:
		return
	for effect in pickup_area.effects:
		effect.apply(self)
