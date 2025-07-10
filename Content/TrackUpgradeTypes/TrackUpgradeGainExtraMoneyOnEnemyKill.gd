extends TrackUpgradeData

class_name TrackUpgradeGainExtraCashDrops

func GetUpgradeName():
	return "Enemies have a chance of doubling their cash drops when dying"
	
func ApplyUpgrade():
	Finder.GetGame().bExtraMoneyDrop = true
