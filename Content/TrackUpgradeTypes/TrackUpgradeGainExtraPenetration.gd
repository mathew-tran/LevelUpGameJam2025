extends TrackUpgradeData

class_name TrackUpgradeGainExtraPenetration

func GetUpgradeName():
	return "Bullets will deal 50% more damage each time it penetrates through a target"
	
func ApplyUpgrade():
	Finder.GetGame().bExtraPenetration = true
