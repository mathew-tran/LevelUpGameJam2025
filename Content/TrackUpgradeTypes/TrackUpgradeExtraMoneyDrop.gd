extends TrackUpgradeData

class_name TrackUpgradeGainExtraCashDrop

func GetUpgradeName():
	return "Bouncy projectiles will be bounce an additional time"
	
func ApplyUpgrade():
	Finder.GetGame().bExtraBounce = true
