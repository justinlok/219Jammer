extends Area2D

export(int) var id = 0
onready var shape = get_node("CollisionShape2D")
var lock_portal = false
var exit_portal = false


func do_lock():
	lock_portal = true
	shape.set_deferred("disabled", true)

func unlock():
	lock_portal = false
	shape.set_deferred("disabled", false)
	


func _on_Portal_body_entered(body):
	# if self can be entered,
	# teleport to portal after self
	if !exit_portal:
		print("teleported")
		var go_one_more = false
		for portal in get_tree().get_nodes_in_group("portal"):
			if go_one_more:
					go_one_more = false
					portal.exit_portal = true
					body.set_position(portal.position)
					print("position moved")
			if portal == self:
				go_one_more = true
			
	


func _on_Portal_body_exited(body):
	#exiting from exit portal re-enables TP for that portal
	if exit_portal == true:
		print("exited")
		for portal in get_tree().get_nodes_in_group("portal"):
			exit_portal = false
