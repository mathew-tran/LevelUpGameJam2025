extends TrackUpgradeData

class_name TrackUpgradeGainHealOnLevelup

func GetUpgradeName():
	return "Coworkers heal a bit on level up"
	
func ApplyUpgrade():
	Finder.GetGame().bHealOnLevelup = true
