extends Area2D

signal interacted

func _ready() -> void:
	set_process_unhandled_input(false)
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _unhandled_input(event: InputEvent) -> void:
	if event. is_action_pressed("interact"):
		$DeBugLabel.text = "touch me"
		interacted.emit()


func _on_area_entered(area: Area2D) -> void:
	$DeBugLabel.text = "lá elee"
	set_process_unhandled_input(true)


func _on_area_exited(area:Area2D) -> void:
	$DeBugLabel.text = "bug"
	set_process_unhandled_input(false)
