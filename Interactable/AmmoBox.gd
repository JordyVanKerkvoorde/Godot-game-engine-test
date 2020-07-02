extends Interactable

onready var weapon = $"/root/World/Player/Weapon"

func get_interaction_text():
	return "reload ammo"

func interact():
	print("ammo interaction")
	weapon.reload_ammo()
