extends TrackUpgradeData

class_name TrackUpgradeBasePickupRadius
@export var Amount = 10.0

func GetUpgradeName():
	return "Increase pickup radius by " + str(Amount) + "%"
	
func ApplyUpgrade():
	Finder.GetGame().SubStatPickupRadius.Get().IncreaseValue(float(Amount)/100.0, StatResourceData.SCALE_TYPE.ADDITIVE, resource_path)
	
