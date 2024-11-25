extends ProgressBar

@export var wait_time: int

@onready var timer: Timer = $Timer

var is_hability_on_cooldown: bool = false

func _ready() -> void:
	timer.set_wait_time(wait_time)
	max_value = timer.wait_time
	set_process(false)

func _process(_delta: float) -> void:
	value = timer.time_left

func hability_casted() -> void:
	is_hability_on_cooldown = true
	visible = true
	timer.start()
	set_process(true)

func _on_timer_timeout() -> void:
	is_hability_on_cooldown = false
	visible = false
	set_process(false)
