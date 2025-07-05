extends Resource

class_name StatResourceData

@export var FlatValue = 0.0
var PercentageIncrease = 1.0
var MultiplicationIncrease = 1.0

@export var MaxClampValue = -1.0
@export var MinClampValue = -1.0

@export var PostPend = ""

var GoodUpdates = [
	
]
var BadUpdates = [
]

enum SCALE_TYPE {
	LINEAR,
	ADDITIVE,
	MULTIPLICATIVE
}

signal ValueUpdated(newValue)


func GetPrettyStatString():
	return str(GetValue()) + PostPend
	
func GetValue():
	var value = ((FlatValue) * PercentageIncrease) * MultiplicationIncrease
	if MinClampValue != -1.0:
		if value < MinClampValue:
			value = MinClampValue
	if MaxClampValue != -1.0:
		if value > MaxClampValue:
			value = MaxClampValue
	
	return value
	
func IncreaseValue(amount, scaleType = SCALE_TYPE.LINEAR, reasoning = "", bIsTemp = false, waitTime = 1.0, texture = null):
	if amount == 0:
		return
		
	var prettyAmount = ""
	
	var newAmount = amount
	var index = -1
	var stacks = 1
	if amount >= 0:
		for x in range(0, len(GoodUpdates)):
			if GoodUpdates[x].Reason == reasoning:
				newAmount = GoodUpdates[x].Amount + amount
				stacks = GoodUpdates[x].Stacks + 1
				index = x

	else:
		for x in range(0, len(BadUpdates)):
			if BadUpdates[x].Reason == reasoning:
				newAmount = BadUpdates[x].Amount + amount
				stacks = GoodUpdates[x].Stacks + 1
				index = x
		
	if amount > 0:
		prettyAmount += "+"
		
	match scaleType:
		SCALE_TYPE.LINEAR:
			FlatValue += amount
			prettyAmount += str(newAmount)
		SCALE_TYPE.ADDITIVE:
			PercentageIncrease += amount
			prettyAmount += str(newAmount * 100)
		SCALE_TYPE.MULTIPLICATIVE:
			MultiplicationIncrease += amount
			prettyAmount += str(newAmount)
			
	match scaleType:
		SCALE_TYPE.ADDITIVE:
			prettyAmount += "%"
			
	if stacks > 1:
		prettyAmount += " (x" +  str(stacks) + ")"
			
	var data = {
		"Reason" : reasoning,
		"Amount" : newAmount,
		"ScaleType" : scaleType,
		"PrettyAmount" : prettyAmount,
		"Stacks" : stacks
	}

	if bIsTemp:
		data["Reason"] += "(TEMP)"
			

	if amount >= 0:
		if index != -1:
			GoodUpdates[index] = data
		else:
			GoodUpdates.append(data)
	else:
		if index != -1:
			BadUpdates[index] = data
		else:
			BadUpdates.append(data)

	ValueUpdated.emit(GetValue())

#internal
func ClearUpdate(updateToClear, updateList):
	var updateToDelete = null
	for x in range(0, len(updateList)):
		if updateList[x] == updateToClear:
			match updateList[x].ScaleType:
				SCALE_TYPE.LINEAR:
					FlatValue += -updateList[x].Amount
				SCALE_TYPE.ADDITIVE:
					PercentageIncrease += -updateList[x].Amount
				SCALE_TYPE.MULTIPLICATIVE:
					MultiplicationIncrease += -updateList[x].Amount		
			updateToDelete = updateList[x]
			print(updateToDelete.Reason + "erased")
	
	if updateToDelete:
		updateList.erase(updateToDelete)
			
func Undo(reasoning):
	for update in GoodUpdates:
		if update.Reason == reasoning:
			ClearUpdate(update, GoodUpdates)
			
	for update in BadUpdates:
		if update.Reason == reasoning:
			ClearUpdate(update, BadUpdates)
		
	ValueUpdated.emit(GetValue())
