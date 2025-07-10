extends TrackUpgradeData

class_name TrackUpgradeGainSmallDodgeChance

func GetUpgradeName():
	return "Coworkers have a small chance of dodging hits"
	
func ApplyUpgrade():
	Finder.GetGame().bDodgeChance = true
