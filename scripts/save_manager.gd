extends Node

const _SAVE_PATH: String = "user://save_data.json"


var last_session: Dictionary = {}


func save_current_session(current_session: Dictionary) -> void:
	var file = FileAccess.open(_SAVE_PATH, FileAccess.WRITE)
	if file == null:
		return
	file.store_string(JSON.stringify(current_session))
	file.close()


func load_last_session() -> void:
	if not FileAccess.file_exists(_SAVE_PATH):
		last_session = {}
		return
	
	var file = FileAccess.open(_SAVE_PATH, FileAccess.READ)
	if file == null:
		last_session = {}
		return
	
	var content = file.get_as_text()
	file.close()
	
	var json = JSON.new()
	if json.parse(content) == OK:
		last_session = json.data
	else:
		last_session = {}
