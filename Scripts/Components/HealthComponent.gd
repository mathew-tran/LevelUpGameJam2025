extends Node

class_name HealthComponent

@export var MaxHealth = 10
var CurrentHealth = 3

signal OnTakeDamage(amount)
signal OnDeath
signal OnSetup

enum STATE {
	ALIVE,
	DEAD
}

var CurrentState = STATE.ALIVE

var bDisabled = false

func Enable():
	bDisabled = false
	
func Disable():
	bDisabled = true
	
func _ready() -> void:
	Setup()
	
func Setup():
	CurrentHealth = MaxHealth	
	CurrentState = STATE.ALIVE
	
	await get_tree().process_frame
	OnSetup.emit()
	
func SetHealth():
	CurrentHealth = MaxHealth
	
func Heal(amount):
	if CurrentState == STATE.DEAD:
		return
		
	CurrentHealth += amount
	
	
	if CurrentHealth > MaxHealth:
		CurrentHealth = MaxHealth
	OnTakeDamage.emit(0)
	
func TakeDamage(amount):
	if bDisabled:
		return
	CurrentHealth -= amount
	OnTakeDamage.emit(amount)
	
	if CurrentHealth <= 0:
		if CurrentState == STATE.DEAD:
			return
		OnDeath.emit()
		CurrentState = STATE.DEAD
	
func IsAlive():
	return CurrentState == STATE.ALIVE
