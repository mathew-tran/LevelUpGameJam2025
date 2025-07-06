extends CharacterUpgradeData

class_name CharacterUpgradeBounces
@export var Bounces = 1

func GetUpgradeName():
	return "Increase projectile bounces by " + str(Bounces)
	
func ApplyUpgrade(char : BaseCharacter):
	char.Bounces += Bounces
func RemoveUpgrade(char : BaseCharacter):
	char.Bounces -= Bounces
