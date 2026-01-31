extends MainScene


func _on_game_over_animation_finished() -> void:
	finished.emit(false)
