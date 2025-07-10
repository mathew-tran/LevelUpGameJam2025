extends TrackUpgradeData

class_name TrackUpgradeGainHealthOnMoneyPickup

func GetUpgradeName():
	return "Coworkers gain some health back after picking up money"
	
func ApplyUpgrade():
	Finder.GetGame().bGainHealthWhenMoneyPickedUp = true
