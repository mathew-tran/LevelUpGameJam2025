extends CharacterUpgradeData

class_name CharacterUpgradeBaseAttackData 
@export var Amount = 3

func GetUpgradeName():
	return "Increase base attack by " + str(Amount) 
	
func ApplyUpgrade(char : BaseCharacter):
	char.Damage += Amount
	
func RemoveUpgrade(char : BaseCharacter):
	char.Damage -= Amount
