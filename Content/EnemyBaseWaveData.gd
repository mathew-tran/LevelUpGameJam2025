extends Resource

class_name EnemyBaseWaveData

enum WAVE_TYPE {
	CIRCLE_AROUND_PLAYER,
	RANDOM_BIG_CLUMP,
	LEFT_AND_RIGHT,
	UP_AND_DOWN,
	CORNERS,
	SCATTER
}
	
func MakeSpawnPositions(amount, waveType):
	var positions = []
	var playerPosition = Finder.GetPlayer().GetPlayerPosition()
	match waveType:
		WAVE_TYPE.CIRCLE_AROUND_PLAYER:
			var degree = 360.0/amount
			for x in range(0, amount):
				positions.append(Helper.GetPositionAroundPoint(playerPosition, 800,
				degree * x))
		WAVE_TYPE.RANDOM_BIG_CLUMP:
			var pos = Helper.GetRandomPositionAroundPoint(playerPosition, 800)
			var degree = 360.0/amount
			for x in range(0, amount):
				positions.append(Helper.GetPositionAroundPoint(pos, 20,
				degree * x))
		WAVE_TYPE.LEFT_AND_RIGHT:
			var pos = Helper.GetPositionAroundPoint(playerPosition, 800, 0)
			var leftAmount = floor(amount / 2)
			var rightAmount = amount - leftAmount
			
			for x in range(0, leftAmount):
				positions.append(pos)
				
			pos = Helper.GetPositionAroundPoint(playerPosition, 800, 180)
			
			for x in range(0, rightAmount):
				positions.append(pos)
		WAVE_TYPE.UP_AND_DOWN:
			var pos = Helper.GetPositionAroundPoint(playerPosition, 800, 90)
			var upAmount = floor(amount / 2)
			var downAmount = amount - upAmount
			
			for x in range(0, upAmount):
				positions.append(pos)
				
			pos = Helper.GetPositionAroundPoint(playerPosition, 800, 270)
			
			for x in range(0, downAmount):
				positions.append(pos)
				
		WAVE_TYPE.CORNERS:
			var split = [45, 135, 225, 315]
			for x in split:
				var amountToSpawn = (amount / 4) + 1
				for pos in amountToSpawn:
					var deg = x
					var cornerPos = Helper.GetPositionAroundPoint(playerPosition, 800, deg)
					positions.append(cornerPos)
				
		WAVE_TYPE.SCATTER:
			for x in range(0, amount):
				var pos = Helper.GetRandomPositionAroundPoint(playerPosition, 800)
				positions.append(pos)
	return positions
	
func CanContinue():
	return true

func GetWaveText():
	return ""
