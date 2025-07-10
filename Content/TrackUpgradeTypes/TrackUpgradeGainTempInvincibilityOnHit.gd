extends TrackUpgradeData

class_name TrackUpgradeGainTempInvincibilityOnHit

func GetUpgradeName():
	return "Coworkers have a small chance to gain invincibility after getting hit"
	
func ApplyUpgrade():
	Finder.GetGame().bInvulnerabilityChance = true
