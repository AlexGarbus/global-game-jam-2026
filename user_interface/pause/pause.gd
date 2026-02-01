extends Control


signal fullscreen_toggled(toggled_on: bool)
signal quit_pressed

@export var _default_main_button: BaseButton
@export var _default_credits_button: BaseButton

@onready var _main_screen := %MainScreen
@onready var _credits_screen := %CreditsScreen


func _ready() -> void:
	var fullscreen := DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
	%FullscreenButton.set_pressed_no_signal(fullscreen)
	set_visibility(false)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		set_visibility(not visible)


func set_visibility(value: bool) -> void:
	visible = value
	get_tree().paused = value
	if value:
		_default_main_button.call_deferred("grab_focus")
	else:
		_main_screen.show()
		_credits_screen.hide()


func _on_resume_button_pressed() -> void:
	set_visibility(false)


func _on_fullscreen_button_toggled(toggled_on: bool) -> void:
	fullscreen_toggled.emit(toggled_on)


func _on_credits_button_pressed() -> void:
	_main_screen.hide()
	_credits_screen.show()
	_default_credits_button.call_deferred("grab_focus")


func _on_quit_button_pressed() -> void:
	quit_pressed.emit()


func _on_credits_back_button_pressed() -> void:
	_main_screen.show()
	_credits_screen.hide()
	_default_main_button.call_deferred("grab_focus")
