extends ProgressBar


var health: Health: set = set_health


func set_health(new_health: Health) -> void:
	health = new_health
	if health:
		value = health.get_ratio()
		health.changed.connect(_on_health_changed)


func _on_health_changed(_old_value: int, _new_value: int) -> void:
	value = health.get_ratio()
