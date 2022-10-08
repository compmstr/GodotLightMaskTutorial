extends Node2D

@onready var player: CharacterBody2D = $LitView/Player
@onready var camera: Camera2D = $Camera2d
@onready var tile_map: TileMap = $TileMap

@onready var masked_view: TileMap = $MaskedView

@onready var vis_view: SubViewport = $VisibilityViewport

func _on_viewport_size_change():
	var new_size = get_viewport().size
	vis_view.size = new_size

# Called when the node enters the scene tree for the first time.
func _ready():
	get_viewport().connect("size_changed", self._on_viewport_size_change)
	pass # Replace with function body.

func update_mask_shader():
	var tm_screen_start = get_viewport_transform() * (tile_map.get_global_transform() * Vector2(tile_map.get_used_rect().position))
	var tm_screen_end = get_viewport_transform() * (tile_map.get_global_transform() * Vector2(tile_map.get_used_rect().end * tile_map.tile_set.tile_size))
	var screen_rect = get_viewport_transform() * get_viewport_rect()
	var sm = masked_view.material as ShaderMaterial
	sm.set_shader_parameter("screen_start", screen_rect.position)
	sm.set_shader_parameter("screen_size", screen_rect.size)
	sm.set_shader_parameter("tilemap_start", tm_screen_start)
	sm.set_shader_parameter("mask_size", get_viewport_transform().get_scale() * Vector2(vis_view.size))
	# print("ss: {0} & {1}\ntm: {2} & {3}".format([screen_rect.position, screen_rect.size, tm_screen_start, tm_screen_end - tm_screen_start]))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	camera.position = player.position
	update_mask_shader()


func _input(event):
	if event is InputEventKey:
		if event.keycode == KEY_ESCAPE:
			get_tree().quit()
		if event.is_pressed() and event.keycode == KEY_SPACE:
			tile_map.visible = !tile_map.visible
