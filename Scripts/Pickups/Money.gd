extends Pickup

class_name MoneyPickup
@export var Amount = 1

func Setup():
	_on_poll_timer_timeout()
	scale = Vector2.ONE * lerp(1,4, clamp(Amount, 1, 20)/20)
	
func DoPickupAction():
	Finder.GetGame().AddMoney(Amount)
	Jukebox.PlayPickupSFX()
	if Finder.GetGame().bGainHealthWhenMoneyPickedUp:
		for worker in Finder.GetWorkerGroup().get_children():
			worker.Heal(2)
