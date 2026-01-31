extends StaticBody3D


@onready var _bullet_spawner := $BulletSpawner


func _on_bullet_timer_timeout() -> void:
	_bullet_spawner.spawn()
