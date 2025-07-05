extends Resource

class_name CharacterData

@export var Name = ""
@export var Occupation : DEPARTMENT
@export var Cost = 10
@export var Description = ""
@export var Picture : Texture2D

enum DEPARTMENT {
	ACCOUNTING,
	SECURITY,
	DEVELOPMENT,
	ART,
	AUDIO,
	MARKETING,
	QA
}

func GetOccupationString():
	var str = "from " + str(DEPARTMENT.keys()[Occupation])
	
