tool
extends EditorPlugin

var TaskGraphData = load("res://addons/task_graph/task_graph_data.gd")

var editor_panel = preload("res://addons/task_graph/editor/task_graph_editor.tscn").instance()
var editor_panel_button

func _enter_tree():
	name = "TaskGraphPlugin"
	
	editor_panel_button = add_control_to_bottom_panel(editor_panel, "Task Graph")
	editor_panel_button.visible = false
	
	add_custom_type("TaskGraphData", "Resource", load("res://addons/task_graph/task_graph_data.gd"), preload("res://addons/task_graph/task_graph_data_icon.png"))
	add_custom_type("TaskManager", "Node", load("res://addons/task_graph/task_manager.gd"), preload("res://addons/task_graph/task_manager_icon.png"))
	

func _exit_tree():
	remove_control_from_bottom_panel(editor_panel)
	editor_panel.queue_free()
	remove_custom_type("TaskGraphData")
	remove_custom_type("TaskManager")

func handles(object):
	return object is TaskGraphData

func edit(object):
	editor_panel.get_node("GraphEdit").load_graph(object)

func make_visible(visible):
	editor_panel_button.visible = visible
	if not visible: editor_panel.visible = visible
