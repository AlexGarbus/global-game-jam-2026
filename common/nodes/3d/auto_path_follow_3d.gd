class_name AutoPathFollow3D
extends PathFollow3D


@export_range(0, 1, 0.001, "or_greater", "hide_slider", "suffix:m/s")
var speed := 1.0
@export_range(0, 1, 0.001, "or_greater", "hide_slider", "suffix:s")
var wait_interval := 0.0
@export var ping_pong := false
@export var ease := false


func _ready() -> void:
	var path: Path3D = get_parent() as Path3D
	if path:
		_create_tween(path.curve.get_baked_length() / speed)
	else:
		printerr("Parent Path3D node not found!")


func _create_tween(duration: float) -> void:
	var from := progress_ratio
	var to := progress_ratio + 1 if progress_ratio < 1 else progress_ratio - 1
	var tween = create_tween().set_loops()
	tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	if ease:
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.set_trans(Tween.TRANS_SINE)
	_append_progress_ratio_tweener(tween, from, to, duration)
	if ping_pong:
		_append_progress_ratio_tweener(tween, to, from, duration)


func _append_progress_ratio_tweener(
	tween: Tween, from: float, to: float, duration: float
) -> void:
	tween.tween_property(
		self,
		"progress_ratio",
		to,
		duration
	).from(from).set_delay(wait_interval)
