extends TrackUpgradeData

class_name TrackUpgradeGainShootOnAttacked

func GetUpgradeName():
	return "Coworkers may attack when hurt"
	
func ApplyUpgrade():
	Finder.GetGame().bShootOnHurt = true
