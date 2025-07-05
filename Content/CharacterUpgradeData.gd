extends Resource

class_name CharacterUpgradeData 

func GetUpgradeName():
	return ""
	
func Apply(char : BaseCharacter):
	ApplyUpgrade(char)
	char.CharacterLevel += 1
	
func Remove(char : BaseCharacter):
	RemoveUpgrade(char)
	pass
	
func ApplyUpgrade(char : BaseCharacter):
	pass
	
func RemoveUpgrade(char : BaseCharacter):
	pass
