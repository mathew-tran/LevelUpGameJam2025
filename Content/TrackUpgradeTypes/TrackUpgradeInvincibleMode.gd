extends TrackUpgradeData

class_name TrackUpgradeInvincibilityMode

func GetUpgradeName():
	return "Every 150 kills a random coworker is temporarily protected"
	
func ApplyUpgrade():
	Finder.GetGame().bInvincibleModeActive = true
