extends AnimatedSprite3D


@onready var _sound: AudioStreamPlayer = $Sound


func _on_frame_changed() -> void:
	if frame == 1:
		_sound.play()
