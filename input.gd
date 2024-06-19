extends MultiplayerSynchronizer

@export var input_direction := Vector2(0, 0)

func _ready():
	set_process(false)
	set_physics_process(false)
