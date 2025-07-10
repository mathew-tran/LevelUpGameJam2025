extends TrackUpgradeData

class_name TrackUpgradeGainBonusDamage

func GetUpgradeName():
	return "Projectiles have a chance to deal crit damage"
	
func ApplyUpgrade():
	Finder.GetGame().bBonusDamage = true
