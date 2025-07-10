extends TrackUpgradeData

class_name TrackUpgradeTeamSize

func GetUpgradeName():
	return "Increase team max size by 1"
	
func ApplyUpgrade():
	Finder.GetLevelUp().IncreaseCharacterAmount()
	
