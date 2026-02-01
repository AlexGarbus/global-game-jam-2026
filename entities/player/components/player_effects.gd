extends Node


@onready var _baby_spawner: Spawner3D = $"../BabySpawner"
@onready var _baby_timer: Timer = $BabyTimer
@onready var _defeat_timer: Timer = $DefeatTimer
@onready var _explosion: AnimatedSprite3D = $"../Explosion"
@onready var _flame: AnimatedSprite3D = $"../Flame"


func _ready() -> void:
	_explosion.hide()
	_explosion.stop()
	_flame.hide()
	_flame.stop()


func _on_health_reached_zero() -> void:
	_baby_timer.start()
	_defeat_timer.start()


func _on_defeat_timer_timeout() -> void:
	_explosion.show()
	_explosion.play()
	_flame.show()
	_flame.play()


func _on_baby_timer_timeout() -> void:
	_baby_spawner.spawn()
