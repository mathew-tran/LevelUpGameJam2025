extends TrackUpgradeData

class_name TrackUpgradeFreeReroll

func GetUpgradeName():
	return "First reroll per level up costs 0"
	
func ApplyUpgrade():
	Finder.GetRerollButton().DefaultCost = 0
