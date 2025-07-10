extends HBoxContainer

func _ready() -> void:
	Finder.GetGame().OnEnemiesKilled.connect(OnEnemiesKilled)
	OnEnemiesKilled()
	
func OnEnemiesKilled():
	var amountKilled = Finder.GetGame().EnemiesKilled
	$Label.text = str(Finder.GetGame().EnemiesKilled)
	$AnimationPlayer.play("anim")

	if Finder.GetGame().bBerserkModeActive:
		ApplyBuffToRandomWorker(amountKilled, load("res://Prefabs/Buffs/BerserkerBuff.tscn"), 100)
	
	if Finder.GetGame().bInvincibleModeActive:
		ApplyBuffToRandomWorker(amountKilled, load("res://Prefabs/Buffs/InvincibleBuff.tscn"), 150)
		
	if Finder.GetGame().bDoubleDamageModeActive:
		ApplyBuffToRandomWorker(amountKilled, load("res://Prefabs/Buffs/DamageBuff.tscn"), 200)
		
	if Finder.GetGame().bStunModeActive:
		ApplyBuffToRandomWorker(amountKilled, load("res://Prefabs/Buffs/StunBuff.tscn"), 125)
		
func ApplyBuffToRandomWorker(amount, bufScene, killCount):
	if amount != 0 and amount % killCount == 0:
		var childToChoose = null
		var workers = Finder.GetWorkerGroup().get_children()
		workers.shuffle()
		for worker in workers:
			if is_instance_valid(worker):
				childToChoose = worker
				break
				
		if childToChoose:
			var buff = bufScene.instantiate()
			childToChoose.GetBuffsHolder().add_child(buff)
			buff.ApplyBuff(childToChoose)
	
