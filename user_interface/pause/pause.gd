extends Control


signal fullscreen_toggled(toggled_on: bool)
signal quit_pressed

@export var _default_button: BaseButton


func _ready() -> void:
	var fullscreen := DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
	%FullscreenButton.set_pressed_no_signal(fullscreen)
	hide()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		set_visibility(not visible)


func set_visibility(value: bool) -> void:
	visible = value
	get_tree().paused = value
	if value:
		_default_button.call_deferred("grab_focus")


func _on_resume_button_pressed() -> void:
	set_visibility(false)


func _on_fullscreen_button_toggled(toggled_on: bool) -> void:
	fullscreen_toggled.emit(toggled_on)


func _on_quit_button_pressed() -> void:
	quit_pressed.emit()
