extends Node


@export var main_scenes: Array[PackedScene]

var _current_scene_index := 0
var _current_scene_instance: MainScene


func _ready() -> void:
	change_scene()


func change_scene(advance := false) -> void:
	if _current_scene_instance:
		_current_scene_instance.queue_free()
	if advance:
		_current_scene_index = wrapi(_current_scene_index + 1, 0, main_scenes.size())
	_current_scene_instance = main_scenes[_current_scene_index].instantiate() as MainScene
	if not _current_scene_instance:
		push_error("Instance is not of type MainScene.")
		return
	add_child(_current_scene_instance)
	_current_scene_instance.finished.connect(_on_scene_finished)


func _on_scene_finished(advance: bool) -> void:
	change_scene(advance)


func _on_pause_fullscreen_toggled(toggled_on: bool) -> void:
	var window_mode := DisplayServer.WINDOW_MODE_FULLSCREEN if toggled_on else DisplayServer.WINDOW_MODE_WINDOWED
	DisplayServer.window_set_mode(window_mode)


func _on_pause_quit_pressed() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
