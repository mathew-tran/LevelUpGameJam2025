extends CharacterUpgradeData

class_name CharacterUpgradeTeamSpeed
@export var Amount = 10.0

func GetUpgradeName():
	return "Increase movement speed by " + str(Amount) + "%"
	
func ApplyUpgrade(char : BaseCharacter):
	Finder.GetGame().SubStateTeamSpeed.Get().IncreaseValue(float(Amount)/100.0, StatResourceData.SCALE_TYPE.ADDITIVE, resource_path)
	
func RemoveUpgrade(char : BaseCharacter):
	Finder.GetGame().SubStateTeamSpeed.Get().Undo(resource_path)
