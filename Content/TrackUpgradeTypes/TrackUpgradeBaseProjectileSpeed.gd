extends TrackUpgradeData

class_name TrackUpgradeBaseProjectileSpeed
@export var Amount = 10.0

func GetUpgradeName():
	return "Increase coworker projectile speed by " + str(Amount) + "%"
	
func ApplyUpgrade():
	Finder.GetGame().SubStatTeamProjectileSpeed.Get().IncreaseValue(float(Amount)/100.0, StatResourceData.SCALE_TYPE.ADDITIVE, resource_path)
	
