extends StaticBody3D


@export var inventory: Inventory


func _ready() -> void:
	hide()
	inventory.all_gems_collected.connect(_on_all_gems_collected)


func _on_player_detection_body_entered(body: Node3D) -> void:
	show()


func _on_all_gems_collected() -> void:
	var children := find_children("*", "CollisionShape3D")
	for child in children:
		(child as CollisionShape3D).disabled = true
