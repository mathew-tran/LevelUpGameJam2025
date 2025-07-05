extends CharacterUpgradeData

class_name CharacterUpgradeBaseAttackData 
@export var Amount = 10.0

func GetUpgradeName():
	return "Increase base attack by " + str(Amount) + "%"
	
func ApplyUpgrade(char : BaseCharacter):
	char.SubStatDamage.Get().IncreaseValue(float(Amount)/100.0, StatResourceData.SCALE_TYPE.ADDITIVE, resource_path)
	
func RemoveUpgrade(char : BaseCharacter):
	char.SubStatDamage.Get().Undo(resource_path)
