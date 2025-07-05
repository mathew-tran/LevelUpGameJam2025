extends CharacterUpgradeData

class_name CharacterUpgradeTeamHealth
@export var Amount = 10.0

func GetUpgradeName():
	return "Increase team health by " + str(Amount) + "%"
	
func ApplyUpgrade(char : BaseCharacter):
	Finder.GetGame().SubStatTeamHealth.Get().IncreaseValue(float(Amount)/100.0, StatResourceData.SCALE_TYPE.ADDITIVE, resource_path)
	
func RemoveUpgrade(char : BaseCharacter):
	Finder.GetGame().SubStatTeamHealth.Get().Undo(resource_path)
