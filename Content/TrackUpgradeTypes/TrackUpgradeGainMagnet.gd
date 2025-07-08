extends TrackUpgradeData

class_name TrackUpgradeGainMagnet

func GetUpgradeName():
	return "Enemies have a chance to drop a magnet"
	
func ApplyUpgrade():
	Finder.GetGame().bCanDropMagnet = true
