extends TrackUpgradeData

class_name TrackUpgradeExtraMoneyOnSkip

func GetUpgradeName():
	return "Gain 1 more dollar when skipping"
	
func ApplyUpgrade():
	Finder.GetGame().bExtraMoneyOnSkip = true
