extends Pickup

class_name MagnetPickup


func Setup():
	_on_poll_timer_timeout()

func DoPickupAction():
	Jukebox.PlayPickupSFX()
	for pickup in Finder.GetPickupGroup().get_children():
		if pickup is Pickup:
			pickup.SetFollowing()
