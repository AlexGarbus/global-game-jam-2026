extends Control


signal animation_finished

const Player := preload("uid://covk2281f0gro")

@export var _player: Player

@onready var _anim: AnimationPlayer = $AnimationPlayer
@onready var _wait_timer: Timer = $WaitTimer


func _ready() -> void:
	hide()
	await get_tree().process_frame
	var health: Health = _player.health
	health.reached_zero.connect(_on_player_health_reached_zero)


func _on_player_health_reached_zero() -> void:
	_wait_timer.start()


func _on_wait_timer_timeout() -> void:
	show()
	_anim.play("animation")


func _on_animation_finished(_anim_name: StringName) -> void:
	animation_finished.emit()
