extends CharacterUpgradeData

class_name CharacterUpgradeSpread
@export var Spread = 1

func GetUpgradeName():
	return "Increase projectile amount by " + str(Spread)
	
func ApplyUpgrade(char : BaseCharacter):
	char.Spread += Spread
func RemoveUpgrade(char : BaseCharacter):
	char.Spread -= Spread
