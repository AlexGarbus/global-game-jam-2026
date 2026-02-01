extends Node


@export var _player: RigidBody3D

var _failures: Array[AudioStreamPlayer]

@onready var _car := $Car
@onready var _horse := $Horse
@onready var _jet := $Jet
@onready var _scream := $Scream
@onready var _shoot := $Shoot
@onready var _super := $Super


func _ready() -> void:
	_failures = [$Failure1, $Failure2]


func _play_collision_audio(body: Node) -> void:
	var children := body.find_children("*", "EnemyStats")
	if children.is_empty():
		_failures.pick_random().play()
		return
	var enemy_stats := body.find_children("*", "EnemyStats")[0] as EnemyStats
	match enemy_stats.type:
		Enum.EnemyType.CAR:
			_car.play()
		Enum.EnemyType.HORSE:
			_horse.play()
		Enum.EnemyType.JET:
			_jet.play()


func _on_health_reached_zero() -> void:
	_scream.play()


func _on_bullet_spawner_spawned() -> void:
	_shoot.play()


func _on_player_super_changed(value: bool) -> void:
	if value:
		_super.play()


func _on_damage_area_3d_body_entered(body: Node3D) -> void:
	_play_collision_audio(body)


func _on_player_body_entered(body: Node) -> void:
	if not _player.custom_integrator:
		_play_collision_audio(body)
