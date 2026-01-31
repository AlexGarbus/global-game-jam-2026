extends CanvasLayer


signal fade_finished

const COLOR_OPAQUE := Color(1, 1, 1, 1)
const COLOR_TRANSPARENT := Color(1, 1, 1, 0)

@export_range(0.0, 5.0, 0.1, "or_greater", "hide_control", "suffix:s") var fade_time := 1.0

@onready var _canvas_modulate: CanvasModulate = $CanvasModulate


func fade_in() -> void:
	_fade_tween(COLOR_TRANSPARENT, COLOR_OPAQUE, false)


func fade_out() -> void:
	_fade_tween(COLOR_OPAQUE, COLOR_TRANSPARENT, true)


func _fade_tween(from_color: Color, to_color: Color, hide_on_finish: bool) -> void:
	show()
	_canvas_modulate.color = from_color
	var tween := create_tween()
	tween.tween_property(_canvas_modulate, "color", to_color, fade_time)
	if hide_on_finish:
		tween.tween_callback(hide)
	tween.tween_callback(fade_finished.emit)
