extends Pickup

class_name MagnetPickup


func Setup():
	_on_poll_timer_timeout()
	scale = Vector2.ONE

func DoPickupAction():
	GameData.AddData("Magnets Picked up", 1)
	Jukebox.PlayPickupSFX()
	for pickup in Finder.GetPickupGroup().get_children():
		if pickup is Pickup:
			pickup.SetFollowing()
