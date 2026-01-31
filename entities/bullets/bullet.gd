extends Node3D


@export_range(0.0, 5.0, 0.1, "or_greater", "hide_control", "suffix:m/s") var move_speed := 5.0
@export var move_direction := Vector3.FORWARD


func _physics_process(delta: float) -> void:
	translate_object_local(move_direction * move_speed * delta)


func _on_attack_area_3d_area_entered(_area: Area3D) -> void:
	queue_free()


func _on_attack_area_3d_body_entered(_body: Node3D) -> void:
	queue_free()


func _on_life_timer_timeout() -> void:
	queue_free()
