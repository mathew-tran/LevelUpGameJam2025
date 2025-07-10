extends TrackUpgradeData

class_name TrackUpgradeBaseTeamContactDamage
@export var Amount = 10.0

func GetUpgradeName():
	return "Increase contact damage by " + str(Amount) + "%"
	
func ApplyUpgrade():
	Finder.GetGame().SubStatTeamContactDamage.Get().IncreaseValue(float(Amount)/100.0, StatResourceData.SCALE_TYPE.ADDITIVE, resource_path)
	
