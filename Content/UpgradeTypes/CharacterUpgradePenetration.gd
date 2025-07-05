extends CharacterUpgradeData

class_name CharacterUpgradePenetration
@export var Penetration = 1

func GetUpgradeName():
	return "Increase projectile penetration by " + str(Penetration)
	
func ApplyUpgrade(char : BaseCharacter):
	char.Penetration += 1
func RemoveUpgrade(char : BaseCharacter):
	char.SubStatAttackRate.Get().Undo(resource_path)
