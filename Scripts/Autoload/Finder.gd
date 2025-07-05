extends Node

func GetBulletsGroup():
	return get_tree().get_nodes_in_group("Bullets")[0]
