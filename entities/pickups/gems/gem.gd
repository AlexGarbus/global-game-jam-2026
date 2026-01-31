@tool
extends PickupArea


@export var type: Enum.GemType: set = set_gem_type
@export var mesh_colors: GemColors


func set_gem_type(value: Enum.GemType) -> void:
	type = value
	_update_materials()


func _update_materials() -> void:
	var children := find_children("*", "MeshInstance3D")
	for child in children:
		var mesh_instance := child as MeshInstance3D
		if not mesh_instance:
			return
		var material := mesh_instance.mesh.surface_get_material(0) as BaseMaterial3D
		if not material:
			return
		material = material.duplicate()
		material.albedo_color = mesh_colors.colors[type]
		mesh_instance.set_surface_override_material(0, material)
		mesh_instance.mesh.surface_set_material(0, material)
