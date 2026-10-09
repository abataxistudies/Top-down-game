extends CharacterBody2D

enum InputController {MOUSE, JOTSTICK}

@export var speed: float = 200
@export var light_direction: Vector2 = Vector2.RIGHT
@export var controller_style: InputController = InputController.MOUSE

@onready var flashlight: PointLight2D = $PointLight2D

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventJoypadMotion:
		controller_style = InputController.JOTSTICK
	else: controller_style =InputController.MOUSE



func _physics_process(delta: float) -> void:
	var input_dir: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_dir * speed
	move_and_slide()
	
	update_light_direction()


func _on_interactable_area_interacted() -> void:
	$PointLight2D.visible = not $PointLight2D.visible


func update_light_direction() -> void:
	match controller_style:
		InputController.MOUSE:
			var target: Vector2 = get_global_mouse_position()
			light_direction = global_position.direction_to(target)
			flashlight.rotation = light_direction.angle()
		InputController.JOTSTICK:
			light_direction = Input.get_vector("look_left","look_right","look_up","look_down").normalized()
			if light_direction.length() > 0.1:
				flashlight.rotation = light_direction.angle()
				
				
