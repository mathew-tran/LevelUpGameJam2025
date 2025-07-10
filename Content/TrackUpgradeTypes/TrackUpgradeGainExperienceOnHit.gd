extends TrackUpgradeData

class_name TrackUpgradeGainExperienceOnHit

func GetUpgradeName():
	return "Coworkers gain XP when hit"
	
func ApplyUpgrade():
	Finder.GetGame().bGainExperienceOnHit = true
