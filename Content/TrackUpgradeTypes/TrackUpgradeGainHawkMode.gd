extends TrackUpgradeData

class_name TrackUpgradeGainHawkMode

func GetUpgradeName():
	return "Every 200 kills a random coworker gains hawk mode"
	
func ApplyUpgrade():
	Finder.GetGame().bDoubleDamageModeActive = true
