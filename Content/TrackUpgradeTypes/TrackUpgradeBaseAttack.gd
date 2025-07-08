extends TrackUpgradeData

class_name TrackUpgradeBaseAttackData 
@export var Amount = 10.0

func GetUpgradeName():
	return "Increase all projectile damage by " + str(Amount) + "%"
	
func ApplyUpgrade():
	Finder.GetGame().SubStatTeamDamage.Get().IncreaseValue(float(Amount)/100.0, StatResourceData.SCALE_TYPE.ADDITIVE, resource_path)
	
