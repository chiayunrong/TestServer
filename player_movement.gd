extends CharacterBody2D

const SPEED = 400

var player_id := 1:
	set(id):
		player_id = id

func _enter_tree():
	$InputSynchronizer.set_multiplayer_authority(player_id)
		
func _ready():
	$Camera2D.enabled = false

func _physics_process(delta):
	var direction = $InputSynchronizer.input_direction 
	velocity = direction * SPEED
	move_and_slide()
