extends TrackUpgradeData

class_name TrackUpgradeBerserkMode

func GetUpgradeName():
	return "Every 100 kills a random coworker goes beserk"
	
func ApplyUpgrade():
	Finder.GetGame().bBerserkModeActive = true
