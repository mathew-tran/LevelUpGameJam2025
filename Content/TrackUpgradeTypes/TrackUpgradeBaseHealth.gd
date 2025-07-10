extends TrackUpgradeData

class_name TrackUpgradeBaseHealth
@export var Amount = 10.0

func GetUpgradeName():
	return "Increase team health by " + str(Amount) + "%"
	
func ApplyUpgrade():
	Finder.GetGame().SubStatTeamHealth.Get().IncreaseValue(float(Amount)/100.0, StatResourceData.SCALE_TYPE.ADDITIVE, resource_path)
	
