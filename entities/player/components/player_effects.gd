extends Node


@onready var _explosion: AnimatedSprite3D = $"../Explosion"
@onready var _flame: AnimatedSprite3D = $"../Flame"
@onready var _defeat_timer: Timer = $DefeatTimer


func _ready() -> void:
	_explosion.hide()
	_flame.hide()


func _on_health_reached_zero() -> void:
	_defeat_timer.start()


func _on_defeat_timer_timeout() -> void:
	_explosion.show()
	_explosion.play()
	_flame.show()
	_flame.play()
