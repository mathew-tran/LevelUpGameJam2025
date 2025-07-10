extends TrackUpgradeData

class_name TrackUpgradeStunMode

func GetUpgradeName():
	return "Every 125 kills a random coworker gains stunning powers"
	
func ApplyUpgrade():
	Finder.GetGame().bStunModeActive = true
