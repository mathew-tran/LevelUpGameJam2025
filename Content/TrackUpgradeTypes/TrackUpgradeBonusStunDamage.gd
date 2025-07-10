extends TrackUpgradeData

class_name TrackUpgradeStunExtraDamage

func GetUpgradeName():
	return "Stunned enemies take extra damage"
	
func ApplyUpgrade():
	Finder.GetGame().bStunExtraDamage
