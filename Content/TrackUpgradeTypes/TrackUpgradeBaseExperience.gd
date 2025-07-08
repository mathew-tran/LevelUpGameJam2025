extends TrackUpgradeData

class_name TrackUpgradeBaseExperienceData
@export var Amount = 10.0

func GetUpgradeName():
	return "Increase all experience gained by " + str(Amount) + "%"
	
func ApplyUpgrade():
	Finder.GetGame().SubStatTeamExperience.Get().IncreaseValue(float(Amount)/100.0, StatResourceData.SCALE_TYPE.ADDITIVE, resource_path)
	
