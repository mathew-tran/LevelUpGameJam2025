extends CharacterUpgradeData

class_name CharacterUpgradeBaseAttackRateData 
@export var AttackRateIncrease = 10.0

func GetUpgradeName():
	return "Increase base attack rate by " + str(AttackRateIncrease)  + "%"
	
func ApplyUpgrade(char : BaseCharacter):
	char.SubStatAttackRate.Get().IncreaseValue(float(AttackRateIncrease)/100.0, StatResourceData.SCALE_TYPE.ADDITIVE, resource_path)
	
func RemoveUpgrade(char : BaseCharacter):
	char.SubStatAttackRate.Get().Undo(resource_path)
