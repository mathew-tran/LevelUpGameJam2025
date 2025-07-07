extends Node

func GetAllFilePaths(path: String) -> Array[String]:
	var file_paths: Array[String] = []
	var dir = DirAccess.open(path)
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		file_name = file_name.trim_suffix('.remap')
		var file_path = path + "/" + file_name
		if dir.current_is_dir():
			file_paths += GetAllFilePaths(file_path)
		else:
			file_paths.append(file_path)
		file_name = dir.get_next()
	return file_paths

func DropEXPOrb(amount, position):
	var instance = load("res://Prefabs/Pickups/EXP.tscn").instantiate()
	instance.global_position = position
	instance.Amount = amount
	Finder.GetPickupGroup().call_deferred("add_child", instance)

func GetRandomPositionAroundPoint(pos, distance):
	var direction = Vector2.RIGHT
	return pos + direction.rotated(randf_range(0, 360)) * distance
	
func GetPositionAroundPoint(pos, distance, rotation):
	var direction = Vector2.LEFT
	return pos + direction.rotated(deg_to_rad(rotation)) * distance
			
