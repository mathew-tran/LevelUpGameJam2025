extends Resource

class_name SubStatResourceData


@export var FlatValue = 0
@export var StatResourceRef : Resource

var ModifiedResource : StatResourceData

func MakeNewResource(resource):
	var stat = resource
	stat = stat.duplicate(true)
	stat.FlatValue += FlatValue
	return stat
	
func Init():
	ModifiedResource = MakeNewResource(StatResourceRef)
	print("------------------------------- MAKE NEW STAT: " + StatResourceRef.resource_path)
	
func Get():
	return ModifiedResource
