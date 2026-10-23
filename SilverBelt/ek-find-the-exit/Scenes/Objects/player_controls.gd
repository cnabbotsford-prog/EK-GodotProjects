extends RigidBody3D

@export var move_speed: float = 10.0
@export var turn_rate: float = 0.1

@onready var anim_player: AnimationPlayer = get_node("Run")

func _physics_process(delta: float) -> void:
	#global_position += Vector3.FORWARD * global_basis * move_speed * delta
	#linear_velocity = Vector3.FORWARD * move_speed
	var horizontal: float = Input.get_axis("move_left", "move_right")
	var vertical: float = Input.get_axis("move_up", "move_down")
	var input_dir = Vector3(horizontal, 0, vertical) 
	linear_velocity = input_dir.normalized() * move_speed
	
	if input_dir != Vector3.ZERO:
		anim_player.play("Run")
		var target_angle: float = atan2(input_dir.x, input_dir.z)
		rotation.y = lerp_angle(rotation.y, target_angle, turn_rate)
	else:
		anim_player.stop()
