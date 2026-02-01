extends Node3D


@onready var _bullet_spawner: Spawner3D = $BulletSpawner
@onready var _bullet_timer: Timer = $BulletTimer


func set_shooting(value: bool) -> void:
	if value:
		_bullet_timer.start()
	else:
		_bullet_timer.stop()


func _on_bullet_timer_timeout() -> void:
	_bullet_spawner.spawn()
