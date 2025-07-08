extends TrackUpgradeData

class_name TrackUpgradeGainExplodeOnDeath

func GetUpgradeName():
	return "Coworkers will attack before resigning"
	
func ApplyUpgrade():
	Finder.GetGame().bExplodeOnDeath = true
