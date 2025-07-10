extends TrackUpgradeData

class_name TrackUpgradeStunChance

func GetUpgradeName():
	return "Coworkers all have a small chance to stun enemies"
	
func ApplyUpgrade():
	Finder.GetGame().bStunChance = true
