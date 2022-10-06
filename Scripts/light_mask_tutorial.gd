extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var camera: Camera2D = $Camera2d
@onready var tile_map: TileMap = $TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	camera.position = player.position
	var tilemap_shader = tile_map.material as ShaderMaterial
	tilemap_shader.set_shader_parameter("screen_start", camera.get_canvas_transform().get_origin())
	tilemap_shader.set_shader_parameter("screen_size", get_viewport().size / 1)
	tilemap_shader.set_shader_parameter("tilemap_size", tile_map.get_used_rect().size * tile_map.tile_set.tile_size)
	var tilemap_rect = tile_map.get_viewport_rect()
	tilemap_rect.position += camera.get_canvas_transform().get_origin()
	# print("Tilemap rect: {0}".format([tilemap_rect]))
	# print("Screen start: {0}".format([camera.get_canvas_transform().get_origin()]))
	# print("Tilemap size: {0}".format([tile_map.get_used_rect().size * tile_map.tile_set.tile_size]))
	tilemap_shader.set_shader_parameter("tilemap_start", tile_map.position)

func _input(event):
	if event is InputEventKey:
		if event.keycode == KEY_ESCAPE:
			get_tree().quit()
		if event.is_pressed() and event.keycode == KEY_SPACE:
			tile_map.visible = !tile_map.visible
